--
-- PostgreSQL database dump
--

\restrict OP74OrJAuvKcu844C2dgl2xpKBrlrDosor2mzzE0RbhR2frsjc2Ou9OhN6a8Qn0

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data (Community Edition)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: server_metrics; Type: TABLE; Schema: public; Owner: iot
--

CREATE TABLE public.server_metrics (
    "time" timestamp with time zone NOT NULL,
    device_id text NOT NULL,
    cpu_temp_c double precision,
    loadavg1 double precision,
    loadavg5 double precision,
    loadavg15 double precision,
    memory_used_percent double precision,
    disk_used_percent double precision,
    uptime_seconds bigint,
    node_red_received_at timestamp with time zone,
    ingest_latency_ms double precision,
    db_inserted_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.server_metrics OWNER TO iot;

--
-- Name: _hyper_1_1_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: iot
--

CREATE TABLE _timescaledb_internal._hyper_1_1_chunk (
    CONSTRAINT constraint_1 CHECK ((("time" >= '2026-05-07 00:00:00+00'::timestamp with time zone) AND ("time" < '2026-05-14 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.server_metrics);


ALTER TABLE _timescaledb_internal._hyper_1_1_chunk OWNER TO iot;

--
-- Name: _hyper_1_2_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: iot
--

CREATE TABLE _timescaledb_internal._hyper_1_2_chunk (
    CONSTRAINT constraint_2 CHECK ((("time" >= '2026-05-14 00:00:00+00'::timestamp with time zone) AND ("time" < '2026-05-21 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.server_metrics);


ALTER TABLE _timescaledb_internal._hyper_1_2_chunk OWNER TO iot;

--
-- Name: _hyper_1_3_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: iot
--

CREATE TABLE _timescaledb_internal._hyper_1_3_chunk (
    CONSTRAINT constraint_3 CHECK ((("time" >= '2026-05-21 00:00:00+00'::timestamp with time zone) AND ("time" < '2026-05-28 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.server_metrics);


ALTER TABLE _timescaledb_internal._hyper_1_3_chunk OWNER TO iot;

--
-- Name: _hyper_1_1_chunk db_inserted_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: iot
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_1_chunk ALTER COLUMN db_inserted_at SET DEFAULT now();


--
-- Name: _hyper_1_2_chunk db_inserted_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: iot
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_2_chunk ALTER COLUMN db_inserted_at SET DEFAULT now();


--
-- Name: _hyper_1_3_chunk db_inserted_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: iot
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_3_chunk ALTER COLUMN db_inserted_at SET DEFAULT now();


--
-- Name: _hyper_1_1_chunk 1_1_server_metrics_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: iot
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_1_chunk
    ADD CONSTRAINT "1_1_server_metrics_pkey" PRIMARY KEY ("time", device_id);


--
-- Name: _hyper_1_2_chunk 2_2_server_metrics_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: iot
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_2_chunk
    ADD CONSTRAINT "2_2_server_metrics_pkey" PRIMARY KEY ("time", device_id);


--
-- Name: _hyper_1_3_chunk 3_3_server_metrics_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: iot
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_3_chunk
    ADD CONSTRAINT "3_3_server_metrics_pkey" PRIMARY KEY ("time", device_id);


--
-- Name: server_metrics server_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: iot
--

ALTER TABLE ONLY public.server_metrics
    ADD CONSTRAINT server_metrics_pkey PRIMARY KEY ("time", device_id);


--
-- Name: _hyper_1_1_chunk_server_metrics_time_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: iot
--

CREATE INDEX _hyper_1_1_chunk_server_metrics_time_idx ON _timescaledb_internal._hyper_1_1_chunk USING btree ("time" DESC);


--
-- Name: _hyper_1_2_chunk_server_metrics_time_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: iot
--

CREATE INDEX _hyper_1_2_chunk_server_metrics_time_idx ON _timescaledb_internal._hyper_1_2_chunk USING btree ("time" DESC);


--
-- Name: _hyper_1_3_chunk_server_metrics_time_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: iot
--

CREATE INDEX _hyper_1_3_chunk_server_metrics_time_idx ON _timescaledb_internal._hyper_1_3_chunk USING btree ("time" DESC);


--
-- Name: server_metrics_time_idx; Type: INDEX; Schema: public; Owner: iot
--

CREATE INDEX server_metrics_time_idx ON public.server_metrics USING btree ("time" DESC);


--
-- PostgreSQL database dump complete
--

\unrestrict OP74OrJAuvKcu844C2dgl2xpKBrlrDosor2mzzE0RbhR2frsjc2Ou9OhN6a8Qn0

