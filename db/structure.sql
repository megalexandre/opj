SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addresses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    link character varying,
    place character varying,
    cep character varying,
    number character varying,
    address character varying,
    complement character varying,
    neighborhood character varying,
    city character varying,
    state character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: concessionaires; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.concessionaires (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying,
    acronym character varying,
    code character varying,
    region character varying,
    phone character varying,
    email character varying,
    active boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    address_id uuid NOT NULL,
    name character varying,
    email character varying,
    tax_id character varying,
    phone character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    client_id uuid NOT NULL,
    address_id uuid,
    utility_company character varying NOT NULL,
    utility_protocol character varying NOT NULL,
    customer_class character varying NOT NULL,
    integrator character varying NOT NULL,
    modality character varying NOT NULL,
    framework character varying NOT NULL,
    status character varying,
    amount numeric,
    dc_protection character varying,
    system_power double precision,
    unit_control character varying NOT NULL,
    description character varying(1024),
    project_type character varying NOT NULL,
    fast_track boolean DEFAULT false NOT NULL,
    coordinates public.geography(Point,4326),
    services_names character varying[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: concessionaires concessionaires_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.concessionaires
    ADD CONSTRAINT concessionaires_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_customers_on_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customers_on_address_id ON public.customers USING btree (address_id);


--
-- Name: index_customers_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_customers_on_email ON public.customers USING btree (email);


--
-- Name: index_customers_on_tax_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_customers_on_tax_id ON public.customers USING btree (tax_id);


--
-- Name: index_projects_on_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_address_id ON public.projects USING btree (address_id);


--
-- Name: index_projects_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_client_id ON public.projects USING btree (client_id);


--
-- Name: customers fk_rails_3f9404ba26; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT fk_rails_3f9404ba26 FOREIGN KEY (address_id) REFERENCES public.addresses(id);


--
-- Name: projects fk_rails_8d9657cec3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_8d9657cec3 FOREIGN KEY (client_id) REFERENCES public.customers(id);


--
-- Name: projects fk_rails_9d4278ee2d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_9d4278ee2d FOREIGN KEY (address_id) REFERENCES public.addresses(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20260502021250'),
('20260502020000'),
('20260502015902'),
('20260501223121'),
('20260501203600');

