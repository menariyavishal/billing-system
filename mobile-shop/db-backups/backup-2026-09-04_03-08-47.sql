--
-- PostgreSQL database dump
--

\restrict QGtbUt8bgVMzbZa4nre6QX0u0hmdZgvD4wJvihyTzgkJKVNxVCukKSPga4xjS5z

-- Dumped from database version 18.6 (c5250a2)
-- Dumped by pg_dump version 18.6

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: bill_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bill_items (
    id integer NOT NULL,
    bill_id integer NOT NULL,
    product_id integer NOT NULL,
    product_unit_id integer,
    quantity integer NOT NULL,
    unit_price numeric(65,30) NOT NULL,
    line_total numeric(65,30) NOT NULL
);


--
-- Name: bill_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bill_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bill_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bill_items_id_seq OWNED BY public.bill_items.id;


--
-- Name: bills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bills (
    id integer NOT NULL,
    bill_number text NOT NULL,
    customer_id integer,
    created_by_user_id integer NOT NULL,
    subtotal numeric(65,30) NOT NULL,
    discount numeric(65,30) DEFAULT 0 NOT NULL,
    sgst_percent numeric(65,30) DEFAULT 0 NOT NULL,
    cgst_percent numeric(65,30) DEFAULT 0 NOT NULL,
    sgst_amount numeric(65,30) DEFAULT 0 NOT NULL,
    cgst_amount numeric(65,30) DEFAULT 0 NOT NULL,
    total_amount numeric(65,30) NOT NULL,
    paid_amount numeric(65,30) DEFAULT 0 NOT NULL,
    due_amount numeric(65,30) DEFAULT 0 NOT NULL,
    payment_status text DEFAULT 'PAID'::text NOT NULL,
    payment_mode text NOT NULL,
    status text NOT NULL,
    whatsapp_status text,
    whatsapp_sent_at timestamp(3) without time zone,
    is_settled boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: bills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bills_id_seq OWNED BY public.bills.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name text NOT NULL,
    parent_category_id integer,
    is_active boolean DEFAULT true NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name text,
    phone text,
    address text
);


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: finance_providers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.finance_providers (
    id integer NOT NULL,
    name text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: finance_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.finance_providers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: finance_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.finance_providers_id_seq OWNED BY public.finance_providers.id;


--
-- Name: finance_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.finance_records (
    id integer NOT NULL,
    bill_id integer NOT NULL,
    finance_provider_id integer NOT NULL,
    emi_amount numeric(65,30) NOT NULL,
    months integer,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: finance_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.finance_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: finance_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.finance_records_id_seq OWNED BY public.finance_records.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token text NOT NULL,
    expires_at timestamp(3) without time zone NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.password_reset_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.password_reset_tokens_id_seq OWNED BY public.password_reset_tokens.id;


--
-- Name: product_units; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_units (
    id integer NOT NULL,
    product_id integer NOT NULL,
    imei_number text NOT NULL,
    status text NOT NULL,
    cost_price numeric(65,30) NOT NULL,
    added_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sold_at timestamp(3) without time zone
);


--
-- Name: product_units_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_units_id_seq OWNED BY public.product_units.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    category_id integer NOT NULL,
    name text NOT NULL,
    barcode text,
    brand text,
    product_type text NOT NULL,
    cost_price numeric(65,30) NOT NULL,
    selling_price numeric(65,30) NOT NULL,
    quantity_in_stock integer DEFAULT 0 NOT NULL,
    low_stock_threshold integer DEFAULT 5 NOT NULL,
    image_url text,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: stock_in_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock_in_records (
    id integer NOT NULL,
    product_id integer NOT NULL,
    quantity_added integer NOT NULL,
    cost_price numeric(65,30) NOT NULL,
    added_by_user_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: stock_in_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stock_in_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_in_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stock_in_records_id_seq OWNED BY public.stock_in_records.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    username text NOT NULL,
    email text,
    password_hash text NOT NULL,
    role text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: whatsapp_audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.whatsapp_audit_logs (
    id integer NOT NULL,
    bill_id integer NOT NULL,
    bill_number text NOT NULL,
    event text NOT NULL,
    details text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: whatsapp_audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.whatsapp_audit_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: whatsapp_audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.whatsapp_audit_logs_id_seq OWNED BY public.whatsapp_audit_logs.id;


--
-- Name: whatsapp_deliveries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.whatsapp_deliveries (
    id integer NOT NULL,
    bill_id integer NOT NULL,
    bill_number text NOT NULL,
    customer_name text NOT NULL,
    mobile_number text NOT NULL,
    pdf_path text NOT NULL,
    custom_message text,
    status text DEFAULT 'pending'::text NOT NULL,
    failure_reason text,
    sent_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: whatsapp_deliveries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.whatsapp_deliveries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: whatsapp_deliveries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.whatsapp_deliveries_id_seq OWNED BY public.whatsapp_deliveries.id;


--
-- Name: whatsapp_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.whatsapp_settings (
    id integer NOT NULL,
    owner_phone text DEFAULT '6375591682'::text NOT NULL,
    status text DEFAULT 'disconnected'::text NOT NULL,
    qr_code text,
    simulate_failures boolean DEFAULT false NOT NULL,
    simulate_session_error boolean DEFAULT false NOT NULL
);


--
-- Name: whatsapp_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.whatsapp_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: whatsapp_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.whatsapp_settings_id_seq OWNED BY public.whatsapp_settings.id;


--
-- Name: bill_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill_items ALTER COLUMN id SET DEFAULT nextval('public.bill_items_id_seq'::regclass);


--
-- Name: bills id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bills ALTER COLUMN id SET DEFAULT nextval('public.bills_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: finance_providers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.finance_providers ALTER COLUMN id SET DEFAULT nextval('public.finance_providers_id_seq'::regclass);


--
-- Name: finance_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.finance_records ALTER COLUMN id SET DEFAULT nextval('public.finance_records_id_seq'::regclass);


--
-- Name: password_reset_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens ALTER COLUMN id SET DEFAULT nextval('public.password_reset_tokens_id_seq'::regclass);


--
-- Name: product_units id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_units ALTER COLUMN id SET DEFAULT nextval('public.product_units_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: stock_in_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_in_records ALTER COLUMN id SET DEFAULT nextval('public.stock_in_records_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: whatsapp_audit_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_audit_logs ALTER COLUMN id SET DEFAULT nextval('public.whatsapp_audit_logs_id_seq'::regclass);


--
-- Name: whatsapp_deliveries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_deliveries ALTER COLUMN id SET DEFAULT nextval('public.whatsapp_deliveries_id_seq'::regclass);


--
-- Name: whatsapp_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_settings ALTER COLUMN id SET DEFAULT nextval('public.whatsapp_settings_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
5919264e-f32a-4973-a242-cd175dc75bfb	00f02f3b304732dc625deb598edaeb3c3ecc614701ae978286436b7ea8d0aad0	2026-07-05 08:01:40.320245+00	20260705080138_init	\N	\N	2026-07-05 08:01:39.053326+00	1
\.


--
-- Data for Name: bill_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bill_items (id, bill_id, product_id, product_unit_id, quantity, unit_price, line_total) FROM stdin;
7	7	1	\N	1	90000.000000000000000000000000000000	90000.000000000000000000000000000000
8	8	1	\N	1	90000.000000000000000000000000000000	90000.000000000000000000000000000000
10	10	5	3	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
11	11	5	2	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
12	12	5	4	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
13	12	5	1	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
14	12	5	5	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
15	12	5	6	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
16	12	5	7	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
17	12	1	\N	2	90000.000000000000000000000000000000	180000.000000000000000000000000000000
18	13	5	14	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
19	14	6	\N	2	700.000000000000000000000000000000	1400.000000000000000000000000000000
20	15	1	\N	1	90000.000000000000000000000000000000	90000.000000000000000000000000000000
21	16	5	8	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
22	17	5	9	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
23	18	5	10	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
24	18	5	12	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
25	18	1	\N	1	90000.000000000000000000000000000000	90000.000000000000000000000000000000
26	19	5	11	1	50000.000000000000000000000000000000	50000.000000000000000000000000000000
27	20	10	21	1	52000.000000000000000000000000000000	52000.000000000000000000000000000000
28	21	10	22	1	52000.000000000000000000000000000000	52000.000000000000000000000000000000
29	22	10	23	1	52000.000000000000000000000000000000	52000.000000000000000000000000000000
30	23	6	\N	5	700.000000000000000000000000000000	3500.000000000000000000000000000000
31	24	6	\N	2	700.000000000000000000000000000000	1400.000000000000000000000000000000
32	25	10	25	1	52000.000000000000000000000000000000	52000.000000000000000000000000000000
33	25	3	\N	1	80000.000000000000000000000000000000	80000.000000000000000000000000000000
34	26	10	26	1	52000.000000000000000000000000000000	52000.000000000000000000000000000000
35	26	3	\N	1	80000.000000000000000000000000000000	80000.000000000000000000000000000000
36	27	10	27	1	52000.000000000000000000000000000000	52000.000000000000000000000000000000
37	28	10	28	1	52000.000000000000000000000000000000	52000.000000000000000000000000000000
38	29	10	29	1	52000.000000000000000000000000000000	52000.000000000000000000000000000000
\.


--
-- Data for Name: bills; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bills (id, bill_number, customer_id, created_by_user_id, subtotal, discount, sgst_percent, cgst_percent, sgst_amount, cgst_amount, total_amount, paid_amount, due_amount, payment_status, payment_mode, status, whatsapp_status, whatsapp_sent_at, is_settled, created_at) FROM stdin;
22	314	3	1	42372.881355932210000000000000000000	2000.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	3813.559322033899000000000000000000	3813.559322033899000000000000000000	50000.000000000000000000000000000000	50000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-08-05 11:47:44.501
23	QS-101	\N	1	3500.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	3500.000000000000000000000000000000	3500.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	\N	\N	f	2026-08-05 11:52:13.496
24	QS-102	\N	1	1400.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	1400.000000000000000000000000000000	1400.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	\N	\N	f	2026-08-07 17:38:02.793
7	301	1	1	76271.186440677960000000000000000000	0.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	6864.406779661016000000000000000000	6864.406779661016000000000000000000	90000.000000000000000000000000000000	90000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-07-08 09:05:53.256
25	315	3	1	111864.406779661000000000000000000000	0.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	10067.796610169490000000000000000000	10067.796610169490000000000000000000	132000.000000000000000000000000000000	132000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-08-07 17:40:24.328
8	302	1	1	90000.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	90000.000000000000000000000000000000	90000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-07-09 09:54:16.602
10	303	3	1	50000.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	50000.000000000000000000000000000000	50000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-07-12 13:50:46.396
11	304	3	1	50000.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	50000.000000000000000000000000000000	50000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-07-12 14:10:26.062
12	305	3	1	430000.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	430000.000000000000000000000000000000	430000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-07-12 14:43:30.747
13	306	3	1	42372.881355932210000000000000000000	0.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	3813.559322033899000000000000000000	3813.559322033899000000000000000000	50000.000000000000000000000000000000	50000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-07-29 16:39:37.343
14	QS-100	\N	1	1400.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	1400.000000000000000000000000000000	1400.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	\N	\N	f	2026-07-29 16:41:42.08
15	307	3	1	76271.186440677960000000000000000000	0.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	6864.406779661016000000000000000000	6864.406779661016000000000000000000	90000.000000000000000000000000000000	90000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-07-29 17:02:58.433
16	308	3	1	42372.881355932210000000000000000000	0.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	3813.559322033899000000000000000000	3813.559322033899000000000000000000	50000.000000000000000000000000000000	50000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	t	2026-07-29 17:03:57.662
17	309	3	1	50000.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	50000.000000000000000000000000000000	50000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	finance	completed	failed	\N	f	2026-07-29 17:06:00.24
18	310	3	1	161016.949152542400000000000000000000	0.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	14491.525423728820000000000000000000	14491.525423728820000000000000000000	190000.000000000000000000000000000000	190000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-07-29 17:25:49.223
27	317	3	1	44067.796610169490000000000000000000	0.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	3966.101694915254000000000000000000	3966.101694915254000000000000000000	52000.000000000000000000000000000000	0.000000000000000000000000000000	52000.000000000000000000000000000000	PARTIAL	cash	completed	failed	\N	f	2026-08-31 09:08:35.269
19	311	3	1	50000.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	50000.000000000000000000000000000000	50000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-07-31 07:42:02.895
20	312	3	1	44067.796610169490000000000000000000	0.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	3966.101694915254000000000000000000	3966.101694915254000000000000000000	52000.000000000000000000000000000000	52000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-07-31 08:24:38.97
21	313	3	1	42372.881355932210000000000000000000	2000.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	3813.559322033899000000000000000000	3813.559322033899000000000000000000	50000.000000000000000000000000000000	50000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	failed	\N	f	2026-08-05 11:31:22.627
29	319	3	1	44067.796610169490000000000000000000	0.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	3966.101694915254000000000000000000	3966.101694915254000000000000000000	52000.000000000000000000000000000000	25000.000000000000000000000000000000	27000.000000000000000000000000000000	PARTIAL	cash	completed	failed	\N	f	2026-08-31 09:20:01.28
28	318	3	1	44067.796610169490000000000000000000	0.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	3966.101694915254000000000000000000	3966.101694915254000000000000000000	52000.000000000000000000000000000000	52000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	sent	2026-09-01 16:25:10.929	f	2026-08-31 09:18:52.821
26	316	3	1	110169.491525423700000000000000000000	2000.000000000000000000000000000000	9.000000000000000000000000000000	9.000000000000000000000000000000	9915.254237288134000000000000000000	9915.254237288134000000000000000000	130000.000000000000000000000000000000	130000.000000000000000000000000000000	0.000000000000000000000000000000	PAID	cash	completed	sent	2026-09-01 16:32:26.68	f	2026-08-07 17:41:56.521
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, name, parent_category_id, is_active) FROM stdin;
4	Apple	1	t
5	Samsung	1	t
6	Oppo	1	t
7	Vivo	1	t
8	Motorola	1	t
9	Poco	1	t
10	Tecno	1	t
11	Mi	1	t
12	Itel	1	t
13	Charger	2	t
14	Mobile Cover	2	t
15	Speaker	2	t
16	Headphones	2	t
17	Smart Watches	2	t
18	Computers & IT Hardware	\N	t
19	Home Appliances	\N	t
20	Entertainment	\N	t
1	Mobile	\N	t
2	Accessories	\N	t
21	Electronics	\N	t
22	Computers & IT Hardware	21	t
23	Home Appliances	21	t
24	Entertainment	21	t
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customers (id, name, phone, address) FROM stdin;
1	Lalit Menariya	8955531832	kanore,dungla,312402
3	Vishal Menariya	6375591682	dfvgbhnjmk
\.


--
-- Data for Name: finance_providers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.finance_providers (id, name, is_active, created_at) FROM stdin;
1	Bajaj	t	2026-07-29 17:05:25.979
\.


--
-- Data for Name: finance_records; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.finance_records (id, bill_id, finance_provider_id, emi_amount, months, created_at) FROM stdin;
1	17	1	12500.000000000000000000000000000000	8	2026-07-29 17:06:00.24
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_reset_tokens (id, user_id, token, expires_at, created_at) FROM stdin;
\.


--
-- Data for Name: product_units; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_units (id, product_id, imei_number, status, cost_price, added_at, sold_at) FROM stdin;
3	5	359123456789014	sold	45000.000000000000000000000000000000	2026-07-11 11:53:57.428	2026-07-12 13:50:46.158
2	5	359123456789013	sold	45000.000000000000000000000000000000	2026-07-11 11:53:57.428	2026-07-12 14:10:25.019
4	5	359123456789015	sold	45000.000000000000000000000000000000	2026-07-11 11:53:57.428	2026-07-12 14:43:23.793
1	5	359123456789016	sold	45000.000000000000000000000000000000	2026-07-11 11:53:57.428	2026-07-12 14:43:25.316
5	5	359123456789017	sold	45000.000000000000000000000000000000	2026-07-12 14:24:05.156	2026-07-12 14:43:26.91
6	5	359123456789018	sold	45000.000000000000000000000000000000	2026-07-12 14:24:05.156	2026-07-12 14:43:28.579
7	5	359123456789019	sold	45000.000000000000000000000000000000	2026-07-12 14:24:05.156	2026-07-12 14:43:29.481
14	5	359123456789026	sold	45000.000000000000000000000000000000	2026-07-12 14:52:11.059	2026-07-29 16:39:37.179
8	5	359123456789020	sold	45000.000000000000000000000000000000	2026-07-12 14:24:05.156	2026-07-29 17:03:56.899
9	5	359123456789021	sold	45000.000000000000000000000000000000	2026-07-12 14:52:11.059	2026-07-29 17:05:59.638
10	5	359123456789022	sold	45000.000000000000000000000000000000	2026-07-12 14:52:11.059	2026-07-29 17:25:46.945
12	5	359123456789024	sold	45000.000000000000000000000000000000	2026-07-12 14:52:11.059	2026-07-29 17:25:48.1
11	5	359123456789023	sold	45000.000000000000000000000000000000	2026-07-12 14:52:11.059	2026-07-31 07:42:02.732
21	10	311247784564624	sold	50000.000000000000000000000000000000	2026-07-31 08:20:09.585	2026-07-31 08:24:38.818
22	10	311247794564726	sold	50000.000000000000000000000000000000	2026-07-31 08:20:09.585	2026-08-05 11:31:22.484
23	10	311247794564727	sold	40000.000000000000000000000000000000	2026-08-05 11:24:43.144	2026-08-05 11:47:44.344
25	10	354999745633210	sold	40000.000000000000000000000000000000	2026-08-07 17:27:03.768	2026-08-07 17:40:24.03
26	10	354999745633211	sold	40000.000000000000000000000000000000	2026-08-07 17:27:03.768	2026-08-07 17:41:56.245
27	10	354999745633212	sold	40000.000000000000000000000000000000	2026-08-07 17:27:03.768	2026-08-31 09:08:34.839
28	10	354999745633214	sold	44000.000000000000000000000000000000	2026-08-07 17:27:03.768	2026-08-31 09:18:52.26
29	10	354999745633215	sold	50000.000000000000000000000000000000	2026-08-07 17:27:03.768	2026-08-31 09:20:01.119
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, category_id, name, barcode, brand, product_type, cost_price, selling_price, quantity_in_stock, low_stock_threshold, image_url, is_active, created_at, updated_at) FROM stdin;
6	13	d20	\N	cpp	quantity	500.000000000000000000000000000000	700.000000000000000000000000000000	1	2	\N	t	2026-07-29 16:41:03.656	2026-08-07 17:38:02.628
3	5	samsung s20 Ultra	\N	samsung	quantity	50000.000000000000000000000000000000	80000.000000000000000000000000000000	5	2	\N	t	2026-07-10 14:34:51.878	2026-08-07 17:41:56.45
2	13	charger 120W	\N	XYZ	quantity	150.000000000000000000000000000000	250.000000000000000000000000000000	3	5	\N	f	2026-07-07 20:25:19.381	2026-07-10 14:33:45.819
4	6	a36	\N	oppo	quantity	46000.000000000000000000000000000000	48000.000000000000000000000000000000	5	2	\N	t	2026-07-10 14:35:50.451	2026-07-10 14:35:51.662
10	4	iphone 15pro max	\N	apple	serialized	50000.000000000000000000000000000000	52000.000000000000000000000000000000	0	2	\N	t	2026-07-31 08:20:09.511	2026-08-31 09:20:01.199
1	4	iphone 17 pro max	\N	Apple	quantity	70000.000000000000000000000000000000	90000.000000000000000000000000000000	0	5	\N	t	2026-07-06 14:39:31.441	2026-07-29 17:25:48.722
5	4	iphone 15pro max	\N	apple	serialized	45000.000000000000000000000000000000	50000.000000000000000000000000000000	0	2	\N	f	2026-07-11 11:53:57.107	2026-07-31 08:17:17.866
\.


--
-- Data for Name: stock_in_records; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stock_in_records (id, product_id, quantity_added, cost_price, added_by_user_id, created_at) FROM stdin;
1	1	10	70000.000000000000000000000000000000	1	2026-07-06 14:39:31.588
2	2	10	150.000000000000000000000000000000	1	2026-07-07 20:25:19.621
3	3	2	50000.000000000000000000000000000000	1	2026-07-10 14:34:51.985
4	4	5	46000.000000000000000000000000000000	1	2026-07-10 14:35:50.902
5	5	4	45000.000000000000000000000000000000	1	2026-07-11 11:53:57.727
6	5	4	45000.000000000000000000000000000000	1	2026-07-12 14:24:05.287
8	6	10	500.000000000000000000000000000000	1	2026-07-29 16:41:03.745
11	10	2	50000.000000000000000000000000000000	1	2026-07-31 08:20:09.658
12	10	1	40000.000000000000000000000000000000	1	2026-08-05 11:24:43.224
13	10	5	40000.000000000000000000000000000000	1	2026-08-07 17:27:04.16
14	3	5	50000.000000000000000000000000000000	1	2026-08-07 17:38:40.396
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, username, email, password_hash, role, is_active, created_at) FROM stdin;
1	Owner	admin	kahibhiloginkarlo69@gmail.com	$2b$10$GKwbFbBG8CFIhfIbNOj2V.HZn6Lf.eQej8Z2pR2fFA99X7qUjk1zG	owner	t	2026-07-05 15:06:56.325
2	Staff Member	staff	\N	$2b$10$B7TIDJKNQMyZs0HD9eWOROivLYqJ1wHpY7bMY4GdSCgoqzT0C/yCa	staff	f	2026-07-05 15:06:59.695
11	vishal menariya	vish	\N	$2b$10$SaveGxSU6XTYH/HlO/Fu8udifBJNtQg/fsq10OwMCgsyuXPD0IHMm	staff	f	2026-08-11 14:31:14.144
\.


--
-- Data for Name: whatsapp_audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.whatsapp_audit_logs (id, bill_id, bill_number, event, details, created_at) FROM stdin;
1	4	304	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-07 21:53:58.772
2	4	304	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-07 21:53:59.771
3	4	304	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-07 21:54:00.166
4	5	305	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-07 22:22:18.176
5	5	305	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-07 22:22:18.735
6	5	305	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-07 22:22:19.197
7	6	306	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-07 22:53:59.416
8	6	306	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-07 22:53:59.904
9	6	306	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-07 22:54:00.305
10	7	301	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-08 09:05:57.538
11	7	301	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-08 09:05:58.581
12	7	301	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-08 09:05:59.502
13	8	302	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-09 09:54:22.82
14	8	302	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-09 09:54:23.779
15	8	302	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-09 09:54:24.579
16	10	303	WhatsApp Queued	Invoice PDF delivery queued for vishal menariya (6375591682)	2026-07-12 13:50:49.955
17	10	303	WhatsApp Attempted	Attempting to send PDF to customer vishal menariya (6375591682)	2026-07-12 13:50:50.436
18	10	303	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-12 13:50:50.809
19	11	304	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-12 14:10:30.619
20	11	304	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-12 14:10:31.985
21	11	304	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-12 14:10:33.261
22	12	305	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-12 14:43:39.236
23	12	305	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-12 14:43:39.668
24	12	305	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-12 14:43:39.999
25	13	306	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-29 16:39:40.231
26	13	306	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-29 16:39:40.58
27	13	306	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-29 16:39:40.85
28	15	307	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-29 17:03:01.715
29	15	307	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-29 17:03:02.163
30	15	307	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-29 17:03:02.798
31	16	308	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-29 17:04:00.256
32	16	308	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-29 17:04:00.598
33	16	308	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-29 17:04:00.874
34	17	309	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-29 17:06:02.256
35	17	309	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-29 17:06:02.662
36	17	309	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-29 17:06:03.042
37	18	310	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-29 17:25:53.941
38	18	310	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-29 17:25:54.552
39	18	310	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-29 17:25:55.086
40	19	311	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-31 07:42:05.606
41	19	311	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-31 07:42:05.945
42	19	311	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-31 07:42:06.217
43	20	312	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-07-31 08:24:40.371
44	20	312	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-07-31 08:24:40.655
45	20	312	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-07-31 08:24:40.893
46	21	313	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-08-05 11:31:25.383
47	21	313	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-08-05 11:31:25.656
48	21	313	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-08-05 11:31:25.856
49	22	314	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-08-05 11:47:45.74
50	22	314	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-08-05 11:47:45.999
51	22	314	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-08-05 11:47:46.19
52	25	315	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-08-07 17:40:26.886
53	25	315	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-08-07 17:40:27.165
54	25	315	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-08-07 17:40:27.413
55	26	316	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-08-07 17:41:57.638
56	26	316	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-08-07 17:41:57.927
57	26	316	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-08-07 17:41:58.125
58	16	308	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-08-10 13:46:00.406
59	16	308	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-08-10 13:46:01.282
60	16	308	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-08-10 13:46:01.937
61	27	317	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-08-31 09:08:41.419
62	27	317	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-08-31 09:08:42.331
63	27	317	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-08-31 09:08:42.973
64	28	318	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-08-31 09:18:58.63
65	28	318	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-08-31 09:19:00.256
66	28	318	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-08-31 09:19:01.567
67	29	319	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-08-31 09:20:02.992
68	29	319	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-08-31 09:20:04.055
69	29	319	WhatsApp Failed	Delivery failed to 6375591682. Reason: Session Not Connected	2026-08-31 09:20:05.051
70	28	318	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-09-01 16:25:08.204
71	28	318	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-09-01 16:25:09.083
72	28	318	WhatsApp Sent	PDF delivered successfully to 6375591682	2026-09-01 16:25:11.149
73	26	316	WhatsApp Queued	Invoice PDF delivery queued for Vishal Menariya (6375591682)	2026-09-01 16:32:17.604
74	26	316	WhatsApp Attempted	Attempting to send PDF to customer Vishal Menariya (6375591682)	2026-09-01 16:32:18.538
75	26	316	WhatsApp Sent	PDF delivered successfully to 6375591682	2026-09-01 16:32:26.915
\.


--
-- Data for Name: whatsapp_deliveries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.whatsapp_deliveries (id, bill_id, bill_number, customer_name, mobile_number, pdf_path, custom_message, status, failure_reason, sent_at, created_at) FROM stdin;
1	4	304	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_304.pdf	\N	failed	Session Not Connected	\N	2026-07-07 21:53:58.376
2	5	305	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_305.pdf	\N	failed	Session Not Connected	\N	2026-07-07 22:22:17.906
3	6	306	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_306.pdf	\N	failed	Session Not Connected	\N	2026-07-07 22:53:59.149
4	7	301	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_301.pdf	\N	failed	Session Not Connected	\N	2026-07-08 09:05:56.814
5	8	302	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_302.pdf	\N	failed	Session Not Connected	\N	2026-07-09 09:54:22.28
6	10	303	vishal menariya	6375591682	uploads/invoices/SKC_Invoice_303.pdf	\N	failed	Session Not Connected	\N	2026-07-12 13:50:49.718
7	11	304	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_304.pdf	\N	failed	Session Not Connected	\N	2026-07-12 14:10:30.084
8	12	305	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_305.pdf	\N	failed	Session Not Connected	\N	2026-07-12 14:43:38.115
9	13	306	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_306.pdf	\N	failed	Session Not Connected	\N	2026-07-29 16:39:40.026
10	15	307	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_307.pdf	\N	failed	Session Not Connected	\N	2026-07-29 17:03:01.378
11	16	308	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_308.pdf	\N	failed	Session Not Connected	\N	2026-07-29 17:03:59.971
12	17	309	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_309.pdf	\N	failed	Session Not Connected	\N	2026-07-29 17:06:02.076
13	18	310	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_310.pdf	\N	failed	Session Not Connected	\N	2026-07-29 17:25:53.264
14	19	311	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_311.pdf	\N	failed	Session Not Connected	\N	2026-07-31 07:42:05.434
15	20	312	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_312.pdf	\N	failed	Session Not Connected	\N	2026-07-31 08:24:40.235
16	21	313	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_313.pdf	\N	failed	Session Not Connected	\N	2026-08-05 11:31:25.236
17	22	314	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_314.pdf	\N	failed	Session Not Connected	\N	2026-08-05 11:47:45.61
18	25	315	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_315.pdf	\N	failed	Session Not Connected	\N	2026-08-07 17:40:26.738
19	26	316	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_316.pdf	\N	failed	Session Not Connected	\N	2026-08-07 17:41:57.506
20	16	308	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_308.pdf	🎉 *Payment Successful!*\r\n\r\nHello Vishal Menariya,\r\nYour payment of ₹25000 for Invoice #308 has been completely settled.\r\n\r\nThank you for choosing *Shree Krishna Computer*.	failed	Session Not Connected	\N	2026-08-10 13:45:59.949
21	27	317	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_317.pdf	\N	failed	Session Not Connected	\N	2026-08-31 09:08:40.97
22	28	318	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_318.pdf	\N	failed	Session Not Connected	\N	2026-08-31 09:18:58.016
23	29	319	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_319.pdf	\N	failed	Session Not Connected	\N	2026-08-31 09:20:02.404
24	28	318	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_318.pdf	\N	sent	\N	2026-09-01 16:25:10.709	2026-09-01 16:25:07.095
25	26	316	Vishal Menariya	6375591682	uploads/invoices/SKC_Invoice_316.pdf	\N	sent	\N	2026-09-01 16:32:26.446	2026-09-01 16:32:17.136
\.


--
-- Data for Name: whatsapp_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.whatsapp_settings (id, owner_phone, status, qr_code, simulate_failures, simulate_session_error) FROM stdin;
1	9928203203	disconnected	\N	f	f
\.


--
-- Name: bill_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bill_items_id_seq', 38, true);


--
-- Name: bills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bills_id_seq', 29, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 24, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customers_id_seq', 3, true);


--
-- Name: finance_providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.finance_providers_id_seq', 1, true);


--
-- Name: finance_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.finance_records_id_seq', 1, true);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.password_reset_tokens_id_seq', 3, true);


--
-- Name: product_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_units_id_seq', 29, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 10, true);


--
-- Name: stock_in_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stock_in_records_id_seq', 14, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 11, true);


--
-- Name: whatsapp_audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.whatsapp_audit_logs_id_seq', 75, true);


--
-- Name: whatsapp_deliveries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.whatsapp_deliveries_id_seq', 25, true);


--
-- Name: whatsapp_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.whatsapp_settings_id_seq', 1, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: bill_items bill_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill_items
    ADD CONSTRAINT bill_items_pkey PRIMARY KEY (id);


--
-- Name: bills bills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT bills_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: finance_providers finance_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.finance_providers
    ADD CONSTRAINT finance_providers_pkey PRIMARY KEY (id);


--
-- Name: finance_records finance_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.finance_records
    ADD CONSTRAINT finance_records_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);


--
-- Name: product_units product_units_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_units
    ADD CONSTRAINT product_units_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: stock_in_records stock_in_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_in_records
    ADD CONSTRAINT stock_in_records_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: whatsapp_audit_logs whatsapp_audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_audit_logs
    ADD CONSTRAINT whatsapp_audit_logs_pkey PRIMARY KEY (id);


--
-- Name: whatsapp_deliveries whatsapp_deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_deliveries
    ADD CONSTRAINT whatsapp_deliveries_pkey PRIMARY KEY (id);


--
-- Name: whatsapp_settings whatsapp_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_settings
    ADD CONSTRAINT whatsapp_settings_pkey PRIMARY KEY (id);


--
-- Name: bills_bill_number_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX bills_bill_number_key ON public.bills USING btree (bill_number);


--
-- Name: finance_providers_name_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX finance_providers_name_key ON public.finance_providers USING btree (name);


--
-- Name: finance_records_bill_id_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX finance_records_bill_id_key ON public.finance_records USING btree (bill_id);


--
-- Name: password_reset_tokens_token_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX password_reset_tokens_token_key ON public.password_reset_tokens USING btree (token);


--
-- Name: product_units_imei_number_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX product_units_imei_number_key ON public.product_units USING btree (imei_number);


--
-- Name: products_barcode_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX products_barcode_key ON public.products USING btree (barcode);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: users_username_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_username_key ON public.users USING btree (username);


--
-- Name: bill_items bill_items_bill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill_items
    ADD CONSTRAINT bill_items_bill_id_fkey FOREIGN KEY (bill_id) REFERENCES public.bills(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: bill_items bill_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill_items
    ADD CONSTRAINT bill_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: bill_items bill_items_product_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bill_items
    ADD CONSTRAINT bill_items_product_unit_id_fkey FOREIGN KEY (product_unit_id) REFERENCES public.product_units(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: bills bills_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT bills_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: bills bills_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT bills_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: categories categories_parent_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_parent_category_id_fkey FOREIGN KEY (parent_category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: finance_records finance_records_bill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.finance_records
    ADD CONSTRAINT finance_records_bill_id_fkey FOREIGN KEY (bill_id) REFERENCES public.bills(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: finance_records finance_records_finance_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.finance_records
    ADD CONSTRAINT finance_records_finance_provider_id_fkey FOREIGN KEY (finance_provider_id) REFERENCES public.finance_providers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: password_reset_tokens password_reset_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: product_units product_units_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_units
    ADD CONSTRAINT product_units_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: stock_in_records stock_in_records_added_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_in_records
    ADD CONSTRAINT stock_in_records_added_by_user_id_fkey FOREIGN KEY (added_by_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: stock_in_records stock_in_records_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_in_records
    ADD CONSTRAINT stock_in_records_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict QGtbUt8bgVMzbZa4nre6QX0u0hmdZgvD4wJvihyTzgkJKVNxVCukKSPga4xjS5z

