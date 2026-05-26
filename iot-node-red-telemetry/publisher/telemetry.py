#!/usr/bin/env python3

import argparse
import json
import os
import shutil
import subprocess
import time
from datetime import datetime, timezone

import paho.mqtt.publish as publish

DEVICE_ID = "server01"

MQTT_HOST = ""	# Windows/Tailscale IP
MQTT_PORT = 1883
MQTT_TOPIC = "iot/group01/server01/telemetry"


def read_cpu_temp_c():
	"""
	Reads CPU package temperature from lm-sensors JSON output.
	Expected path:
	coretemp-isa-0000 -> Package id 0 -> temp1_input
	"""
	result = subprocess.run(
		["sensors", "-j"],
		capture_output=True,
		text=True,
		check=False
	)

	if not result.stdout.strip():
		return None

	data = json.loads(result.stdout)

	try:
		return float(data["coretemp-isa-0000"]["Package id 0"]["temp1_input"])
	except KeyError:
		return None


def read_memory_used_percent():
	"""
	Reads memory usage from /proc/meminfo without external dependencies.
	"""
	meminfo = {}

	with open("/proc/meminfo", "r") as f:
		for line in f:
			key, value = line.split(":", 1)
			meminfo[key] = int(value.strip().split()[0])

	total = meminfo["MemTotal"]
	available = meminfo["MemAvailable"]
	used = total - available

	return round((used / total) * 100, 2)


def read_disk_used_percent(path="/"):
	usage = shutil.disk_usage(path)
	return round((usage.used / usage.total) * 100, 2)


def read_uptime_seconds():
	with open("/proc/uptime", "r") as f:
		return int(float(f.readline().split()[0]))


def build_payload():
	loadavg1, loadavg5, loadavg15 = os.getloadavg()

	payload = {
		"device_id": DEVICE_ID,
		"timestamp": datetime.now(timezone.utc).isoformat(),
		"cpu_temp_c": read_cpu_temp_c(),
		"loadavg1": round(loadavg1, 2),
		"loadavg5": round(loadavg5, 2),
		"loadavg15": round(loadavg15, 2),
		"memory_used_percent": read_memory_used_percent(),
		"disk_used_percent": read_disk_used_percent("/"),
		"uptime_seconds": read_uptime_seconds()
	}

	return payload


def publish_payload(payload):
	payload_json = json.dumps(payload)

	publish.single(
		topic=MQTT_TOPIC,
		payload=payload_json,
		hostname=MQTT_HOST,
		port=MQTT_PORT,
		qos=1,
		retain=False
	)

	print(f"Published to {MQTT_TOPIC}: {payload_json}")


def main():
	parser = argparse.ArgumentParser(description="Linux server IOT telemetry publisher")
	parser.add_argument("--print", action="store_true", help="Print one telemetry payload")
	parser.add_argument("--publish", action="store_true", help="Publish one telemetry payload to MQTT")
	parser.add_argument("--loop", action="store_true", help="Continuously publish telemetry to MQTT")
	parser.add_argument("--interval", type=int, default=30, help="Publish interval in seconds")

	args = parser.parse_args()

	if args.print:
		print(json.dumps(build_payload(), indent=2))
		return

	if args.publish:
		publish_payload(build_payload())
		return

	if args.loop:
		while True:
			try:
				publish_payload(build_payload())
			except Exception as e:
				print(f"Publish failed: {e}")

			time.sleep(args.interval)
		return

	print(json.dumps(build_payload(), indent=2))


if __name__ == "__main__":
	main()
