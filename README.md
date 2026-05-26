# Extended Node-RED Data Flow for Edge Server Telemetry

This repository contains the source code and configuration files for the Internet of Things Technology mini-project.

## Contents

- `publisher/telemetry.py`: Python telemetry publisher running on the Linux edge server.
- `node-red/flows.json`: Exported Node-RED flows for MQTT ingestion, dashboard, database insertion, analytics, and REST API.
- `database/schema.sql`: TimescaleDB/PostgreSQL schema.

## System overview

A Linux edge server publishes telemetry over MQTT to Mosquitto. Node-RED subscribes to the telemetry topic, stores data in TimescaleDB, updates a dashboard, performs simple alerting, and exposes REST API endpoints.
