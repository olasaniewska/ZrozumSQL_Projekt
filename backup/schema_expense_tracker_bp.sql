--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0 (Debian 13.0-1.pgdg100+1)
-- Dumped by pg_dump version 13.0

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
-- Name: expense_tracker; Type: SCHEMA; Schema: -; Owner: expense_tracker_group
--

CREATE SCHEMA expense_tracker;


ALTER SCHEMA expense_tracker OWNER TO expense_tracker_group;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bank_account_owner; Type: TABLE; Schema: expense_tracker; Owner: postgres
--

CREATE TABLE expense_tracker.bank_account_owner (
    id_ba_own integer NOT NULL,
    owner_name character varying(50) NOT NULL,
    owner_desc character varying(250),
    user_login character varying(50) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.bank_account_owner OWNER TO postgres;

--
-- Name: bank_account_owner_id_ba_own_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: postgres
--

CREATE SEQUENCE expense_tracker.bank_account_owner_id_ba_own_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.bank_account_owner_id_ba_own_seq OWNER TO postgres;

--
-- Name: bank_account_owner_id_ba_own_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: postgres
--

ALTER SEQUENCE expense_tracker.bank_account_owner_id_ba_own_seq OWNED BY expense_tracker.bank_account_owner.id_ba_own;


--
-- Name: bank_account_types; Type: TABLE; Schema: expense_tracker; Owner: postgres
--

CREATE TABLE expense_tracker.bank_account_types (
    id_ba_type integer NOT NULL,
    ba_type character varying(50) NOT NULL,
    ba_desc character varying(250),
    active boolean DEFAULT true NOT NULL,
    is_common_account boolean DEFAULT false NOT NULL,
    id_ba_own integer,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.bank_account_types OWNER TO postgres;

--
-- Name: bank_account_types_id_ba_type_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: postgres
--

CREATE SEQUENCE expense_tracker.bank_account_types_id_ba_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.bank_account_types_id_ba_type_seq OWNER TO postgres;

--
-- Name: bank_account_types_id_ba_type_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: postgres
--

ALTER SEQUENCE expense_tracker.bank_account_types_id_ba_type_seq OWNED BY expense_tracker.bank_account_types.id_ba_type;


--
-- Name: transaction_bank_accounts; Type: TABLE; Schema: expense_tracker; Owner: postgres
--

CREATE TABLE expense_tracker.transaction_bank_accounts (
    id_trans_ba integer NOT NULL,
    id_ba_own integer,
    id_ba_type integer,
    bank_account_name character varying(50) NOT NULL,
    bank_account_desc character varying(250),
    active boolean DEFAULT true NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.transaction_bank_accounts OWNER TO postgres;

--
-- Name: transaction_bank_accounts_id_trans_ba_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: postgres
--

CREATE SEQUENCE expense_tracker.transaction_bank_accounts_id_trans_ba_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.transaction_bank_accounts_id_trans_ba_seq OWNER TO postgres;

--
-- Name: transaction_bank_accounts_id_trans_ba_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: postgres
--

ALTER SEQUENCE expense_tracker.transaction_bank_accounts_id_trans_ba_seq OWNED BY expense_tracker.transaction_bank_accounts.id_trans_ba;


--
-- Name: transaction_category; Type: TABLE; Schema: expense_tracker; Owner: postgres
--

CREATE TABLE expense_tracker.transaction_category (
    id_trans_cat integer NOT NULL,
    category_name character varying(50) NOT NULL,
    category_description character varying(250),
    active boolean DEFAULT true NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.transaction_category OWNER TO postgres;

--
-- Name: transaction_category_id_trans_cat_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: postgres
--

CREATE SEQUENCE expense_tracker.transaction_category_id_trans_cat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.transaction_category_id_trans_cat_seq OWNER TO postgres;

--
-- Name: transaction_category_id_trans_cat_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: postgres
--

ALTER SEQUENCE expense_tracker.transaction_category_id_trans_cat_seq OWNED BY expense_tracker.transaction_category.id_trans_cat;


--
-- Name: transaction_subcategory; Type: TABLE; Schema: expense_tracker; Owner: postgres
--

CREATE TABLE expense_tracker.transaction_subcategory (
    id_trans_subcat integer NOT NULL,
    id_trans_cat integer,
    subcategory_name character varying(50) NOT NULL,
    subcategory_description character varying(250),
    active boolean DEFAULT true NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.transaction_subcategory OWNER TO postgres;

--
-- Name: transaction_subcategory_id_trans_subcat_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: postgres
--

CREATE SEQUENCE expense_tracker.transaction_subcategory_id_trans_subcat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.transaction_subcategory_id_trans_subcat_seq OWNER TO postgres;

--
-- Name: transaction_subcategory_id_trans_subcat_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: postgres
--

ALTER SEQUENCE expense_tracker.transaction_subcategory_id_trans_subcat_seq OWNED BY expense_tracker.transaction_subcategory.id_trans_subcat;


--
-- Name: transaction_type; Type: TABLE; Schema: expense_tracker; Owner: postgres
--

CREATE TABLE expense_tracker.transaction_type (
    id_trans_type integer NOT NULL,
    transaction_type_name character varying(50) NOT NULL,
    transaction_type_desc character varying(250),
    active boolean DEFAULT true NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.transaction_type OWNER TO postgres;

--
-- Name: transaction_type_id_trans_type_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: postgres
--

CREATE SEQUENCE expense_tracker.transaction_type_id_trans_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.transaction_type_id_trans_type_seq OWNER TO postgres;

--
-- Name: transaction_type_id_trans_type_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: postgres
--

ALTER SEQUENCE expense_tracker.transaction_type_id_trans_type_seq OWNED BY expense_tracker.transaction_type.id_trans_type;


--
-- Name: transactions; Type: TABLE; Schema: expense_tracker; Owner: postgres
--

CREATE TABLE expense_tracker.transactions (
    id_transaction integer NOT NULL,
    id_trans_ba integer,
    id_trans_cat integer,
    id_trans_subcat integer,
    id_trans_type integer,
    id_user integer,
    transaction_date date DEFAULT CURRENT_DATE,
    transaction_value numeric(9,2),
    transaction_description text,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.transactions OWNER TO postgres;

--
-- Name: transactions_id_transaction_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: postgres
--

CREATE SEQUENCE expense_tracker.transactions_id_transaction_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.transactions_id_transaction_seq OWNER TO postgres;

--
-- Name: transactions_id_transaction_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: postgres
--

ALTER SEQUENCE expense_tracker.transactions_id_transaction_seq OWNED BY expense_tracker.transactions.id_transaction;


--
-- Name: users; Type: TABLE; Schema: expense_tracker; Owner: postgres
--

CREATE TABLE expense_tracker.users (
    id_user integer NOT NULL,
    user_login character varying(25) NOT NULL,
    user_name character varying(50) NOT NULL,
    user_password character varying(100) NOT NULL,
    password_salt character varying(100) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    insert_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE expense_tracker.users OWNER TO postgres;

--
-- Name: users_id_user_seq; Type: SEQUENCE; Schema: expense_tracker; Owner: postgres
--

CREATE SEQUENCE expense_tracker.users_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expense_tracker.users_id_user_seq OWNER TO postgres;

--
-- Name: users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: expense_tracker; Owner: postgres
--

ALTER SEQUENCE expense_tracker.users_id_user_seq OWNED BY expense_tracker.users.id_user;


--
-- Name: bank_account_owner id_ba_own; Type: DEFAULT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.bank_account_owner ALTER COLUMN id_ba_own SET DEFAULT nextval('expense_tracker.bank_account_owner_id_ba_own_seq'::regclass);


--
-- Name: bank_account_types id_ba_type; Type: DEFAULT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.bank_account_types ALTER COLUMN id_ba_type SET DEFAULT nextval('expense_tracker.bank_account_types_id_ba_type_seq'::regclass);


--
-- Name: transaction_bank_accounts id_trans_ba; Type: DEFAULT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_bank_accounts ALTER COLUMN id_trans_ba SET DEFAULT nextval('expense_tracker.transaction_bank_accounts_id_trans_ba_seq'::regclass);


--
-- Name: transaction_category id_trans_cat; Type: DEFAULT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_category ALTER COLUMN id_trans_cat SET DEFAULT nextval('expense_tracker.transaction_category_id_trans_cat_seq'::regclass);


--
-- Name: transaction_subcategory id_trans_subcat; Type: DEFAULT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_subcategory ALTER COLUMN id_trans_subcat SET DEFAULT nextval('expense_tracker.transaction_subcategory_id_trans_subcat_seq'::regclass);


--
-- Name: transaction_type id_trans_type; Type: DEFAULT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_type ALTER COLUMN id_trans_type SET DEFAULT nextval('expense_tracker.transaction_type_id_trans_type_seq'::regclass);


--
-- Name: transactions id_transaction; Type: DEFAULT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transactions ALTER COLUMN id_transaction SET DEFAULT nextval('expense_tracker.transactions_id_transaction_seq'::regclass);


--
-- Name: users id_user; Type: DEFAULT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.users ALTER COLUMN id_user SET DEFAULT nextval('expense_tracker.users_id_user_seq'::regclass);


--
-- Data for Name: bank_account_owner; Type: TABLE DATA; Schema: expense_tracker; Owner: postgres
--

COPY expense_tracker.bank_account_owner (id_ba_own, owner_name, owner_desc, user_login, active, insert_date, update_date) FROM stdin;
1	Aleksandra Saniewska	Opis	olasaniewska	t	2020-10-28 00:00:00	2020-10-28 00:00:00
2	Adam Nowak	Opis	adam_nowak	t	2020-10-28 12:26:02.254977	2020-10-28 12:26:02.254977
\.


--
-- Data for Name: bank_account_types; Type: TABLE DATA; Schema: expense_tracker; Owner: postgres
--

COPY expense_tracker.bank_account_types (id_ba_type, ba_type, ba_desc, active, is_common_account, id_ba_own, insert_date, update_date) FROM stdin;
1	Konto osobiste	Opis	t	f	1	2020-10-28 12:26:02.287892	2020-10-28 12:26:02.287892
2	Konto firmowe	Opis	f	t	2	2020-10-28 12:26:02.321982	2020-10-28 12:26:02.321982
\.


--
-- Data for Name: transaction_bank_accounts; Type: TABLE DATA; Schema: expense_tracker; Owner: postgres
--

COPY expense_tracker.transaction_bank_accounts (id_trans_ba, id_ba_own, id_ba_type, bank_account_name, bank_account_desc, active, insert_date, update_date) FROM stdin;
1	1	1	Nazwa	Opis	t	2020-10-28 12:26:02.399121	2020-10-28 12:26:02.399121
\.


--
-- Data for Name: transaction_category; Type: TABLE DATA; Schema: expense_tracker; Owner: postgres
--

COPY expense_tracker.transaction_category (id_trans_cat, category_name, category_description, active, insert_date, update_date) FROM stdin;
1	Zakupy	Opis	t	2020-10-28 12:26:02.432954	2020-10-28 12:26:02.432954
\.


--
-- Data for Name: transaction_subcategory; Type: TABLE DATA; Schema: expense_tracker; Owner: postgres
--

COPY expense_tracker.transaction_subcategory (id_trans_subcat, id_trans_cat, subcategory_name, subcategory_description, active, insert_date, update_date) FROM stdin;
1	1	Zakupy spożywcze	Opis	t	2020-10-28 12:26:02.588389	2020-10-28 12:26:02.588389
\.


--
-- Data for Name: transaction_type; Type: TABLE DATA; Schema: expense_tracker; Owner: postgres
--

COPY expense_tracker.transaction_type (id_trans_type, transaction_type_name, transaction_type_desc, active, insert_date, update_date) FROM stdin;
1	Nazwa transakcji	Opis	t	2020-10-28 12:26:02.620936	2020-10-28 12:26:02.620936
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: expense_tracker; Owner: postgres
--

COPY expense_tracker.transactions (id_transaction, id_trans_ba, id_trans_cat, id_trans_subcat, id_trans_type, id_user, transaction_date, transaction_value, transaction_description, insert_date, update_date) FROM stdin;
1	1	1	1	1	1	2020-10-28	9.99	Transakcja nr. 1	2020-10-28 12:26:02.73361	2020-10-28 12:26:02.73361
2	1	1	1	1	1	2020-10-28	29.99	Transakcja nr. 2	2020-10-28 12:26:02.777713	2020-10-28 12:26:02.777713
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: expense_tracker; Owner: postgres
--

COPY expense_tracker.users (id_user, user_login, user_name, user_password, password_salt, active, insert_date, update_date) FROM stdin;
1	olasan	olasan	ola123456	B87RS	t	2020-10-28 12:26:02.700052	2020-10-28 12:26:02.700052
\.


--
-- Name: bank_account_owner_id_ba_own_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: postgres
--

SELECT pg_catalog.setval('expense_tracker.bank_account_owner_id_ba_own_seq', 2, true);


--
-- Name: bank_account_types_id_ba_type_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: postgres
--

SELECT pg_catalog.setval('expense_tracker.bank_account_types_id_ba_type_seq', 2, true);


--
-- Name: transaction_bank_accounts_id_trans_ba_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: postgres
--

SELECT pg_catalog.setval('expense_tracker.transaction_bank_accounts_id_trans_ba_seq', 1, true);


--
-- Name: transaction_category_id_trans_cat_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: postgres
--

SELECT pg_catalog.setval('expense_tracker.transaction_category_id_trans_cat_seq', 1, true);


--
-- Name: transaction_subcategory_id_trans_subcat_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: postgres
--

SELECT pg_catalog.setval('expense_tracker.transaction_subcategory_id_trans_subcat_seq', 1, true);


--
-- Name: transaction_type_id_trans_type_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: postgres
--

SELECT pg_catalog.setval('expense_tracker.transaction_type_id_trans_type_seq', 1, true);


--
-- Name: transactions_id_transaction_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: postgres
--

SELECT pg_catalog.setval('expense_tracker.transactions_id_transaction_seq', 2, true);


--
-- Name: users_id_user_seq; Type: SEQUENCE SET; Schema: expense_tracker; Owner: postgres
--

SELECT pg_catalog.setval('expense_tracker.users_id_user_seq', 1, true);


--
-- Name: bank_account_owner pk_bank_account_owner; Type: CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.bank_account_owner
    ADD CONSTRAINT pk_bank_account_owner PRIMARY KEY (id_ba_own);


--
-- Name: bank_account_types pk_bank_account_types; Type: CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.bank_account_types
    ADD CONSTRAINT pk_bank_account_types PRIMARY KEY (id_ba_type);


--
-- Name: transaction_bank_accounts pk_transaction_bank_accounts; Type: CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_bank_accounts
    ADD CONSTRAINT pk_transaction_bank_accounts PRIMARY KEY (id_trans_ba);


--
-- Name: transaction_category pk_transaction_category; Type: CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_category
    ADD CONSTRAINT pk_transaction_category PRIMARY KEY (id_trans_cat);


--
-- Name: transaction_subcategory pk_transaction_subcategory; Type: CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_subcategory
    ADD CONSTRAINT pk_transaction_subcategory PRIMARY KEY (id_trans_subcat);


--
-- Name: transaction_type pk_transaction_type; Type: CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_type
    ADD CONSTRAINT pk_transaction_type PRIMARY KEY (id_trans_type);


--
-- Name: transactions pk_transactions; Type: CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT pk_transactions PRIMARY KEY (id_transaction);


--
-- Name: users pk_users; Type: CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.users
    ADD CONSTRAINT pk_users PRIMARY KEY (id_user);


--
-- Name: bank_account_types bank_account_types_fk; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.bank_account_types
    ADD CONSTRAINT bank_account_types_fk FOREIGN KEY (id_ba_own) REFERENCES expense_tracker.bank_account_owner(id_ba_own);


--
-- Name: transaction_bank_accounts transaction_bank_accounts_owner_fk; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_bank_accounts
    ADD CONSTRAINT transaction_bank_accounts_owner_fk FOREIGN KEY (id_ba_own) REFERENCES expense_tracker.bank_account_owner(id_ba_own);


--
-- Name: transaction_bank_accounts transaction_bank_accounts_types_fk; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_bank_accounts
    ADD CONSTRAINT transaction_bank_accounts_types_fk FOREIGN KEY (id_ba_type) REFERENCES expense_tracker.bank_account_types(id_ba_type);


--
-- Name: transaction_subcategory transaction_subcategory_category_fk; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transaction_subcategory
    ADD CONSTRAINT transaction_subcategory_category_fk FOREIGN KEY (id_trans_cat) REFERENCES expense_tracker.transaction_category(id_trans_cat);


--
-- Name: transactions transactions_bank_accounts_fk; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_bank_accounts_fk FOREIGN KEY (id_trans_ba) REFERENCES expense_tracker.transaction_bank_accounts(id_trans_ba);


--
-- Name: transactions transactions_category_fk; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_category_fk FOREIGN KEY (id_trans_cat) REFERENCES expense_tracker.transaction_category(id_trans_cat);


--
-- Name: transactions transactions_subcategory_fk; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_subcategory_fk FOREIGN KEY (id_trans_subcat) REFERENCES expense_tracker.transaction_subcategory(id_trans_subcat);


--
-- Name: transactions transactions_type_fk; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_type_fk FOREIGN KEY (id_trans_type) REFERENCES expense_tracker.transaction_type(id_trans_type);


--
-- Name: transactions transactions_users_fk; Type: FK CONSTRAINT; Schema: expense_tracker; Owner: postgres
--

ALTER TABLE ONLY expense_tracker.transactions
    ADD CONSTRAINT transactions_users_fk FOREIGN KEY (id_user) REFERENCES expense_tracker.users(id_user);


--
-- PostgreSQL database dump complete
--

