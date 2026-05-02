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
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA tiger;


--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA topology;


--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


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
    updated_at timestamp(6) without time zone NOT NULL,
    created_by uuid,
    updated_by uuid
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
    updated_at timestamp(6) without time zone NOT NULL,
    created_by uuid,
    updated_by uuid
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
    updated_at timestamp(6) without time zone NOT NULL,
    created_by uuid,
    updated_by uuid
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
    updated_at timestamp(6) without time zone NOT NULL,
    created_by uuid,
    updated_by uuid
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: uploads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uploads (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    item_id uuid NOT NULL,
    filename character varying NOT NULL,
    s3_url character varying NOT NULL,
    s3_key character varying NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    created_by uuid,
    updated_by uuid
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    password_digest character varying NOT NULL,
    profile character varying DEFAULT 'user'::character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
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
-- Name: uploads uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploads
    ADD CONSTRAINT uploads_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


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
-- Name: index_uploads_on_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uploads_on_item_id ON public.uploads USING btree (item_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: projects fk_rails_0a17d69f55; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_0a17d69f55 FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: concessionaires fk_rails_0d8ecb3780; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.concessionaires
    ADD CONSTRAINT fk_rails_0d8ecb3780 FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: customers fk_rails_0fceac5ea7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT fk_rails_0fceac5ea7 FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: customers fk_rails_36c947031b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT fk_rails_36c947031b FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: customers fk_rails_3f9404ba26; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT fk_rails_3f9404ba26 FOREIGN KEY (address_id) REFERENCES public.addresses(id);


--
-- Name: addresses fk_rails_4aa2d705a5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fk_rails_4aa2d705a5 FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: addresses fk_rails_727063a9f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fk_rails_727063a9f1 FOREIGN KEY (updated_by) REFERENCES public.users(id);


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
-- Name: uploads fk_rails_bbbb2854e0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploads
    ADD CONSTRAINT fk_rails_bbbb2854e0 FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: concessionaires fk_rails_e6922b7e80; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.concessionaires
    ADD CONSTRAINT fk_rails_e6922b7e80 FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: uploads fk_rails_eb1978731c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploads
    ADD CONSTRAINT fk_rails_eb1978731c FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: projects fk_rails_eda740735f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_eda740735f FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public, tiger, topology;

INSERT INTO "schema_migrations" (version) VALUES
('20260502200001'),
('20260502200000'),
('20260502113002'),
('20260502021250'),
('20260502020000'),
('20260502015902'),
('20260501223121'),
('20260501203600');

