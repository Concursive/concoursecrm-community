--- NOTICE Add BEGIN WORK and COMMIT as well as the CFS2GK tables

BEGIN WORK;

--
-- PostgreSQL database dump
--

SET search_path = public, pg_catalog;

--
-- TOC entry 2 (OID 476839)
-- Name: sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sites (
    site_id serial NOT NULL,
    sitecode character varying(255) NOT NULL,
    vhost character varying(255) DEFAULT '' NOT NULL,
    dbhost character varying(255) DEFAULT '' NOT NULL,
    dbname character varying(255) DEFAULT '' NOT NULL,
    dbport integer DEFAULT 5432 NOT NULL,
    dbuser character varying(255) DEFAULT '' NOT NULL,
    dbpw character varying(255) DEFAULT '' NOT NULL,
    driver character varying(255) DEFAULT '' NOT NULL,
    code character varying(255),
    enabled boolean DEFAULT false NOT NULL
);

--
-- TOC entry 4 (OID 476857)
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE events (
    event_id serial NOT NULL,
    "second" character varying(64) DEFAULT '0',
    "minute" character varying(64) DEFAULT '*',
    "hour" character varying(64) DEFAULT '*',
    dayofmonth character varying(64) DEFAULT '*',
    "month" character varying(64) DEFAULT '*',
    dayofweek character varying(64) DEFAULT '*',
    "year" character varying(64) DEFAULT '*',
    task character varying(255),
    extrainfo character varying(255),
    businessdays character varying(6) DEFAULT 'true',
    enabled boolean DEFAULT false,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);

--
-- TOC entry 6 (OID 476877)
-- Name: events_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE events_log (
    log_id serial NOT NULL,
    event_id integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    status integer,
    message text
);

--
-- Data for TOC entry 15 (OID 476857)
-- Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO events VALUES (1, '0', '*/5', '*', '*', '*', '*', '*', 'org.aspcfs.apps.notifier.Notifier#doTask', '${FILEPATH}', 'true', true, '2003-11-13 08:11:37.411');
INSERT INTO events VALUES (2, '0', '*/1', '*', '*', '*', '*', '*', 'org.aspcfs.apps.reportRunner.ReportRunner#doTask', '${FILEPATH}', 'true', true, '2003-11-13 08:11:37.411');
INSERT INTO events VALUES (3, '0', '0', '*/12', '*', '*', '*', '*', 'org.aspcfs.apps.reportRunner.ReportCleanup#doTask', '${FILEPATH}', 'true', true, '2003-11-13 08:11:37.411');
INSERT INTO events VALUES (4, '0', '0', '0', '*', '*', '*', '*', 'org.aspcfs.modules.service.tasks.GetURL#doTask', 'http://${WEBSERVER.URL}/ProcessSystem.do?command=ClearGraphData', 'true', true, '2003-11-13 08:11:37.411');

--
-- TOC entry 11 (OID 476853)
-- Name: sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (site_id);


--
-- TOC entry 12 (OID 476873)
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- TOC entry 13 (OID 476884)
-- Name: events_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events_log
    ADD CONSTRAINT events_log_pkey PRIMARY KEY (log_id);


--
-- TOC entry 17 (OID 476886)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events_log
    ADD CONSTRAINT "$1" FOREIGN KEY (event_id) REFERENCES events(event_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 8 (OID 476837)
-- Name: sites_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('sites_site_id_seq', 1, false);


--
-- TOC entry 9 (OID 476855)
-- Name: events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('events_event_id_seq', 4, true);


--
-- TOC entry 10 (OID 476875)
-- Name: events_log_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('events_log_log_id_seq', 1, false);


--
-- PostgreSQL database dump
--

SET search_path = public, pg_catalog;

--
-- TOC entry 2 (OID 553854)
-- Name: access_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE access_user_id_seq
    START 0
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 0
    CACHE 1;


--
-- TOC entry 110 (OID 553856)
-- Name: access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "access" (
    user_id integer DEFAULT nextval('access_user_id_seq'::text) NOT NULL,
    username character varying(80) NOT NULL,
    "password" character varying(80),
    contact_id integer DEFAULT -1,
    role_id integer DEFAULT -1,
    manager_id integer DEFAULT -1,
    startofday integer DEFAULT 8,
    endofday integer DEFAULT 18,
    locale character varying(255),
    timezone character varying(255) DEFAULT 'America/New_York',
    last_ip character varying(15),
    last_login timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    expires date,
    alias integer DEFAULT -1,
    assistant integer DEFAULT -1,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 111 (OID 553878)
-- Name: lookup_industry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_industry (
    code serial NOT NULL,
    order_id integer,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 112 (OID 553888)
-- Name: access_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE access_log (
    id serial NOT NULL,
    user_id integer NOT NULL,
    username character varying(80) NOT NULL,
    ip character varying(15),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    browser character varying(255)
);


--
-- TOC entry 113 (OID 553900)
-- Name: usage_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usage_log (
    usage_id serial NOT NULL,
    entered timestamp(6) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer,
    "action" integer NOT NULL,
    record_id integer,
    record_size integer
);


--
-- TOC entry 114 (OID 553908)
-- Name: lookup_contact_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_contact_types (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true,
    user_id integer,
    category integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 115 (OID 553923)
-- Name: lookup_account_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_account_types (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 116 (OID 553931)
-- Name: state; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE state (
    state_code character(2) NOT NULL,
    state character varying(80) NOT NULL
);


--
-- TOC entry 117 (OID 553937)
-- Name: lookup_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_department (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 4 (OID 553945)
-- Name: lookup_orgaddress_type_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_orgaddress_type_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 118 (OID 553947)
-- Name: lookup_orgaddress_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_orgaddress_types (
    code integer DEFAULT nextval('lookup_orgaddress_type_code_seq'::text) NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 119 (OID 553957)
-- Name: lookup_orgemail_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_orgemail_types (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 120 (OID 553967)
-- Name: lookup_orgphone_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_orgphone_types (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 6 (OID 553975)
-- Name: lookup_instantmessenge_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_instantmessenge_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 121 (OID 553977)
-- Name: lookup_instantmessenger_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_instantmessenger_types (
    code integer DEFAULT nextval('lookup_instantmessenge_code_seq'::text) NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 8 (OID 553985)
-- Name: lookup_employment_type_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_employment_type_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 122 (OID 553987)
-- Name: lookup_employment_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_employment_types (
    code integer DEFAULT nextval('lookup_employment_type_code_seq'::text) NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 123 (OID 553997)
-- Name: lookup_locale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_locale (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 10 (OID 554005)
-- Name: lookup_contactaddress__code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_contactaddress__code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 124 (OID 554007)
-- Name: lookup_contactaddress_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_contactaddress_types (
    code integer DEFAULT nextval('lookup_contactaddress__code_seq'::text) NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 12 (OID 554015)
-- Name: lookup_contactemail_ty_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_contactemail_ty_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 125 (OID 554017)
-- Name: lookup_contactemail_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_contactemail_types (
    code integer DEFAULT nextval('lookup_contactemail_ty_code_seq'::text) NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 14 (OID 554025)
-- Name: lookup_contactphone_ty_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_contactphone_ty_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 126 (OID 554027)
-- Name: lookup_contactphone_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_contactphone_types (
    code integer DEFAULT nextval('lookup_contactphone_ty_code_seq'::text) NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 127 (OID 554037)
-- Name: lookup_access_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_access_types (
    code serial NOT NULL,
    link_module_id integer NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer,
    enabled boolean DEFAULT true,
    rule_id integer NOT NULL
);


--
-- TOC entry 16 (OID 554044)
-- Name: organization_org_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organization_org_id_seq
    START 0
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 0
    CACHE 1;


--
-- TOC entry 128 (OID 554046)
-- Name: organization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organization (
    org_id integer DEFAULT nextval('organization_org_id_seq'::text) NOT NULL,
    name character varying(80) NOT NULL,
    account_number character varying(50),
    account_group integer,
    url text,
    revenue double precision,
    employees integer,
    notes text,
    sic_code character varying(40),
    ticker_symbol character varying(10),
    taxid character(80),
    lead character varying(40),
    sales_rep integer DEFAULT 0 NOT NULL,
    miner_only boolean DEFAULT 'f' NOT NULL,
    defaultlocale integer,
    fiscalmonth integer,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    enabled boolean DEFAULT true,
    industry_temp_code smallint,
    "owner" integer,
    duplicate_id integer DEFAULT -1,
    custom1 integer DEFAULT -1,
    custom2 integer DEFAULT -1,
    contract_end date,
    alertdate date,
    alert character varying(100),
    custom_data text,
    namesalutation character varying(80),
    namelast character varying(80),
    namefirst character varying(80),
    namemiddle character varying(80),
    namesuffix character varying(80)
);


--
-- TOC entry 129 (OID 554077)
-- Name: contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contact (
    contact_id serial NOT NULL,
    user_id integer,
    org_id integer,
    company character varying(255),
    title character varying(80),
    department integer,
    super integer,
    namesalutation character varying(80),
    namelast character varying(80) NOT NULL,
    namefirst character varying(80) NOT NULL,
    namemiddle character varying(80),
    namesuffix character varying(80),
    assistant integer,
    birthdate date,
    notes text,
    site integer,
    imname character varying(30),
    imservice integer,
    locale integer,
    employee_id character varying(80),
    employmenttype integer,
    startofday character varying(10),
    endofday character varying(10),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    enabled boolean DEFAULT true,
    "owner" integer,
    custom1 integer DEFAULT -1,
    url character varying(100),
    primary_contact boolean DEFAULT false,
    employee boolean DEFAULT false NOT NULL,
    org_name character varying(255),
    access_type integer
);


--
-- TOC entry 130 (OID 554134)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE role (
    role_id serial NOT NULL,
    role character varying(80) NOT NULL,
    description character varying(255) DEFAULT '' NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 18 (OID 554151)
-- Name: permission_cate_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permission_cate_category_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 131 (OID 554153)
-- Name: permission_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE permission_category (
    category_id integer DEFAULT nextval('permission_cate_category_id_seq'::text) NOT NULL,
    category character varying(80),
    description character varying(255),
    "level" integer DEFAULT 0 NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    active boolean DEFAULT true NOT NULL,
    folders boolean DEFAULT false NOT NULL,
    lookups boolean DEFAULT false NOT NULL,
    viewpoints boolean DEFAULT false,
    categories boolean DEFAULT false,
    scheduled_events boolean DEFAULT false,
    object_events boolean DEFAULT false,
    reports boolean DEFAULT false
);


--
-- TOC entry 132 (OID 554170)
-- Name: permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE permission (
    permission_id serial NOT NULL,
    category_id integer NOT NULL,
    permission character varying(80) NOT NULL,
    permission_view boolean DEFAULT false NOT NULL,
    permission_add boolean DEFAULT false NOT NULL,
    permission_edit boolean DEFAULT false NOT NULL,
    permission_delete boolean DEFAULT false NOT NULL,
    description character varying(255) DEFAULT '' NOT NULL,
    "level" integer DEFAULT 0 NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    active boolean DEFAULT true NOT NULL,
    viewpoints boolean DEFAULT false
);


--
-- TOC entry 133 (OID 554190)
-- Name: role_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE role_permission (
    id serial NOT NULL,
    role_id integer NOT NULL,
    permission_id integer NOT NULL,
    role_view boolean DEFAULT false NOT NULL,
    role_add boolean DEFAULT false NOT NULL,
    role_edit boolean DEFAULT false NOT NULL,
    role_delete boolean DEFAULT false NOT NULL
);


--
-- TOC entry 134 (OID 554209)
-- Name: lookup_stage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_stage (
    code serial NOT NULL,
    order_id integer,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 20 (OID 554217)
-- Name: lookup_delivery_option_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_delivery_option_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 135 (OID 554219)
-- Name: lookup_delivery_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_delivery_options (
    code integer DEFAULT nextval('lookup_delivery_option_code_seq'::text) NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 136 (OID 554229)
-- Name: news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE news (
    rec_id serial NOT NULL,
    org_id integer,
    url text,
    base text,
    headline text,
    body text,
    dateentered date,
    "type" character(1),
    created timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 22 (OID 554242)
-- Name: organization_add_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organization_add_address_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 137 (OID 554244)
-- Name: organization_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organization_address (
    address_id integer DEFAULT nextval('organization_add_address_id_seq'::text) NOT NULL,
    org_id integer,
    address_type integer,
    addrline1 character varying(80),
    addrline2 character varying(80),
    addrline3 character varying(80),
    city character varying(80),
    state character varying(80),
    country character varying(80),
    postalcode character varying(12),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 24 (OID 554267)
-- Name: organization__emailaddress__seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organization__emailaddress__seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 138 (OID 554269)
-- Name: organization_emailaddress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organization_emailaddress (
    emailaddress_id integer DEFAULT nextval('organization__emailaddress__seq'::text) NOT NULL,
    org_id integer,
    emailaddress_type integer,
    email character varying(256),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 26 (OID 554292)
-- Name: organization_phone_phone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organization_phone_phone_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 139 (OID 554294)
-- Name: organization_phone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organization_phone (
    phone_id integer DEFAULT nextval('organization_phone_phone_id_seq'::text) NOT NULL,
    org_id integer,
    phone_type integer,
    number character varying(30),
    extension character varying(10),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 140 (OID 554319)
-- Name: contact_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contact_address (
    address_id serial NOT NULL,
    contact_id integer,
    address_type integer,
    addrline1 character varying(80),
    addrline2 character varying(80),
    addrline3 character varying(80),
    city character varying(80),
    state character varying(80),
    country character varying(80),
    postalcode character varying(12),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 28 (OID 554342)
-- Name: contact_email_emailaddress__seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contact_email_emailaddress__seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 141 (OID 554344)
-- Name: contact_emailaddress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contact_emailaddress (
    emailaddress_id integer DEFAULT nextval('contact_email_emailaddress__seq'::text) NOT NULL,
    contact_id integer,
    emailaddress_type integer,
    email character varying(256),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 142 (OID 554369)
-- Name: contact_phone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contact_phone (
    phone_id serial NOT NULL,
    contact_id integer,
    phone_type integer,
    number character varying(30),
    extension character varying(10),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 30 (OID 554392)
-- Name: notification_notification_i_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE notification_notification_i_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 143 (OID 554394)
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notification (
    notification_id integer DEFAULT nextval('notification_notification_i_seq'::text) NOT NULL,
    notify_user integer NOT NULL,
    module character varying(255) NOT NULL,
    item_id integer NOT NULL,
    item_modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    attempt timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    notify_type character varying(30),
    subject text,
    message text,
    result integer NOT NULL,
    errormessage text
);


--
-- TOC entry 144 (OID 554406)
-- Name: cfsinbox_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cfsinbox_message (
    id serial NOT NULL,
    subject character varying(255),
    body text NOT NULL,
    reply_id integer NOT NULL,
    enteredby integer NOT NULL,
    sent timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    "type" integer DEFAULT -1 NOT NULL,
    modifiedby integer NOT NULL,
    delete_flag boolean DEFAULT 'f'
);


--
-- TOC entry 145 (OID 554427)
-- Name: cfsinbox_messagelink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cfsinbox_messagelink (
    id integer NOT NULL,
    sent_to integer NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    viewed timestamp(3) without time zone,
    enabled boolean DEFAULT 't' NOT NULL,
    sent_from integer NOT NULL
);


--
-- TOC entry 146 (OID 554443)
-- Name: account_type_levels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE account_type_levels (
    org_id integer NOT NULL,
    type_id integer NOT NULL,
    "level" integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 147 (OID 554455)
-- Name: contact_type_levels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contact_type_levels (
    contact_id integer NOT NULL,
    type_id integer NOT NULL,
    "level" integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 148 (OID 554469)
-- Name: lookup_lists_lookup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_lists_lookup (
    id serial NOT NULL,
    module_id integer NOT NULL,
    lookup_id integer NOT NULL,
    class_name character varying(20),
    table_name character varying(60),
    "level" integer DEFAULT 0,
    description text,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    category_id integer NOT NULL
);


--
-- TOC entry 149 (OID 554485)
-- Name: viewpoint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE viewpoint (
    viewpoint_id serial NOT NULL,
    user_id integer NOT NULL,
    vp_user_id integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    enabled boolean DEFAULT true
);


--
-- TOC entry 32 (OID 554509)
-- Name: viewpoint_per_vp_permission_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE viewpoint_per_vp_permission_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 150 (OID 554511)
-- Name: viewpoint_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE viewpoint_permission (
    vp_permission_id integer DEFAULT nextval('viewpoint_per_vp_permission_seq'::text) NOT NULL,
    viewpoint_id integer NOT NULL,
    permission_id integer NOT NULL,
    viewpoint_view boolean DEFAULT false NOT NULL,
    viewpoint_add boolean DEFAULT false NOT NULL,
    viewpoint_edit boolean DEFAULT false NOT NULL,
    viewpoint_delete boolean DEFAULT false NOT NULL
);


--
-- TOC entry 151 (OID 554530)
-- Name: report; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE report (
    report_id serial NOT NULL,
    category_id integer NOT NULL,
    permission_id integer,
    filename character varying(300) NOT NULL,
    "type" integer DEFAULT 1 NOT NULL,
    title character varying(300) NOT NULL,
    description character varying(1024) NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    enabled boolean DEFAULT true,
    custom boolean DEFAULT false
);


--
-- TOC entry 152 (OID 554561)
-- Name: report_criteria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE report_criteria (
    criteria_id serial NOT NULL,
    report_id integer NOT NULL,
    "owner" integer NOT NULL,
    subject character varying(512) NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    enabled boolean DEFAULT true
);


--
-- TOC entry 153 (OID 554587)
-- Name: report_criteria_parameter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE report_criteria_parameter (
    parameter_id serial NOT NULL,
    criteria_id integer NOT NULL,
    parameter character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 154 (OID 554601)
-- Name: report_queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE report_queue (
    queue_id serial NOT NULL,
    report_id integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    processed timestamp(3) without time zone,
    status integer DEFAULT 0 NOT NULL,
    filename character varying(256),
    filesize integer DEFAULT -1,
    enabled boolean DEFAULT true
);


--
-- TOC entry 155 (OID 554620)
-- Name: report_queue_criteria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE report_queue_criteria (
    criteria_id serial NOT NULL,
    queue_id integer NOT NULL,
    parameter character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 34 (OID 554632)
-- Name: action_list_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE action_list_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 156 (OID 554634)
-- Name: action_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE action_list (
    action_id integer DEFAULT nextval('action_list_code_seq'::text) NOT NULL,
    description character varying(255) NOT NULL,
    "owner" integer NOT NULL,
    completedate timestamp(3) without time zone,
    link_module_id integer NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 36 (OID 554654)
-- Name: action_item_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE action_item_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 157 (OID 554656)
-- Name: action_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE action_item (
    item_id integer DEFAULT nextval('action_item_code_seq'::text) NOT NULL,
    action_id integer NOT NULL,
    link_item_id integer NOT NULL,
    completedate timestamp(3) without time zone,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 38 (OID 554676)
-- Name: action_item_log_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE action_item_log_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 158 (OID 554678)
-- Name: action_item_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE action_item_log (
    log_id integer DEFAULT nextval('action_item_log_code_seq'::text) NOT NULL,
    item_id integer NOT NULL,
    link_item_id integer DEFAULT -1,
    "type" integer NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 159 (OID 554700)
-- Name: database_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE database_version (
    version_id serial NOT NULL,
    script_filename character varying(255) NOT NULL,
    script_version character varying(255) NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 160 (OID 554825)
-- Name: lookup_call_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_call_types (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 40 (OID 554833)
-- Name: lookup_opportunity_typ_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_opportunity_typ_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 161 (OID 554835)
-- Name: lookup_opportunity_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_opportunity_types (
    code integer DEFAULT nextval('lookup_opportunity_typ_code_seq'::text) NOT NULL,
    order_id integer,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 162 (OID 554845)
-- Name: opportunity_header; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE opportunity_header (
    opp_id serial NOT NULL,
    description character varying(80),
    acctlink integer DEFAULT -1,
    contactlink integer DEFAULT -1,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 163 (OID 554864)
-- Name: opportunity_component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE opportunity_component (
    id serial NOT NULL,
    opp_id integer,
    "owner" integer NOT NULL,
    description character varying(80),
    closedate date NOT NULL,
    closeprob double precision,
    terms double precision,
    units character(1),
    lowvalue double precision,
    guessvalue double precision,
    highvalue double precision,
    stage integer,
    stagedate date DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    commission double precision,
    "type" character(1),
    alertdate date,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    closed timestamp without time zone,
    alert character varying(100),
    enabled boolean DEFAULT true NOT NULL,
    notes text
);


--
-- TOC entry 164 (OID 554898)
-- Name: opportunity_component_levels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE opportunity_component_levels (
    opp_id integer NOT NULL,
    type_id integer NOT NULL,
    "level" integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 165 (OID 554912)
-- Name: call_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE call_log (
    call_id serial NOT NULL,
    org_id integer,
    contact_id integer,
    opp_id integer,
    call_type_id integer,
    length integer,
    subject character varying(255),
    notes text,
    followup_date date,
    alertdate date,
    followup_notes text,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    alert character varying(100)
);


--
-- TOC entry 166 (OID 554965)
-- Name: ticket_level; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ticket_level (
    code serial NOT NULL,
    description character varying(300) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 167 (OID 554977)
-- Name: ticket_severity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ticket_severity (
    code serial NOT NULL,
    description character varying(300) NOT NULL,
    style text DEFAULT '' NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 168 (OID 554993)
-- Name: lookup_ticketsource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_ticketsource (
    code serial NOT NULL,
    description character varying(300) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 169 (OID 555005)
-- Name: ticket_priority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ticket_priority (
    code serial NOT NULL,
    description character varying(300) NOT NULL,
    style text DEFAULT '' NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 170 (OID 555021)
-- Name: ticket_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ticket_category (
    id serial NOT NULL,
    cat_level integer DEFAULT 0 NOT NULL,
    parent_cat_code integer NOT NULL,
    description character varying(300) NOT NULL,
    full_description text DEFAULT '' NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 171 (OID 555036)
-- Name: ticket_category_draft; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ticket_category_draft (
    id serial NOT NULL,
    link_id integer DEFAULT -1,
    cat_level integer DEFAULT 0 NOT NULL,
    parent_cat_code integer NOT NULL,
    description character varying(300) NOT NULL,
    full_description text DEFAULT '' NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 172 (OID 555052)
-- Name: ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ticket (
    ticketid serial NOT NULL,
    org_id integer,
    contact_id integer,
    problem text NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    closed timestamp without time zone,
    pri_code integer,
    level_code integer,
    department_code integer,
    source_code integer,
    cat_code integer,
    subcat_code1 integer,
    subcat_code2 integer,
    subcat_code3 integer,
    assigned_to integer,
    "comment" text,
    solution text,
    scode integer,
    critical timestamp without time zone,
    notified timestamp without time zone,
    custom_data text
);


--
-- TOC entry 173 (OID 555106)
-- Name: ticketlog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ticketlog (
    id serial NOT NULL,
    ticketid integer,
    assigned_to integer,
    "comment" text,
    closed boolean,
    pri_code integer,
    level_code integer,
    department_code integer,
    cat_code integer,
    scode integer,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 42 (OID 555164)
-- Name: module_field_categorylin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE module_field_categorylin_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 174 (OID 555166)
-- Name: module_field_categorylink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE module_field_categorylink (
    id integer DEFAULT nextval('module_field_categorylin_id_seq'::text) NOT NULL,
    module_id integer NOT NULL,
    category_id integer NOT NULL,
    "level" integer DEFAULT 0,
    description text,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone
);


--
-- TOC entry 44 (OID 555182)
-- Name: custom_field_ca_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE custom_field_ca_category_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 175 (OID 555184)
-- Name: custom_field_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE custom_field_category (
    module_id integer NOT NULL,
    category_id integer DEFAULT nextval('custom_field_ca_category_id_seq'::text) NOT NULL,
    category_name character varying(255) NOT NULL,
    "level" integer DEFAULT 0,
    description text,
    start_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    end_date timestamp without time zone,
    default_item boolean DEFAULT false,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    enabled boolean DEFAULT true,
    multiple_records boolean DEFAULT false,
    read_only boolean DEFAULT false
);


--
-- TOC entry 46 (OID 555204)
-- Name: custom_field_group_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE custom_field_group_group_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 176 (OID 555206)
-- Name: custom_field_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE custom_field_group (
    category_id integer NOT NULL,
    group_id integer DEFAULT nextval('custom_field_group_group_id_seq'::text) NOT NULL,
    group_name character varying(255) NOT NULL,
    "level" integer DEFAULT 0,
    description text,
    start_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    end_date timestamp without time zone,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    enabled boolean DEFAULT true
);


--
-- TOC entry 177 (OID 555225)
-- Name: custom_field_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE custom_field_info (
    group_id integer NOT NULL,
    field_id serial NOT NULL,
    field_name character varying(255) NOT NULL,
    "level" integer DEFAULT 0,
    field_type integer NOT NULL,
    validation_type integer DEFAULT 0,
    required boolean DEFAULT false,
    parameters text,
    start_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    end_date timestamp(3) without time zone,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    enabled boolean DEFAULT true,
    additional_text character varying(255)
);


--
-- TOC entry 178 (OID 555246)
-- Name: custom_field_lookup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE custom_field_lookup (
    field_id integer NOT NULL,
    code serial NOT NULL,
    description character varying(255) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    start_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    end_date timestamp without time zone,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    enabled boolean DEFAULT true
);


--
-- TOC entry 48 (OID 555260)
-- Name: custom_field_reco_record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE custom_field_reco_record_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 179 (OID 555262)
-- Name: custom_field_record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE custom_field_record (
    link_module_id integer NOT NULL,
    link_item_id integer NOT NULL,
    category_id integer NOT NULL,
    record_id integer DEFAULT nextval('custom_field_reco_record_id_seq'::text) NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    enabled boolean DEFAULT true
);


--
-- TOC entry 180 (OID 555283)
-- Name: custom_field_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE custom_field_data (
    record_id integer NOT NULL,
    field_id integer NOT NULL,
    selected_item_id integer DEFAULT 0,
    entered_value text,
    entered_number integer,
    entered_float double precision
);


--
-- TOC entry 50 (OID 555298)
-- Name: lookup_project_activit_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_project_activit_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 181 (OID 555300)
-- Name: lookup_project_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_project_activity (
    code integer DEFAULT nextval('lookup_project_activit_code_seq'::text) NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true,
    group_id integer DEFAULT 0 NOT NULL,
    template_id integer DEFAULT 0
);


--
-- TOC entry 52 (OID 555310)
-- Name: lookup_project_priorit_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_project_priorit_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 182 (OID 555312)
-- Name: lookup_project_priority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_project_priority (
    code integer DEFAULT nextval('lookup_project_priorit_code_seq'::text) NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true,
    group_id integer DEFAULT 0 NOT NULL,
    graphic character varying(75),
    "type" integer NOT NULL
);


--
-- TOC entry 183 (OID 555323)
-- Name: lookup_project_issues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_project_issues (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true,
    group_id integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 184 (OID 555334)
-- Name: lookup_project_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_project_status (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true,
    group_id integer DEFAULT 0 NOT NULL,
    graphic character varying(75),
    "type" integer NOT NULL
);


--
-- TOC entry 185 (OID 555345)
-- Name: lookup_project_loe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_project_loe (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    base_value integer DEFAULT 0 NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true,
    group_id integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 186 (OID 555357)
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projects (
    project_id serial NOT NULL,
    group_id integer,
    department_id integer,
    template_id integer,
    title character varying(100) NOT NULL,
    shortdescription character varying(200) NOT NULL,
    requestedby character varying(50),
    requesteddept character varying(50),
    requestdate timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    approvaldate timestamp(3) without time zone,
    closedate timestamp(3) without time zone,
    "owner" integer,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    modifiedby integer NOT NULL
);


--
-- TOC entry 54 (OID 555378)
-- Name: project_requi_requirement_i_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_requi_requirement_i_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 187 (OID 555380)
-- Name: project_requirements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_requirements (
    requirement_id integer DEFAULT nextval('project_requi_requirement_i_seq'::text) NOT NULL,
    project_id integer NOT NULL,
    submittedby character varying(50),
    departmentby character varying(30),
    shortdescription character varying(255) NOT NULL,
    description text NOT NULL,
    datereceived timestamp(3) without time zone,
    estimated_loevalue integer,
    estimated_loetype integer,
    actual_loevalue integer,
    actual_loetype integer,
    deadline timestamp(3) without time zone,
    approvedby integer,
    approvaldate timestamp(3) without time zone,
    closedby integer,
    closedate timestamp(3) without time zone,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 56 (OID 555418)
-- Name: project_assig_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_assig_assignment_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 188 (OID 555420)
-- Name: project_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_assignments (
    assignment_id integer DEFAULT nextval('project_assig_assignment_id_seq'::text) NOT NULL,
    project_id integer NOT NULL,
    requirement_id integer,
    assignedby integer,
    user_assign_id integer,
    activity_id integer,
    technology character varying(50),
    role character varying(255),
    estimated_loevalue integer,
    estimated_loetype integer,
    actual_loevalue integer,
    actual_loetype integer,
    priority_id integer,
    assign_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    est_start_date timestamp(3) without time zone,
    start_date timestamp(3) without time zone,
    due_date timestamp(3) without time zone,
    status_id integer,
    status_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    complete_date timestamp(3) without time zone,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 58 (OID 555475)
-- Name: project_assignmen_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_assignmen_status_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 189 (OID 555477)
-- Name: project_assignments_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_assignments_status (
    status_id integer DEFAULT nextval('project_assignmen_status_id_seq'::text) NOT NULL,
    assignment_id integer NOT NULL,
    user_id integer NOT NULL,
    description text NOT NULL,
    status_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone
);


--
-- TOC entry 190 (OID 555496)
-- Name: project_issues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_issues (
    issue_id serial NOT NULL,
    project_id integer NOT NULL,
    type_id integer,
    subject character varying(255) NOT NULL,
    message text NOT NULL,
    importance integer DEFAULT 0,
    enabled boolean DEFAULT true,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 60 (OID 555526)
-- Name: project_issue_repl_reply_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_issue_repl_reply_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 191 (OID 555528)
-- Name: project_issue_replies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_issue_replies (
    reply_id integer DEFAULT nextval('project_issue_repl_reply_id_seq'::text) NOT NULL,
    issue_id integer NOT NULL,
    reply_to integer DEFAULT 0,
    subject character varying(50) NOT NULL,
    message text NOT NULL,
    importance integer,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 192 (OID 555553)
-- Name: project_folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_folders (
    folder_id serial NOT NULL,
    link_module_id integer NOT NULL,
    link_item_id integer NOT NULL,
    subject character varying(255) NOT NULL,
    description text,
    parent integer
);


--
-- TOC entry 193 (OID 555563)
-- Name: project_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_files (
    item_id serial NOT NULL,
    link_module_id integer NOT NULL,
    link_item_id integer NOT NULL,
    folder_id integer,
    client_filename character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    subject character varying(500) NOT NULL,
    size integer DEFAULT 0,
    "version" double precision DEFAULT 0,
    enabled boolean DEFAULT true,
    downloads integer DEFAULT 0,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 194 (OID 555590)
-- Name: project_files_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_files_version (
    item_id integer,
    client_filename character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    subject character varying(500) NOT NULL,
    size integer DEFAULT 0,
    "version" double precision DEFAULT 0,
    enabled boolean DEFAULT true,
    downloads integer DEFAULT 0,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 195 (OID 555613)
-- Name: project_files_download; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_files_download (
    item_id integer NOT NULL,
    "version" double precision DEFAULT 0,
    user_download_id integer,
    download_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 196 (OID 555625)
-- Name: project_team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_team (
    project_id integer NOT NULL,
    user_id integer NOT NULL,
    userlevel integer,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    modifiedby integer NOT NULL
);


--
-- TOC entry 197 (OID 555686)
-- Name: saved_criterialist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE saved_criterialist (
    id serial NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    "owner" integer NOT NULL,
    name character varying(80) NOT NULL,
    contact_source integer DEFAULT -1,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 198 (OID 555709)
-- Name: campaign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE campaign (
    campaign_id serial NOT NULL,
    name character varying(80) NOT NULL,
    description character varying(255),
    list_id integer,
    message_id integer DEFAULT -1,
    reply_addr character varying(255),
    subject character varying(255),
    message text,
    status_id integer DEFAULT 0,
    status character varying(255),
    active boolean DEFAULT false,
    active_date date,
    send_method_id integer DEFAULT -1 NOT NULL,
    inactive_date date,
    approval_date timestamp(3) without time zone,
    approvedby integer,
    enabled boolean DEFAULT true NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    "type" integer DEFAULT 1
);


--
-- TOC entry 199 (OID 555739)
-- Name: campaign_run; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE campaign_run (
    id serial NOT NULL,
    campaign_id integer NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    run_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    total_contacts integer DEFAULT 0,
    total_sent integer DEFAULT 0,
    total_replied integer DEFAULT 0,
    total_bounced integer DEFAULT 0
);


--
-- TOC entry 200 (OID 555756)
-- Name: excluded_recipient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE excluded_recipient (
    id serial NOT NULL,
    campaign_id integer NOT NULL,
    contact_id integer NOT NULL
);


--
-- TOC entry 201 (OID 555769)
-- Name: campaign_list_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE campaign_list_groups (
    campaign_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- TOC entry 202 (OID 555781)
-- Name: active_campaign_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE active_campaign_groups (
    id serial NOT NULL,
    campaign_id integer NOT NULL,
    groupname character varying(80) NOT NULL,
    groupcriteria text
);


--
-- TOC entry 203 (OID 555795)
-- Name: scheduled_recipient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE scheduled_recipient (
    id serial NOT NULL,
    campaign_id integer NOT NULL,
    contact_id integer NOT NULL,
    run_id integer DEFAULT -1,
    status_id integer DEFAULT 0,
    status character varying(255),
    status_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    scheduled_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone,
    sent_date timestamp(3) without time zone,
    reply_date timestamp(3) without time zone,
    bounce_date timestamp(3) without time zone
);


--
-- TOC entry 204 (OID 555814)
-- Name: lookup_survey_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_survey_types (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 205 (OID 555824)
-- Name: survey; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE survey (
    survey_id serial NOT NULL,
    name character varying(80) NOT NULL,
    description character varying(255),
    intro text,
    outro text,
    itemlength integer DEFAULT -1,
    "type" integer DEFAULT -1,
    enabled boolean DEFAULT true NOT NULL,
    status integer DEFAULT -1 NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 206 (OID 555846)
-- Name: campaign_survey_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE campaign_survey_link (
    campaign_id integer,
    survey_id integer
);


--
-- TOC entry 62 (OID 555856)
-- Name: survey_question_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE survey_question_question_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 207 (OID 555858)
-- Name: survey_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE survey_questions (
    question_id integer DEFAULT nextval('survey_question_question_id_seq'::text) NOT NULL,
    survey_id integer NOT NULL,
    "type" integer NOT NULL,
    description character varying(255),
    required boolean DEFAULT false NOT NULL,
    "position" integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 208 (OID 555875)
-- Name: survey_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE survey_items (
    item_id serial NOT NULL,
    question_id integer NOT NULL,
    "type" integer DEFAULT -1,
    description character varying(255)
);


--
-- TOC entry 64 (OID 555885)
-- Name: active_survey_active_survey_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE active_survey_active_survey_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 209 (OID 555887)
-- Name: active_survey; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE active_survey (
    active_survey_id integer DEFAULT nextval('active_survey_active_survey_seq'::text) NOT NULL,
    campaign_id integer NOT NULL,
    name character varying(80) NOT NULL,
    description character varying(255),
    intro text,
    outro text,
    itemlength integer DEFAULT -1,
    "type" integer NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 66 (OID 555915)
-- Name: active_survey_q_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE active_survey_q_question_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 210 (OID 555917)
-- Name: active_survey_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE active_survey_questions (
    question_id integer DEFAULT nextval('active_survey_q_question_id_seq'::text) NOT NULL,
    active_survey_id integer,
    "type" integer NOT NULL,
    description character varying(255),
    required boolean DEFAULT false NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    average double precision DEFAULT 0.00,
    total1 integer DEFAULT 0,
    total2 integer DEFAULT 0,
    total3 integer DEFAULT 0,
    total4 integer DEFAULT 0,
    total5 integer DEFAULT 0,
    total6 integer DEFAULT 0,
    total7 integer DEFAULT 0
);


--
-- TOC entry 68 (OID 555940)
-- Name: active_survey_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE active_survey_items_item_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 211 (OID 555942)
-- Name: active_survey_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE active_survey_items (
    item_id integer DEFAULT nextval('active_survey_items_item_id_seq'::text) NOT NULL,
    question_id integer NOT NULL,
    "type" integer DEFAULT -1,
    description character varying(255)
);


--
-- TOC entry 70 (OID 555952)
-- Name: active_survey_r_response_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE active_survey_r_response_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 212 (OID 555954)
-- Name: active_survey_responses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE active_survey_responses (
    response_id integer DEFAULT nextval('active_survey_r_response_id_seq'::text) NOT NULL,
    active_survey_id integer NOT NULL,
    contact_id integer DEFAULT -1 NOT NULL,
    unique_code character varying(255),
    ip_address character varying(15) NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 72 (OID 555965)
-- Name: active_survey_ans_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE active_survey_ans_answer_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 213 (OID 555967)
-- Name: active_survey_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE active_survey_answers (
    answer_id integer DEFAULT nextval('active_survey_ans_answer_id_seq'::text) NOT NULL,
    response_id integer NOT NULL,
    question_id integer NOT NULL,
    comments text,
    quant_ans integer DEFAULT -1,
    text_ans text
);


--
-- TOC entry 74 (OID 555984)
-- Name: active_survey_answer_ite_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE active_survey_answer_ite_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 214 (OID 555986)
-- Name: active_survey_answer_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE active_survey_answer_items (
    id integer DEFAULT nextval('active_survey_answer_ite_id_seq'::text) NOT NULL,
    item_id integer NOT NULL,
    answer_id integer NOT NULL,
    comments text
);


--
-- TOC entry 76 (OID 556002)
-- Name: active_survey_answer_avg_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE active_survey_answer_avg_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 215 (OID 556004)
-- Name: active_survey_answer_avg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE active_survey_answer_avg (
    id integer DEFAULT nextval('active_survey_answer_avg_id_seq'::text) NOT NULL,
    question_id integer NOT NULL,
    item_id integer NOT NULL,
    total integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 216 (OID 556020)
-- Name: field_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE field_types (
    id serial NOT NULL,
    data_typeid integer DEFAULT -1 NOT NULL,
    data_type character varying(20),
    "operator" character varying(50),
    display_text character varying(50),
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 217 (OID 556029)
-- Name: search_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE search_fields (
    id serial NOT NULL,
    field character varying(80),
    description character varying(255),
    searchable boolean DEFAULT true NOT NULL,
    field_typeid integer DEFAULT -1 NOT NULL,
    table_name character varying(80),
    object_class character varying(80),
    enabled boolean DEFAULT true
);


--
-- TOC entry 218 (OID 556039)
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE message (
    id serial NOT NULL,
    name character varying(80) NOT NULL,
    description character varying(255),
    template_id integer,
    subject character varying(255),
    body text,
    reply_addr character varying(100),
    url character varying(255),
    img character varying(80),
    enabled boolean DEFAULT true NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    access_type integer
);


--
-- TOC entry 219 (OID 556064)
-- Name: message_template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE message_template (
    id serial NOT NULL,
    name character varying(80) NOT NULL,
    description character varying(255),
    template_file character varying(80),
    num_imgs integer,
    num_urls integer,
    enabled boolean DEFAULT true NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 220 (OID 556080)
-- Name: saved_criteriaelement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE saved_criteriaelement (
    id integer NOT NULL,
    field integer NOT NULL,
    "operator" character varying(50) NOT NULL,
    operatorid integer NOT NULL,
    value character varying(80) NOT NULL,
    source integer DEFAULT -1 NOT NULL
);


--
-- TOC entry 221 (OID 556138)
-- Name: help_module; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE help_module (
    module_id serial NOT NULL,
    category_id integer,
    module_brief_description text,
    module_detail_description text
);


--
-- TOC entry 222 (OID 556152)
-- Name: help_contents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE help_contents (
    help_id serial NOT NULL,
    category_id integer,
    link_module_id integer,
    module character varying(255),
    section character varying(255),
    subsection character varying(255),
    title character varying(255),
    description text,
    nextcontent integer,
    prevcontent integer,
    upcontent integer,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enabled boolean DEFAULT true
);


--
-- TOC entry 223 (OID 556193)
-- Name: help_tableof_contents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE help_tableof_contents (
    content_id serial NOT NULL,
    displaytext character varying(255),
    firstchild integer,
    nextsibling integer,
    parent integer,
    category_id integer,
    contentlevel integer NOT NULL,
    contentorder integer NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enabled boolean DEFAULT true
);


--
-- TOC entry 224 (OID 556227)
-- Name: help_tableofcontentitem_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE help_tableofcontentitem_links (
    link_id serial NOT NULL,
    global_link_id integer NOT NULL,
    linkto_content_id integer NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enabled boolean DEFAULT true
);


--
-- TOC entry 225 (OID 556253)
-- Name: lookup_help_features; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_help_features (
    code serial NOT NULL,
    description character varying(1000) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 226 (OID 556266)
-- Name: help_features; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE help_features (
    feature_id serial NOT NULL,
    link_help_id integer NOT NULL,
    link_feature_id integer,
    description character varying(1000) NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    completedate timestamp(3) without time zone,
    completedby integer,
    enabled boolean DEFAULT true NOT NULL,
    "level" integer DEFAULT 0
);


--
-- TOC entry 227 (OID 556300)
-- Name: help_related_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE help_related_links (
    relatedlink_id serial NOT NULL,
    owning_module_id integer,
    linkto_content_id integer,
    displaytext character varying(255) NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 228 (OID 556326)
-- Name: help_faqs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE help_faqs (
    faq_id serial NOT NULL,
    owning_module_id integer NOT NULL,
    question character varying(1000) NOT NULL,
    answer character varying(1000) NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    completedate timestamp(3) without time zone,
    completedby integer,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 229 (OID 556355)
-- Name: help_business_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE help_business_rules (
    rule_id serial NOT NULL,
    link_help_id integer NOT NULL,
    description character varying(1000) NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    completedate timestamp(3) without time zone,
    completedby integer,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 230 (OID 556384)
-- Name: help_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE help_notes (
    note_id serial NOT NULL,
    link_help_id integer NOT NULL,
    description character varying(1000) NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    completedate timestamp(3) without time zone,
    completedby integer,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 231 (OID 556413)
-- Name: help_tips; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE help_tips (
    tip_id serial NOT NULL,
    link_help_id integer NOT NULL,
    description character varying(1000) NOT NULL,
    enteredby integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 232 (OID 556438)
-- Name: sync_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sync_client (
    client_id serial NOT NULL,
    "type" character varying(100),
    "version" character varying(50),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL,
    anchor timestamp(3) without time zone
);


--
-- TOC entry 233 (OID 556447)
-- Name: sync_system; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sync_system (
    system_id serial NOT NULL,
    application_name character varying(255),
    enabled boolean DEFAULT true
);


--
-- TOC entry 234 (OID 556455)
-- Name: sync_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sync_table (
    table_id serial NOT NULL,
    system_id integer NOT NULL,
    element_name character varying(255),
    mapped_class_name character varying(255),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    create_statement text,
    order_id integer DEFAULT -1,
    sync_item boolean DEFAULT false,
    object_key character varying(50)
);


--
-- TOC entry 235 (OID 556471)
-- Name: sync_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sync_map (
    client_id integer NOT NULL,
    table_id integer NOT NULL,
    record_id integer NOT NULL,
    cuid integer NOT NULL,
    complete boolean DEFAULT false,
    status_date timestamp(3) without time zone
);


--
-- TOC entry 236 (OID 556483)
-- Name: sync_conflict_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sync_conflict_log (
    client_id integer NOT NULL,
    table_id integer NOT NULL,
    record_id integer NOT NULL,
    status_date timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 237 (OID 556496)
-- Name: sync_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sync_log (
    log_id serial NOT NULL,
    system_id integer NOT NULL,
    client_id integer NOT NULL,
    ip character varying(15),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 78 (OID 556510)
-- Name: sync_transact_transaction_i_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sync_transact_transaction_i_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 238 (OID 556512)
-- Name: sync_transaction_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sync_transaction_log (
    transaction_id integer DEFAULT nextval('sync_transact_transaction_i_seq'::text) NOT NULL,
    log_id integer NOT NULL,
    reference_id character varying(50),
    element_name character varying(255),
    "action" character varying(20),
    link_item_id integer,
    status_code integer,
    record_count integer,
    message text
);


--
-- TOC entry 239 (OID 556526)
-- Name: process_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE process_log (
    process_id serial NOT NULL,
    system_id integer NOT NULL,
    client_id integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    process_name character varying(255),
    process_version character varying(20),
    status integer,
    message text
);


--
-- TOC entry 240 (OID 556749)
-- Name: autoguide_make; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autoguide_make (
    make_id serial NOT NULL,
    make_name character varying(30),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 241 (OID 556758)
-- Name: autoguide_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autoguide_model (
    model_id serial NOT NULL,
    make_id integer NOT NULL,
    model_name character varying(50),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 80 (OID 556769)
-- Name: autoguide_vehicl_vehicle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE autoguide_vehicl_vehicle_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 242 (OID 556771)
-- Name: autoguide_vehicle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autoguide_vehicle (
    vehicle_id integer DEFAULT nextval('autoguide_vehicl_vehicle_id_seq'::text) NOT NULL,
    "year" character varying(4) NOT NULL,
    make_id integer NOT NULL,
    model_id integer NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 82 (OID 556786)
-- Name: autoguide_inve_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE autoguide_inve_inventory_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 243 (OID 556788)
-- Name: autoguide_inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autoguide_inventory (
    inventory_id integer DEFAULT nextval('autoguide_inve_inventory_id_seq'::text) NOT NULL,
    vehicle_id integer NOT NULL,
    account_id integer,
    vin character varying(20),
    mileage character varying(20),
    is_new boolean DEFAULT false,
    condition character varying(20),
    comments character varying(255),
    stock_no character varying(20),
    ext_color character varying(20),
    int_color character varying(20),
    style character varying(40),
    invoice_price double precision,
    selling_price double precision,
    selling_price_text character varying(100),
    sold boolean DEFAULT false,
    status character varying(20),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 84 (OID 556805)
-- Name: autoguide_options_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE autoguide_options_option_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 244 (OID 556807)
-- Name: autoguide_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autoguide_options (
    option_id integer DEFAULT nextval('autoguide_options_option_id_seq'::text) NOT NULL,
    option_name character varying(20) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 245 (OID 556817)
-- Name: autoguide_inventory_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autoguide_inventory_options (
    inventory_id integer NOT NULL,
    option_id integer NOT NULL
);


--
-- TOC entry 246 (OID 556826)
-- Name: autoguide_ad_run; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autoguide_ad_run (
    ad_run_id serial NOT NULL,
    inventory_id integer NOT NULL,
    run_date timestamp(3) without time zone NOT NULL,
    ad_type character varying(20),
    include_photo boolean DEFAULT false,
    complete_date timestamp(3) without time zone,
    completedby integer DEFAULT -1,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 86 (OID 556839)
-- Name: autoguide_ad_run_types_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE autoguide_ad_run_types_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 247 (OID 556841)
-- Name: autoguide_ad_run_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autoguide_ad_run_types (
    code integer DEFAULT nextval('autoguide_ad_run_types_code_seq'::text) NOT NULL,
    description character varying(20) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT false,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 248 (OID 556886)
-- Name: lookup_revenue_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_revenue_types (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 88 (OID 556894)
-- Name: lookup_revenuedetail_t_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lookup_revenuedetail_t_code_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 249 (OID 556896)
-- Name: lookup_revenuedetail_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_revenuedetail_types (
    code integer DEFAULT nextval('lookup_revenuedetail_t_code_seq'::text) NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 250 (OID 556906)
-- Name: revenue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE revenue (
    id serial NOT NULL,
    org_id integer,
    transaction_id integer DEFAULT -1,
    "month" integer DEFAULT -1,
    "year" integer DEFAULT -1,
    amount double precision DEFAULT 0,
    "type" integer,
    "owner" integer,
    description character varying(255),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 251 (OID 556939)
-- Name: revenue_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE revenue_detail (
    id serial NOT NULL,
    revenue_id integer,
    amount double precision DEFAULT 0,
    "type" integer,
    "owner" integer,
    description character varying(255),
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer NOT NULL
);


--
-- TOC entry 252 (OID 556970)
-- Name: lookup_task_priority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_task_priority (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 253 (OID 556980)
-- Name: lookup_task_loe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_task_loe (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 254 (OID 556990)
-- Name: lookup_task_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lookup_task_category (
    code serial NOT NULL,
    description character varying(50) NOT NULL,
    default_item boolean DEFAULT false,
    "level" integer DEFAULT 0,
    enabled boolean DEFAULT true
);


--
-- TOC entry 255 (OID 557000)
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE task (
    task_id serial NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    enteredby integer NOT NULL,
    priority integer NOT NULL,
    description character varying(80),
    duedate date,
    reminderid integer,
    notes text,
    sharing integer NOT NULL,
    complete boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    modified timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    modifiedby integer,
    estimatedloe double precision,
    estimatedloetype integer,
    "type" integer DEFAULT 1,
    "owner" integer,
    completedate timestamp(3) without time zone,
    category_id integer
);


--
-- TOC entry 256 (OID 557037)
-- Name: tasklink_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tasklink_contact (
    task_id integer NOT NULL,
    contact_id integer NOT NULL
);


--
-- TOC entry 257 (OID 557047)
-- Name: tasklink_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tasklink_ticket (
    task_id integer NOT NULL,
    ticket_id integer NOT NULL
);


--
-- TOC entry 258 (OID 557057)
-- Name: tasklink_project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tasklink_project (
    task_id integer NOT NULL,
    project_id integer NOT NULL
);


--
-- TOC entry 259 (OID 557067)
-- Name: taskcategory_project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE taskcategory_project (
    category_id integer NOT NULL,
    project_id integer NOT NULL
);


--
-- TOC entry 90 (OID 557087)
-- Name: business_process_com_lb_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE business_process_com_lb_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 260 (OID 557089)
-- Name: business_process_component_library; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_component_library (
    component_id integer DEFAULT nextval('business_process_com_lb_id_seq'::text) NOT NULL,
    component_name character varying(255) NOT NULL,
    type_id integer NOT NULL,
    class_name character varying(255) NOT NULL,
    description character varying(510),
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 92 (OID 557098)
-- Name: business_process_comp_re_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE business_process_comp_re_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 261 (OID 557100)
-- Name: business_process_component_result_lookup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_component_result_lookup (
    result_id integer DEFAULT nextval('business_process_comp_re_id_seq'::text) NOT NULL,
    component_id integer NOT NULL,
    return_id integer NOT NULL,
    description character varying(255),
    "level" integer DEFAULT 0 NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 94 (OID 557111)
-- Name: business_process_pa_lib_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE business_process_pa_lib_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 262 (OID 557113)
-- Name: business_process_parameter_library; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_parameter_library (
    parameter_id integer DEFAULT nextval('business_process_pa_lib_id_seq'::text) NOT NULL,
    component_id integer,
    param_name character varying(255),
    description character varying(510),
    default_value character varying(4000),
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 263 (OID 557124)
-- Name: business_process; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process (
    process_id serial NOT NULL,
    process_name character varying(255) NOT NULL,
    description character varying(510),
    type_id integer NOT NULL,
    link_module_id integer NOT NULL,
    component_start_id integer,
    enabled boolean DEFAULT true NOT NULL,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL
);


--
-- TOC entry 96 (OID 557140)
-- Name: business_process_compone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE business_process_compone_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 264 (OID 557142)
-- Name: business_process_component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_component (
    id integer DEFAULT nextval('business_process_compone_id_seq'::text) NOT NULL,
    process_id integer NOT NULL,
    component_id integer NOT NULL,
    parent_id integer,
    parent_result_id integer,
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 98 (OID 557160)
-- Name: business_process_param_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE business_process_param_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 265 (OID 557162)
-- Name: business_process_parameter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_parameter (
    id integer DEFAULT nextval('business_process_param_id_seq'::text) NOT NULL,
    process_id integer NOT NULL,
    param_name character varying(255),
    param_value character varying(4000),
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 100 (OID 557175)
-- Name: business_process_comp_pa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE business_process_comp_pa_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 266 (OID 557177)
-- Name: business_process_component_parameter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_component_parameter (
    id integer DEFAULT nextval('business_process_comp_pa_id_seq'::text) NOT NULL,
    component_id integer NOT NULL,
    parameter_id integer NOT NULL,
    param_value character varying(4000),
    enabled boolean DEFAULT true NOT NULL
);


--
-- TOC entry 102 (OID 557194)
-- Name: business_process_e_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE business_process_e_event_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 267 (OID 557196)
-- Name: business_process_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_events (
    event_id integer DEFAULT nextval('business_process_e_event_id_seq'::text) NOT NULL,
    "second" character varying(64) DEFAULT '0',
    "minute" character varying(64) DEFAULT '*',
    "hour" character varying(64) DEFAULT '*',
    dayofmonth character varying(64) DEFAULT '*',
    "month" character varying(64) DEFAULT '*',
    dayofweek character varying(64) DEFAULT '*',
    "year" character varying(64) DEFAULT '*',
    task character varying(255),
    extrainfo character varying(255),
    businessdays character varying(6) DEFAULT 'true',
    enabled boolean DEFAULT false,
    entered timestamp(3) without time zone DEFAULT ('now'::text)::timestamp(6) with time zone NOT NULL,
    process_id integer NOT NULL
);


--
-- TOC entry 268 (OID 557218)
-- Name: business_process_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_log (
    process_name character varying(255) NOT NULL,
    anchor timestamp(3) without time zone NOT NULL
);


--
-- TOC entry 104 (OID 557222)
-- Name: business_process_hl_hook_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE business_process_hl_hook_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 269 (OID 557224)
-- Name: business_process_hook_library; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_hook_library (
    hook_id integer DEFAULT nextval('business_process_hl_hook_id_seq'::text) NOT NULL,
    link_module_id integer NOT NULL,
    hook_class character varying(255) NOT NULL,
    enabled boolean DEFAULT false
);


--
-- TOC entry 106 (OID 557234)
-- Name: business_process_ho_trig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE business_process_ho_trig_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 270 (OID 557236)
-- Name: business_process_hook_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_hook_triggers (
    trigger_id integer DEFAULT nextval('business_process_ho_trig_id_seq'::text) NOT NULL,
    action_type_id integer NOT NULL,
    hook_id integer NOT NULL,
    enabled boolean DEFAULT false
);


--
-- TOC entry 108 (OID 557246)
-- Name: business_process_ho_hook_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE business_process_ho_hook_id_seq
    START 1
    INCREMENT 1
    MAXVALUE 9223372036854775807
    MINVALUE 1
    CACHE 1;


--
-- TOC entry 271 (OID 557248)
-- Name: business_process_hook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_process_hook (
    id integer DEFAULT nextval('business_process_ho_hook_id_seq'::text) NOT NULL,
    trigger_id integer NOT NULL,
    process_id integer NOT NULL,
    enabled boolean DEFAULT false
);


--
-- Data for TOC entry 533 (OID 553856)
-- Name: access; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "access" VALUES (0, 'dhvadmin', '---', -1, 1, -1, 8, 18, NULL, 'America/New_York', NULL, '2003-12-04 16:46:36.11', 0, '2003-12-04 16:46:36.11', 0, '2003-12-04 16:46:36.11', NULL, -1, -1, true);


--
-- Data for TOC entry 534 (OID 553878)
-- Name: lookup_industry; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_industry VALUES (1, NULL, 'Automotive', false, 0, true);
INSERT INTO lookup_industry VALUES (2, NULL, 'Biotechnology', false, 0, true);
INSERT INTO lookup_industry VALUES (3, NULL, 'Broadcasting and Cable', false, 0, true);
INSERT INTO lookup_industry VALUES (4, NULL, 'Computer', false, 0, true);
INSERT INTO lookup_industry VALUES (5, NULL, 'Consulting', false, 0, true);
INSERT INTO lookup_industry VALUES (6, NULL, 'Defense', false, 0, true);
INSERT INTO lookup_industry VALUES (7, NULL, 'Energy', false, 0, true);
INSERT INTO lookup_industry VALUES (8, NULL, 'Financial Services', false, 0, true);
INSERT INTO lookup_industry VALUES (9, NULL, 'Food', false, 0, true);
INSERT INTO lookup_industry VALUES (10, NULL, 'Healthcare', false, 0, true);
INSERT INTO lookup_industry VALUES (11, NULL, 'Hospitality', false, 0, true);
INSERT INTO lookup_industry VALUES (12, NULL, 'Insurance', false, 0, true);
INSERT INTO lookup_industry VALUES (13, NULL, 'Internet', false, 0, true);
INSERT INTO lookup_industry VALUES (14, NULL, 'Law Firms', false, 0, true);
INSERT INTO lookup_industry VALUES (15, NULL, 'Media', false, 0, true);
INSERT INTO lookup_industry VALUES (16, NULL, 'Pharmaceuticals', false, 0, true);
INSERT INTO lookup_industry VALUES (17, NULL, 'Real Estate', false, 0, true);
INSERT INTO lookup_industry VALUES (18, NULL, 'Retail', false, 0, true);
INSERT INTO lookup_industry VALUES (19, NULL, 'Telecommunications', false, 0, true);
INSERT INTO lookup_industry VALUES (20, NULL, 'Transportation', false, 0, true);


--
-- Data for TOC entry 535 (OID 553888)
-- Name: access_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 536 (OID 553900)
-- Name: usage_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 537 (OID 553908)
-- Name: lookup_contact_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_contact_types VALUES (1, 'Sales', false, 0, true, NULL, 0);
INSERT INTO lookup_contact_types VALUES (2, 'Billing', false, 0, true, NULL, 0);
INSERT INTO lookup_contact_types VALUES (3, 'Technical', false, 0, true, NULL, 0);


--
-- Data for TOC entry 538 (OID 553923)
-- Name: lookup_account_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_account_types VALUES (1, 'Customer', false, 0, true);
INSERT INTO lookup_account_types VALUES (2, 'Competitor', false, 0, true);
INSERT INTO lookup_account_types VALUES (3, 'Partner', false, 0, true);
INSERT INTO lookup_account_types VALUES (4, 'Vendor', false, 0, true);
INSERT INTO lookup_account_types VALUES (5, 'Investor', false, 0, true);
INSERT INTO lookup_account_types VALUES (6, 'Prospect', false, 0, true);


--
-- Data for TOC entry 539 (OID 553931)
-- Name: state; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO state VALUES ('AK', 'Alaska');
INSERT INTO state VALUES ('AL', 'Alabama');
INSERT INTO state VALUES ('AR', 'Arkansas');
INSERT INTO state VALUES ('AZ', 'Arizona');
INSERT INTO state VALUES ('CA', 'California');
INSERT INTO state VALUES ('CO', 'Colorado');
INSERT INTO state VALUES ('CT', 'Connecticut');
INSERT INTO state VALUES ('DE', 'Delaware');
INSERT INTO state VALUES ('FL', 'Florida');
INSERT INTO state VALUES ('GA', 'Georgia');
INSERT INTO state VALUES ('HI', 'Hawaii');
INSERT INTO state VALUES ('ID', 'Idaho');
INSERT INTO state VALUES ('IL', 'Illinois');
INSERT INTO state VALUES ('IN', 'Indiana');
INSERT INTO state VALUES ('KS', 'Kansas');
INSERT INTO state VALUES ('KY', 'Kentucky');
INSERT INTO state VALUES ('LA', 'Louisiana');
INSERT INTO state VALUES ('ME', 'Maine');
INSERT INTO state VALUES ('MD', 'Maryland');
INSERT INTO state VALUES ('MA', 'Massachusetts');
INSERT INTO state VALUES ('MI', 'Michigan');
INSERT INTO state VALUES ('MN', 'Minnesota');
INSERT INTO state VALUES ('MS', 'Mississippi');
INSERT INTO state VALUES ('MO', 'Mossouri');
INSERT INTO state VALUES ('MT', 'Montana');
INSERT INTO state VALUES ('NE', 'Nebraska');
INSERT INTO state VALUES ('NV', 'Nevada');
INSERT INTO state VALUES ('NH', 'New Hampshire');
INSERT INTO state VALUES ('NJ', 'New Jersey');
INSERT INTO state VALUES ('NM', 'New Mexico');
INSERT INTO state VALUES ('NY', 'New York');
INSERT INTO state VALUES ('NC', 'North Carolina');
INSERT INTO state VALUES ('ND', 'North Dakota');
INSERT INTO state VALUES ('OH', 'Ohio');
INSERT INTO state VALUES ('OK', 'Oklahoma');
INSERT INTO state VALUES ('OR', 'Oregon');
INSERT INTO state VALUES ('PA', 'Pennsylvania');
INSERT INTO state VALUES ('RI', 'Rhode Island');
INSERT INTO state VALUES ('SC', 'South Carolina');
INSERT INTO state VALUES ('SD', 'South Dakota');
INSERT INTO state VALUES ('TN', 'Tennessee');
INSERT INTO state VALUES ('TX', 'Texas');
INSERT INTO state VALUES ('UT', 'Utah');
INSERT INTO state VALUES ('VA', 'Virginia');
INSERT INTO state VALUES ('VT', 'Vermont');
INSERT INTO state VALUES ('WA', 'Washington');
INSERT INTO state VALUES ('DC', 'Washington D.C.');
INSERT INTO state VALUES ('WI', 'Wisconsin');
INSERT INTO state VALUES ('WV', 'West Virginia');
INSERT INTO state VALUES ('WY', 'Wyoming');


--
-- Data for TOC entry 540 (OID 553937)
-- Name: lookup_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_department VALUES (1, 'Customer Relations', false, 0, true);
INSERT INTO lookup_department VALUES (2, 'Engineering', false, 0, true);
INSERT INTO lookup_department VALUES (3, 'Billing', false, 0, true);
INSERT INTO lookup_department VALUES (4, 'Shipping/Receiving', false, 0, true);
INSERT INTO lookup_department VALUES (5, 'Purchasing', false, 0, true);
INSERT INTO lookup_department VALUES (6, 'Accounting', false, 0, true);
INSERT INTO lookup_department VALUES (7, 'Human Resources', false, 0, true);


--
-- Data for TOC entry 541 (OID 553947)
-- Name: lookup_orgaddress_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_orgaddress_types VALUES (1, 'Primary', false, 0, true);
INSERT INTO lookup_orgaddress_types VALUES (2, 'Auxiliary', false, 0, true);
INSERT INTO lookup_orgaddress_types VALUES (3, 'Billing', false, 0, true);
INSERT INTO lookup_orgaddress_types VALUES (4, 'Shipping', false, 0, true);


--
-- Data for TOC entry 542 (OID 553957)
-- Name: lookup_orgemail_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_orgemail_types VALUES (1, 'Primary', false, 0, true);
INSERT INTO lookup_orgemail_types VALUES (2, 'Auxiliary', false, 0, true);


--
-- Data for TOC entry 543 (OID 553967)
-- Name: lookup_orgphone_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_orgphone_types VALUES (1, 'Main', false, 0, true);
INSERT INTO lookup_orgphone_types VALUES (2, 'Fax', false, 0, true);


--
-- Data for TOC entry 544 (OID 553977)
-- Name: lookup_instantmessenger_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 545 (OID 553987)
-- Name: lookup_employment_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 546 (OID 553997)
-- Name: lookup_locale; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 547 (OID 554007)
-- Name: lookup_contactaddress_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_contactaddress_types VALUES (1, 'Business', false, 0, true);
INSERT INTO lookup_contactaddress_types VALUES (2, 'Home', false, 0, true);
INSERT INTO lookup_contactaddress_types VALUES (3, 'Other', false, 0, true);


--
-- Data for TOC entry 548 (OID 554017)
-- Name: lookup_contactemail_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_contactemail_types VALUES (1, 'Business', false, 0, true);
INSERT INTO lookup_contactemail_types VALUES (2, 'Personal', false, 0, true);
INSERT INTO lookup_contactemail_types VALUES (3, 'Other', false, 0, true);


--
-- Data for TOC entry 549 (OID 554027)
-- Name: lookup_contactphone_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_contactphone_types VALUES (1, 'Business', false, 0, true);
INSERT INTO lookup_contactphone_types VALUES (2, 'Business2', false, 0, true);
INSERT INTO lookup_contactphone_types VALUES (3, 'Business Fax', false, 0, true);
INSERT INTO lookup_contactphone_types VALUES (4, 'Home', false, 0, true);
INSERT INTO lookup_contactphone_types VALUES (5, 'Home2', false, 0, true);
INSERT INTO lookup_contactphone_types VALUES (6, 'Home Fax', false, 0, true);
INSERT INTO lookup_contactphone_types VALUES (7, 'Mobile', false, 0, true);
INSERT INTO lookup_contactphone_types VALUES (8, 'Pager', false, 0, true);
INSERT INTO lookup_contactphone_types VALUES (9, 'Other', false, 0, true);


--
-- Data for TOC entry 550 (OID 554037)
-- Name: lookup_access_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_access_types VALUES (1, 626030330, 'Controlled-Hierarchy', true, 1, true, 626030335);
INSERT INTO lookup_access_types VALUES (2, 626030330, 'Public', false, 2, true, 626030334);
INSERT INTO lookup_access_types VALUES (3, 626030330, 'Personal', false, 3, true, 626030333);
INSERT INTO lookup_access_types VALUES (4, 626030331, 'Public', true, 1, true, 626030334);
INSERT INTO lookup_access_types VALUES (5, 626030332, 'Public', true, 1, true, 626030334);
INSERT INTO lookup_access_types VALUES (6, 707031028, 'Controlled-Hierarchy', true, 1, true, 626030335);
INSERT INTO lookup_access_types VALUES (7, 707031028, 'Public', false, 2, true, 626030334);
INSERT INTO lookup_access_types VALUES (8, 707031028, 'Personal', false, 3, true, 626030333);


--
-- Data for TOC entry 551 (OID 554046)
-- Name: organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO organization VALUES (0, 'My Company', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, false, NULL, NULL, '2003-12-04 16:46:36.164', 0, '2003-12-04 16:46:36.164', 0, true, NULL, 0, -1, -1, -1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Data for TOC entry 552 (OID 554077)
-- Name: contact; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 553 (OID 554134)
-- Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO role VALUES (1, 'Administrator', 'Performs system configuration and maintenance', 0, '2003-12-04 16:47:31.438', 0, '2003-12-04 16:47:31.438', true);
INSERT INTO role VALUES (2, 'Operations Manager', 'Manages operations', 0, '2003-12-04 16:47:31.839', 0, '2003-12-04 16:47:31.839', true);
INSERT INTO role VALUES (3, 'Sales Manager', 'Manages all accounts and opportunities', 0, '2003-12-04 16:47:32.357', 0, '2003-12-04 16:47:32.357', true);
INSERT INTO role VALUES (4, 'Salesperson', 'Manages own accounts and opportunities', 0, '2003-12-04 16:47:32.705', 0, '2003-12-04 16:47:32.705', true);
INSERT INTO role VALUES (5, 'Customer Service Manager', 'Manages all tickets', 0, '2003-12-04 16:47:33.059', 0, '2003-12-04 16:47:33.059', true);
INSERT INTO role VALUES (6, 'Customer Service Representative', 'Manages own tickets', 0, '2003-12-04 16:47:33.332', 0, '2003-12-04 16:47:33.332', true);
INSERT INTO role VALUES (7, 'Marketing Manager', 'Manages communications', 0, '2003-12-04 16:47:33.526', 0, '2003-12-04 16:47:33.526', true);
INSERT INTO role VALUES (8, 'Accounting Manager', 'Reviews revenue and opportunities', 0, '2003-12-04 16:47:33.799', 0, '2003-12-04 16:47:33.799', true);
INSERT INTO role VALUES (9, 'HR Representative', 'Manages employee information', 0, '2003-12-04 16:47:34.056', 0, '2003-12-04 16:47:34.056', true);


--
-- Data for TOC entry 554 (OID 554153)
-- Name: permission_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO permission_category VALUES (1, 'Accounts', NULL, 500, true, true, true, true, false, false, false, false, true);
INSERT INTO permission_category VALUES (2, 'Contacts', NULL, 300, true, true, true, true, false, false, false, false, true);
INSERT INTO permission_category VALUES (3, 'Auto Guide', NULL, 600, false, false, false, false, false, false, false, false, false);
INSERT INTO permission_category VALUES (4, 'Pipeline', NULL, 400, true, true, false, true, true, false, false, false, true);
INSERT INTO permission_category VALUES (5, 'Demo', NULL, 1500, false, false, false, false, false, false, false, false, false);
INSERT INTO permission_category VALUES (6, 'Communications', NULL, 700, true, true, false, false, false, false, false, false, false);
INSERT INTO permission_category VALUES (7, 'Projects', NULL, 800, false, false, false, false, false, false, false, false, false);
INSERT INTO permission_category VALUES (8, 'Tickets', NULL, 900, true, true, true, true, false, false, false, false, true);
INSERT INTO permission_category VALUES (9, 'Admin', NULL, 1200, true, true, false, false, false, false, false, false, false);
INSERT INTO permission_category VALUES (10, 'Help', NULL, 1300, true, true, false, false, false, false, false, false, false);
INSERT INTO permission_category VALUES (11, 'System', NULL, 100, true, true, false, false, false, false, false, false, false);
INSERT INTO permission_category VALUES (12, 'My Home Page', NULL, 200, true, true, false, false, false, false, false, false, false);
INSERT INTO permission_category VALUES (13, 'QA', NULL, 1400, true, true, false, false, false, false, false, false, false);
INSERT INTO permission_category VALUES (14, 'Reports', NULL, 1100, true, true, false, false, false, false, false, false, false);
INSERT INTO permission_category VALUES (15, 'Employees', NULL, 1000, true, true, false, true, false, false, false, false, true);


--
-- Data for TOC entry 555 (OID 554170)
-- Name: permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO permission VALUES (1, 1, 'accounts', true, false, false, false, 'Access to Accounts module', 10, true, true, false);
INSERT INTO permission VALUES (2, 1, 'accounts-accounts', true, true, true, true, 'Account Records', 20, true, true, false);
INSERT INTO permission VALUES (3, 1, 'accounts-accounts-folders', true, true, true, false, 'Folders', 30, true, true, false);
INSERT INTO permission VALUES (4, 1, 'accounts-accounts-contacts', true, true, true, true, 'Contacts', 40, true, true, false);
INSERT INTO permission VALUES (5, 1, 'accounts-accounts-contacts-opportunities', true, true, true, true, 'Contact Opportunities', 50, true, true, false);
INSERT INTO permission VALUES (6, 1, 'accounts-accounts-contacts-calls', true, true, true, true, 'Contact Calls', 60, true, true, false);
INSERT INTO permission VALUES (7, 1, 'accounts-accounts-contacts-messages', true, true, true, true, 'Contact Messages', 70, true, true, false);
INSERT INTO permission VALUES (8, 1, 'accounts-accounts-opportunities', true, true, true, true, 'Opportunities', 80, true, true, false);
INSERT INTO permission VALUES (9, 1, 'accounts-accounts-tickets', true, true, true, true, 'Tickets', 90, true, true, false);
INSERT INTO permission VALUES (10, 1, 'accounts-accounts-documents', true, true, true, true, 'Documents', 100, true, true, false);
INSERT INTO permission VALUES (11, 1, 'accounts-accounts-reports', true, true, false, true, 'Export Account Data', 110, true, true, false);
INSERT INTO permission VALUES (12, 1, 'accounts-dashboard', true, false, false, false, 'Dashboard', 120, true, true, false);
INSERT INTO permission VALUES (13, 1, 'accounts-accounts-revenue', true, true, true, true, 'Revenue', 130, false, false, false);
INSERT INTO permission VALUES (14, 1, 'accounts-autoguide-inventory', true, true, true, true, 'Auto Guide Vehicle Inventory', 140, false, false, false);
INSERT INTO permission VALUES (15, 1, 'accounts-accounts-tickets-documents', true, true, true, true, 'Ticket Documents', 150, true, true, false);
INSERT INTO permission VALUES (16, 1, 'accounts-accounts-tickets-tasks', true, true, true, true, 'Ticket Tasks', 160, true, true, false);
INSERT INTO permission VALUES (17, 2, 'contacts', true, false, false, false, 'Access to Contacts module', 10, true, true, false);
INSERT INTO permission VALUES (18, 2, 'contacts-external_contacts', true, true, true, true, 'General Contact Records', 20, true, true, false);
INSERT INTO permission VALUES (19, 2, 'contacts-external_contacts-reports', true, true, false, true, 'Export Contact Data', 30, true, true, false);
INSERT INTO permission VALUES (20, 2, 'contacts-external_contacts-folders', true, true, true, true, 'Folders', 40, true, true, false);
INSERT INTO permission VALUES (21, 2, 'contacts-external_contacts-calls', true, true, true, true, 'Calls', 50, true, true, false);
INSERT INTO permission VALUES (22, 2, 'contacts-external_contacts-messages', true, false, false, false, 'Messages', 60, true, true, false);
INSERT INTO permission VALUES (23, 2, 'contacts-external_contacts-opportunities', true, true, true, true, 'Opportunities', 70, true, true, false);
INSERT INTO permission VALUES (24, 3, 'autoguide', true, false, false, false, 'Access to the Auto Guide module', 10, true, true, false);
INSERT INTO permission VALUES (25, 3, 'autoguide-adruns', false, false, true, false, 'Ad Run complete status', 20, true, true, false);
INSERT INTO permission VALUES (26, 4, 'pipeline', true, false, false, false, 'Access to Pipeline module', 10, true, true, true);
INSERT INTO permission VALUES (27, 4, 'pipeline-opportunities', true, true, true, true, 'Opportunity Records', 20, true, true, false);
INSERT INTO permission VALUES (28, 4, 'pipeline-dashboard', true, false, false, false, 'Dashboard', 30, true, true, false);
INSERT INTO permission VALUES (29, 4, 'pipeline-reports', true, true, false, true, 'Export Opportunity Data', 40, true, true, false);
INSERT INTO permission VALUES (30, 4, 'pipeline-opportunities-calls', true, true, true, true, 'Calls', 50, true, true, false);
INSERT INTO permission VALUES (31, 4, 'pipeline-opportunities-documents', true, true, true, true, 'Documents', 60, true, true, false);
INSERT INTO permission VALUES (32, 5, 'demo', true, true, true, true, 'Access to Demo/Non-working features', 10, true, true, false);
INSERT INTO permission VALUES (33, 6, 'campaign', true, false, false, false, 'Access to Communications module', 10, true, true, false);
INSERT INTO permission VALUES (34, 6, 'campaign-dashboard', true, false, false, false, 'Dashboard', 20, true, true, false);
INSERT INTO permission VALUES (35, 6, 'campaign-campaigns', true, true, true, true, 'Campaign Records', 30, true, true, false);
INSERT INTO permission VALUES (36, 6, 'campaign-campaigns-groups', true, true, true, true, 'Group Records', 40, true, true, false);
INSERT INTO permission VALUES (37, 6, 'campaign-campaigns-messages', true, true, true, true, 'Message Records', 50, true, true, false);
INSERT INTO permission VALUES (38, 6, 'campaign-campaigns-surveys', true, true, true, true, 'Survey Records', 60, true, true, false);
INSERT INTO permission VALUES (39, 7, 'projects', true, false, false, false, 'Access to Project Management module', 10, true, true, false);
INSERT INTO permission VALUES (40, 7, 'projects-personal', true, false, false, false, 'Personal View', 20, true, true, false);
INSERT INTO permission VALUES (41, 7, 'projects-enterprise', true, false, false, false, 'Enterprise View', 30, true, true, false);
INSERT INTO permission VALUES (42, 7, 'projects-projects', true, true, true, true, 'Project Records', 40, true, true, false);
INSERT INTO permission VALUES (43, 8, 'tickets', true, false, false, false, 'Access to Ticket module', 10, true, true, false);
INSERT INTO permission VALUES (44, 8, 'tickets-tickets', true, true, true, true, 'Ticket Records', 20, true, true, false);
INSERT INTO permission VALUES (45, 8, 'tickets-reports', true, true, true, true, 'Export Ticket Data', 30, true, true, false);
INSERT INTO permission VALUES (46, 8, 'tickets-tickets-tasks', true, true, true, true, 'Tasks', 40, true, true, false);
INSERT INTO permission VALUES (47, 9, 'admin', true, false, false, false, 'Access to Admin module', 10, true, true, false);
INSERT INTO permission VALUES (48, 9, 'admin-users', true, true, true, true, 'Users', 20, true, true, false);
INSERT INTO permission VALUES (49, 9, 'admin-roles', true, true, true, true, 'Roles', 30, true, true, false);
INSERT INTO permission VALUES (50, 9, 'admin-usage', true, false, false, false, 'System Usage', 40, true, true, false);
INSERT INTO permission VALUES (51, 9, 'admin-sysconfig', true, false, true, false, 'System Configuration', 50, true, true, false);
INSERT INTO permission VALUES (52, 9, 'admin-sysconfig-lists', true, false, true, false, 'Configure Lookup Lists', 60, true, true, false);
INSERT INTO permission VALUES (53, 9, 'admin-sysconfig-folders', true, true, true, true, 'Configure Custom Folders & Fields', 70, true, true, false);
INSERT INTO permission VALUES (54, 9, 'admin-object-workflow', true, true, true, true, 'Configure Object Workflow', 80, true, true, false);
INSERT INTO permission VALUES (55, 9, 'admin-sysconfig-categories', true, true, true, true, 'Categories', 90, true, true, false);
INSERT INTO permission VALUES (56, 10, 'help', true, false, false, false, 'Access to Help System', 10, true, true, false);
INSERT INTO permission VALUES (57, 11, 'globalitems-search', true, false, false, false, 'Access to Global Search', 10, true, true, false);
INSERT INTO permission VALUES (58, 11, 'globalitems-myitems', true, false, false, false, 'Access to My Items', 20, true, true, false);
INSERT INTO permission VALUES (59, 11, 'globalitems-recentitems', true, false, false, false, 'Access to Recent Items', 30, true, true, false);
INSERT INTO permission VALUES (60, 12, 'myhomepage', true, false, false, false, 'Access to My Home Page module', 10, true, true, false);
INSERT INTO permission VALUES (61, 12, 'myhomepage-dashboard', true, false, false, false, 'View Performance Dashboard', 20, true, true, false);
INSERT INTO permission VALUES (62, 12, 'myhomepage-miner', true, true, false, true, 'Industry News records', 30, false, false, false);
INSERT INTO permission VALUES (63, 12, 'myhomepage-inbox', true, false, false, false, 'My Mailbox', 40, true, true, false);
INSERT INTO permission VALUES (64, 12, 'myhomepage-tasks', true, true, true, true, 'My Tasks', 50, true, true, false);
INSERT INTO permission VALUES (65, 12, 'myhomepage-reassign', true, false, true, false, 'Re-assign Items', 60, true, true, false);
INSERT INTO permission VALUES (66, 12, 'myhomepage-profile', true, false, false, false, 'My Profile', 70, true, true, false);
INSERT INTO permission VALUES (67, 12, 'myhomepage-profile-personal', true, false, true, false, 'Personal Information', 80, true, true, false);
INSERT INTO permission VALUES (68, 12, 'myhomepage-profile-settings', true, false, true, false, 'Settings', 90, false, false, false);
INSERT INTO permission VALUES (69, 12, 'myhomepage-profile-password', false, false, true, false, 'Password', 100, true, true, false);
INSERT INTO permission VALUES (70, 12, 'myhomepage-action-lists', true, true, true, true, 'My Action Lists', 110, true, true, false);
INSERT INTO permission VALUES (71, 13, 'qa', true, true, true, true, 'Access to QA Tool', 10, true, true, false);
INSERT INTO permission VALUES (72, 14, 'reports', true, false, false, false, 'Access to Reports module', 10, true, true, false);
INSERT INTO permission VALUES (73, 15, 'employees', true, false, false, false, 'Access to Employee module', 10, true, true, false);
INSERT INTO permission VALUES (74, 15, 'contacts-internal_contacts', true, true, true, true, 'Employees', 20, true, true, false);


--
-- Data for TOC entry 556 (OID 554190)
-- Name: role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO role_permission VALUES (1, 1, 60, true, false, false, false);
INSERT INTO role_permission VALUES (2, 1, 61, true, false, false, false);
INSERT INTO role_permission VALUES (3, 1, 62, true, true, false, true);
INSERT INTO role_permission VALUES (4, 1, 63, true, false, false, false);
INSERT INTO role_permission VALUES (5, 1, 64, true, true, true, true);
INSERT INTO role_permission VALUES (6, 1, 66, true, false, false, false);
INSERT INTO role_permission VALUES (7, 1, 67, true, false, true, false);
INSERT INTO role_permission VALUES (8, 1, 68, true, false, true, false);
INSERT INTO role_permission VALUES (9, 1, 69, false, false, true, false);
INSERT INTO role_permission VALUES (10, 1, 65, true, false, true, false);
INSERT INTO role_permission VALUES (11, 1, 17, true, false, false, false);
INSERT INTO role_permission VALUES (12, 1, 18, true, true, true, true);
INSERT INTO role_permission VALUES (13, 1, 1, true, false, false, false);
INSERT INTO role_permission VALUES (14, 1, 2, true, true, true, true);
INSERT INTO role_permission VALUES (15, 1, 3, true, true, true, true);
INSERT INTO role_permission VALUES (16, 1, 4, true, true, true, true);
INSERT INTO role_permission VALUES (17, 1, 5, true, true, true, true);
INSERT INTO role_permission VALUES (18, 1, 6, true, true, true, true);
INSERT INTO role_permission VALUES (19, 1, 7, true, true, true, true);
INSERT INTO role_permission VALUES (20, 1, 8, true, true, true, true);
INSERT INTO role_permission VALUES (21, 1, 9, true, true, true, true);
INSERT INTO role_permission VALUES (22, 1, 10, true, true, true, true);
INSERT INTO role_permission VALUES (23, 1, 11, true, true, false, true);
INSERT INTO role_permission VALUES (24, 1, 33, true, false, false, false);
INSERT INTO role_permission VALUES (25, 1, 34, true, false, false, false);
INSERT INTO role_permission VALUES (26, 1, 35, true, true, true, true);
INSERT INTO role_permission VALUES (27, 1, 43, true, false, false, false);
INSERT INTO role_permission VALUES (28, 1, 44, true, true, true, true);
INSERT INTO role_permission VALUES (29, 1, 45, true, true, true, true);
INSERT INTO role_permission VALUES (30, 1, 46, true, true, true, true);
INSERT INTO role_permission VALUES (31, 1, 73, true, true, true, false);
INSERT INTO role_permission VALUES (32, 1, 74, true, true, true, true);
INSERT INTO role_permission VALUES (33, 1, 72, true, false, false, false);
INSERT INTO role_permission VALUES (34, 1, 47, true, false, false, false);
INSERT INTO role_permission VALUES (35, 1, 48, true, true, true, true);
INSERT INTO role_permission VALUES (36, 1, 49, true, true, true, true);
INSERT INTO role_permission VALUES (37, 1, 51, true, false, true, false);
INSERT INTO role_permission VALUES (38, 1, 50, true, false, false, false);
INSERT INTO role_permission VALUES (39, 1, 52, true, false, true, false);
INSERT INTO role_permission VALUES (40, 1, 53, true, true, true, true);
INSERT INTO role_permission VALUES (41, 1, 54, true, true, true, true);
INSERT INTO role_permission VALUES (42, 1, 55, true, true, true, true);
INSERT INTO role_permission VALUES (43, 1, 56, true, false, false, false);
INSERT INTO role_permission VALUES (44, 1, 57, true, false, false, false);
INSERT INTO role_permission VALUES (45, 1, 58, true, false, false, false);
INSERT INTO role_permission VALUES (46, 1, 59, true, false, false, false);
INSERT INTO role_permission VALUES (47, 2, 60, true, false, false, false);
INSERT INTO role_permission VALUES (48, 2, 61, true, false, false, false);
INSERT INTO role_permission VALUES (49, 2, 63, true, false, false, false);
INSERT INTO role_permission VALUES (50, 2, 64, true, true, true, true);
INSERT INTO role_permission VALUES (51, 2, 65, true, false, true, false);
INSERT INTO role_permission VALUES (52, 2, 66, true, false, false, false);
INSERT INTO role_permission VALUES (53, 2, 67, true, false, true, false);
INSERT INTO role_permission VALUES (54, 2, 68, true, false, true, false);
INSERT INTO role_permission VALUES (55, 2, 69, false, false, true, false);
INSERT INTO role_permission VALUES (56, 2, 70, true, true, true, true);
INSERT INTO role_permission VALUES (57, 2, 17, true, false, false, false);
INSERT INTO role_permission VALUES (58, 2, 18, true, true, true, true);
INSERT INTO role_permission VALUES (59, 2, 19, true, true, false, true);
INSERT INTO role_permission VALUES (60, 2, 20, true, true, true, true);
INSERT INTO role_permission VALUES (61, 2, 21, true, true, true, true);
INSERT INTO role_permission VALUES (62, 2, 22, true, false, false, false);
INSERT INTO role_permission VALUES (63, 2, 23, true, true, true, true);
INSERT INTO role_permission VALUES (64, 2, 26, true, false, false, false);
INSERT INTO role_permission VALUES (65, 2, 27, true, true, true, true);
INSERT INTO role_permission VALUES (66, 2, 28, true, false, false, false);
INSERT INTO role_permission VALUES (67, 2, 29, true, true, false, true);
INSERT INTO role_permission VALUES (68, 2, 30, true, true, true, true);
INSERT INTO role_permission VALUES (69, 2, 31, true, true, true, true);
INSERT INTO role_permission VALUES (70, 2, 1, true, false, false, false);
INSERT INTO role_permission VALUES (71, 2, 2, true, true, true, true);
INSERT INTO role_permission VALUES (72, 2, 3, true, true, true, false);
INSERT INTO role_permission VALUES (73, 2, 4, true, true, true, true);
INSERT INTO role_permission VALUES (74, 2, 5, true, true, true, true);
INSERT INTO role_permission VALUES (75, 2, 6, true, true, true, true);
INSERT INTO role_permission VALUES (76, 2, 7, true, true, true, true);
INSERT INTO role_permission VALUES (77, 2, 8, true, true, true, true);
INSERT INTO role_permission VALUES (78, 2, 9, true, true, true, true);
INSERT INTO role_permission VALUES (79, 2, 10, true, true, true, true);
INSERT INTO role_permission VALUES (80, 2, 11, true, true, false, true);
INSERT INTO role_permission VALUES (81, 2, 13, true, true, true, true);
INSERT INTO role_permission VALUES (82, 2, 15, true, true, true, true);
INSERT INTO role_permission VALUES (83, 2, 16, true, true, true, true);
INSERT INTO role_permission VALUES (84, 2, 33, true, false, false, false);
INSERT INTO role_permission VALUES (85, 2, 34, true, false, false, false);
INSERT INTO role_permission VALUES (86, 2, 35, true, true, true, true);
INSERT INTO role_permission VALUES (87, 2, 36, true, true, true, true);
INSERT INTO role_permission VALUES (88, 2, 37, true, true, true, true);
INSERT INTO role_permission VALUES (89, 2, 38, true, true, true, true);
INSERT INTO role_permission VALUES (90, 2, 43, true, false, false, false);
INSERT INTO role_permission VALUES (91, 2, 44, true, true, true, false);
INSERT INTO role_permission VALUES (92, 2, 45, true, true, true, true);
INSERT INTO role_permission VALUES (93, 2, 46, true, true, true, false);
INSERT INTO role_permission VALUES (94, 2, 73, true, false, false, false);
INSERT INTO role_permission VALUES (95, 2, 74, true, false, false, false);
INSERT INTO role_permission VALUES (96, 2, 72, true, false, false, false);
INSERT INTO role_permission VALUES (97, 2, 56, true, false, false, false);
INSERT INTO role_permission VALUES (98, 2, 57, true, false, false, false);
INSERT INTO role_permission VALUES (99, 2, 58, true, false, false, false);
INSERT INTO role_permission VALUES (100, 2, 59, true, false, false, false);
INSERT INTO role_permission VALUES (101, 3, 60, true, false, false, false);
INSERT INTO role_permission VALUES (102, 3, 61, true, false, false, false);
INSERT INTO role_permission VALUES (103, 3, 63, true, false, false, false);
INSERT INTO role_permission VALUES (104, 3, 64, true, true, true, true);
INSERT INTO role_permission VALUES (105, 3, 65, true, false, true, false);
INSERT INTO role_permission VALUES (106, 3, 66, true, false, false, false);
INSERT INTO role_permission VALUES (107, 3, 67, true, false, true, false);
INSERT INTO role_permission VALUES (108, 3, 68, true, false, true, false);
INSERT INTO role_permission VALUES (109, 3, 69, false, false, true, false);
INSERT INTO role_permission VALUES (110, 3, 70, true, true, true, true);
INSERT INTO role_permission VALUES (111, 3, 17, true, false, false, false);
INSERT INTO role_permission VALUES (112, 3, 18, true, true, true, true);
INSERT INTO role_permission VALUES (113, 3, 19, true, true, false, true);
INSERT INTO role_permission VALUES (114, 3, 20, true, true, true, true);
INSERT INTO role_permission VALUES (115, 3, 21, true, true, true, true);
INSERT INTO role_permission VALUES (116, 3, 22, true, false, false, false);
INSERT INTO role_permission VALUES (117, 3, 23, true, true, true, true);
INSERT INTO role_permission VALUES (118, 3, 26, true, false, false, false);
INSERT INTO role_permission VALUES (119, 3, 27, true, true, true, true);
INSERT INTO role_permission VALUES (120, 3, 28, true, false, false, false);
INSERT INTO role_permission VALUES (121, 3, 29, true, true, false, true);
INSERT INTO role_permission VALUES (122, 3, 30, true, true, true, true);
INSERT INTO role_permission VALUES (123, 3, 31, true, true, true, true);
INSERT INTO role_permission VALUES (124, 3, 1, true, false, false, false);
INSERT INTO role_permission VALUES (125, 3, 2, true, true, true, true);
INSERT INTO role_permission VALUES (126, 3, 3, true, true, true, false);
INSERT INTO role_permission VALUES (127, 3, 4, true, true, true, true);
INSERT INTO role_permission VALUES (128, 3, 5, true, true, true, true);
INSERT INTO role_permission VALUES (129, 3, 6, true, true, true, true);
INSERT INTO role_permission VALUES (130, 3, 7, true, true, true, true);
INSERT INTO role_permission VALUES (131, 3, 8, true, true, true, true);
INSERT INTO role_permission VALUES (132, 3, 9, true, true, true, true);
INSERT INTO role_permission VALUES (133, 3, 10, true, true, true, true);
INSERT INTO role_permission VALUES (134, 3, 11, true, true, false, true);
INSERT INTO role_permission VALUES (135, 3, 12, true, false, false, false);
INSERT INTO role_permission VALUES (136, 3, 13, true, true, true, true);
INSERT INTO role_permission VALUES (137, 3, 15, true, true, true, true);
INSERT INTO role_permission VALUES (138, 3, 16, true, true, true, true);
INSERT INTO role_permission VALUES (139, 3, 33, true, false, false, false);
INSERT INTO role_permission VALUES (140, 3, 34, true, false, false, false);
INSERT INTO role_permission VALUES (141, 3, 35, true, true, true, true);
INSERT INTO role_permission VALUES (142, 3, 36, true, true, true, true);
INSERT INTO role_permission VALUES (143, 3, 37, true, true, true, true);
INSERT INTO role_permission VALUES (144, 3, 38, true, true, true, true);
INSERT INTO role_permission VALUES (145, 3, 43, true, false, false, false);
INSERT INTO role_permission VALUES (146, 3, 44, true, true, true, false);
INSERT INTO role_permission VALUES (147, 3, 45, true, true, true, true);
INSERT INTO role_permission VALUES (148, 3, 46, true, true, true, false);
INSERT INTO role_permission VALUES (149, 3, 73, true, false, false, false);
INSERT INTO role_permission VALUES (150, 3, 74, true, false, false, false);
INSERT INTO role_permission VALUES (151, 3, 72, true, false, false, false);
INSERT INTO role_permission VALUES (152, 3, 56, true, false, false, false);
INSERT INTO role_permission VALUES (153, 3, 57, true, false, false, false);
INSERT INTO role_permission VALUES (154, 3, 58, true, false, false, false);
INSERT INTO role_permission VALUES (155, 3, 59, true, false, false, false);
INSERT INTO role_permission VALUES (156, 4, 60, true, false, false, false);
INSERT INTO role_permission VALUES (157, 4, 61, true, false, false, false);
INSERT INTO role_permission VALUES (158, 4, 63, true, false, false, false);
INSERT INTO role_permission VALUES (159, 4, 64, true, true, true, true);
INSERT INTO role_permission VALUES (160, 4, 66, true, false, false, false);
INSERT INTO role_permission VALUES (161, 4, 67, true, false, true, false);
INSERT INTO role_permission VALUES (162, 4, 68, true, false, true, false);
INSERT INTO role_permission VALUES (163, 4, 69, false, false, true, false);
INSERT INTO role_permission VALUES (164, 4, 70, true, true, true, true);
INSERT INTO role_permission VALUES (165, 4, 17, true, false, false, false);
INSERT INTO role_permission VALUES (166, 4, 18, true, true, true, true);
INSERT INTO role_permission VALUES (167, 4, 19, true, true, false, true);
INSERT INTO role_permission VALUES (168, 4, 21, true, true, true, true);
INSERT INTO role_permission VALUES (169, 4, 22, true, true, true, true);
INSERT INTO role_permission VALUES (170, 4, 23, true, false, false, false);
INSERT INTO role_permission VALUES (171, 4, 26, true, false, false, false);
INSERT INTO role_permission VALUES (172, 4, 27, true, true, true, false);
INSERT INTO role_permission VALUES (173, 4, 28, true, false, false, false);
INSERT INTO role_permission VALUES (174, 4, 29, true, true, false, true);
INSERT INTO role_permission VALUES (175, 4, 30, true, true, true, true);
INSERT INTO role_permission VALUES (176, 4, 31, true, true, true, true);
INSERT INTO role_permission VALUES (177, 4, 1, true, false, false, false);
INSERT INTO role_permission VALUES (178, 4, 2, true, true, true, false);
INSERT INTO role_permission VALUES (179, 4, 3, true, true, true, false);
INSERT INTO role_permission VALUES (180, 4, 4, true, true, true, false);
INSERT INTO role_permission VALUES (181, 4, 5, true, true, true, false);
INSERT INTO role_permission VALUES (182, 4, 6, true, true, true, false);
INSERT INTO role_permission VALUES (183, 4, 7, true, true, true, false);
INSERT INTO role_permission VALUES (184, 4, 8, true, true, true, false);
INSERT INTO role_permission VALUES (185, 4, 9, true, true, true, false);
INSERT INTO role_permission VALUES (186, 4, 10, true, true, true, false);
INSERT INTO role_permission VALUES (187, 4, 11, true, true, false, true);
INSERT INTO role_permission VALUES (188, 4, 12, true, false, false, false);
INSERT INTO role_permission VALUES (189, 4, 13, true, true, true, false);
INSERT INTO role_permission VALUES (190, 4, 15, true, true, true, false);
INSERT INTO role_permission VALUES (191, 4, 16, true, true, true, false);
INSERT INTO role_permission VALUES (192, 4, 33, true, false, false, false);
INSERT INTO role_permission VALUES (193, 4, 34, true, false, false, false);
INSERT INTO role_permission VALUES (194, 4, 35, true, true, true, true);
INSERT INTO role_permission VALUES (195, 4, 36, true, true, true, true);
INSERT INTO role_permission VALUES (196, 4, 37, true, true, true, true);
INSERT INTO role_permission VALUES (197, 4, 38, true, true, true, true);
INSERT INTO role_permission VALUES (198, 4, 43, true, false, false, false);
INSERT INTO role_permission VALUES (199, 4, 44, true, true, true, false);
INSERT INTO role_permission VALUES (200, 4, 45, true, true, false, true);
INSERT INTO role_permission VALUES (201, 4, 46, true, true, true, false);
INSERT INTO role_permission VALUES (202, 4, 73, true, false, false, false);
INSERT INTO role_permission VALUES (203, 4, 74, true, false, false, false);
INSERT INTO role_permission VALUES (204, 4, 72, true, false, false, false);
INSERT INTO role_permission VALUES (205, 4, 56, true, false, false, false);
INSERT INTO role_permission VALUES (206, 4, 57, true, false, false, false);
INSERT INTO role_permission VALUES (207, 4, 58, true, false, false, false);
INSERT INTO role_permission VALUES (208, 4, 59, true, false, false, false);
INSERT INTO role_permission VALUES (209, 5, 60, true, false, false, false);
INSERT INTO role_permission VALUES (210, 5, 61, true, false, false, false);
INSERT INTO role_permission VALUES (211, 5, 63, true, false, false, false);
INSERT INTO role_permission VALUES (212, 5, 64, true, true, true, true);
INSERT INTO role_permission VALUES (213, 5, 65, true, false, true, false);
INSERT INTO role_permission VALUES (214, 5, 66, true, false, false, false);
INSERT INTO role_permission VALUES (215, 5, 67, true, false, true, false);
INSERT INTO role_permission VALUES (216, 5, 68, true, false, true, false);
INSERT INTO role_permission VALUES (217, 5, 69, false, false, true, false);
INSERT INTO role_permission VALUES (218, 5, 1, true, false, false, false);
INSERT INTO role_permission VALUES (219, 5, 2, true, true, true, false);
INSERT INTO role_permission VALUES (220, 5, 3, true, true, true, false);
INSERT INTO role_permission VALUES (221, 5, 4, true, true, true, false);
INSERT INTO role_permission VALUES (222, 5, 6, true, true, true, false);
INSERT INTO role_permission VALUES (223, 5, 7, true, true, true, false);
INSERT INTO role_permission VALUES (224, 5, 9, true, true, true, false);
INSERT INTO role_permission VALUES (225, 5, 10, true, true, true, false);
INSERT INTO role_permission VALUES (226, 5, 11, true, true, false, true);
INSERT INTO role_permission VALUES (227, 5, 15, true, true, true, false);
INSERT INTO role_permission VALUES (228, 5, 16, true, true, true, false);
INSERT INTO role_permission VALUES (229, 5, 33, true, false, false, false);
INSERT INTO role_permission VALUES (230, 5, 34, true, false, false, false);
INSERT INTO role_permission VALUES (231, 5, 35, true, true, true, true);
INSERT INTO role_permission VALUES (232, 5, 36, true, true, true, true);
INSERT INTO role_permission VALUES (233, 5, 37, true, true, true, true);
INSERT INTO role_permission VALUES (234, 5, 38, true, true, true, true);
INSERT INTO role_permission VALUES (235, 5, 43, true, false, false, false);
INSERT INTO role_permission VALUES (236, 5, 44, true, true, true, true);
INSERT INTO role_permission VALUES (237, 5, 45, true, true, true, true);
INSERT INTO role_permission VALUES (238, 5, 46, true, true, true, true);
INSERT INTO role_permission VALUES (239, 5, 73, true, false, false, false);
INSERT INTO role_permission VALUES (240, 5, 74, true, false, false, false);
INSERT INTO role_permission VALUES (241, 5, 72, true, false, false, false);
INSERT INTO role_permission VALUES (242, 5, 56, true, false, false, false);
INSERT INTO role_permission VALUES (243, 5, 57, true, false, false, false);
INSERT INTO role_permission VALUES (244, 5, 58, true, false, false, false);
INSERT INTO role_permission VALUES (245, 5, 59, true, false, false, false);
INSERT INTO role_permission VALUES (246, 6, 60, true, false, false, false);
INSERT INTO role_permission VALUES (247, 6, 61, true, false, false, false);
INSERT INTO role_permission VALUES (248, 6, 63, true, false, false, false);
INSERT INTO role_permission VALUES (249, 6, 64, true, true, true, true);
INSERT INTO role_permission VALUES (250, 6, 65, true, false, true, false);
INSERT INTO role_permission VALUES (251, 6, 66, true, false, false, false);
INSERT INTO role_permission VALUES (252, 6, 67, true, false, true, false);
INSERT INTO role_permission VALUES (253, 6, 68, true, false, true, false);
INSERT INTO role_permission VALUES (254, 6, 69, false, false, true, false);
INSERT INTO role_permission VALUES (255, 6, 1, true, false, false, false);
INSERT INTO role_permission VALUES (256, 6, 2, true, true, true, false);
INSERT INTO role_permission VALUES (257, 6, 3, true, true, true, false);
INSERT INTO role_permission VALUES (258, 6, 4, true, true, true, false);
INSERT INTO role_permission VALUES (259, 6, 6, true, true, true, false);
INSERT INTO role_permission VALUES (260, 6, 7, true, true, true, false);
INSERT INTO role_permission VALUES (261, 6, 9, true, true, true, false);
INSERT INTO role_permission VALUES (262, 6, 10, true, true, true, false);
INSERT INTO role_permission VALUES (263, 6, 11, true, true, false, true);
INSERT INTO role_permission VALUES (264, 6, 15, true, true, true, false);
INSERT INTO role_permission VALUES (265, 6, 16, true, true, true, false);
INSERT INTO role_permission VALUES (266, 6, 33, true, false, false, false);
INSERT INTO role_permission VALUES (267, 6, 34, true, false, false, false);
INSERT INTO role_permission VALUES (268, 6, 35, true, true, true, true);
INSERT INTO role_permission VALUES (269, 6, 36, true, true, true, true);
INSERT INTO role_permission VALUES (270, 6, 37, true, true, true, true);
INSERT INTO role_permission VALUES (271, 6, 38, true, true, true, true);
INSERT INTO role_permission VALUES (272, 6, 43, true, false, false, false);
INSERT INTO role_permission VALUES (273, 6, 44, true, true, true, false);
INSERT INTO role_permission VALUES (274, 6, 45, true, true, true, false);
INSERT INTO role_permission VALUES (275, 6, 46, true, true, true, false);
INSERT INTO role_permission VALUES (276, 6, 73, true, false, false, false);
INSERT INTO role_permission VALUES (277, 6, 74, true, false, false, false);
INSERT INTO role_permission VALUES (278, 6, 72, true, false, false, false);
INSERT INTO role_permission VALUES (279, 6, 56, true, false, false, false);
INSERT INTO role_permission VALUES (280, 6, 57, true, false, false, false);
INSERT INTO role_permission VALUES (281, 6, 58, true, false, false, false);
INSERT INTO role_permission VALUES (282, 6, 59, true, false, false, false);
INSERT INTO role_permission VALUES (283, 7, 60, true, false, false, false);
INSERT INTO role_permission VALUES (284, 7, 61, true, false, false, false);
INSERT INTO role_permission VALUES (285, 7, 63, true, false, false, false);
INSERT INTO role_permission VALUES (286, 7, 64, true, true, true, true);
INSERT INTO role_permission VALUES (287, 7, 65, true, false, true, false);
INSERT INTO role_permission VALUES (288, 7, 66, true, false, false, false);
INSERT INTO role_permission VALUES (289, 7, 67, true, false, true, false);
INSERT INTO role_permission VALUES (290, 7, 68, true, false, true, false);
INSERT INTO role_permission VALUES (291, 7, 69, false, false, true, false);
INSERT INTO role_permission VALUES (292, 7, 70, true, true, true, true);
INSERT INTO role_permission VALUES (293, 7, 17, true, false, false, false);
INSERT INTO role_permission VALUES (294, 7, 18, true, true, true, true);
INSERT INTO role_permission VALUES (295, 7, 19, true, true, false, true);
INSERT INTO role_permission VALUES (296, 7, 20, true, true, true, true);
INSERT INTO role_permission VALUES (297, 7, 21, true, true, true, true);
INSERT INTO role_permission VALUES (298, 7, 22, true, false, false, false);
INSERT INTO role_permission VALUES (299, 7, 23, true, true, true, true);
INSERT INTO role_permission VALUES (300, 7, 26, true, false, false, false);
INSERT INTO role_permission VALUES (301, 7, 27, true, true, true, true);
INSERT INTO role_permission VALUES (302, 7, 28, true, false, false, false);
INSERT INTO role_permission VALUES (303, 7, 29, true, true, false, true);
INSERT INTO role_permission VALUES (304, 7, 30, true, true, true, true);
INSERT INTO role_permission VALUES (305, 7, 31, true, true, true, true);
INSERT INTO role_permission VALUES (306, 7, 1, true, false, false, false);
INSERT INTO role_permission VALUES (307, 7, 2, true, true, true, false);
INSERT INTO role_permission VALUES (308, 7, 3, true, true, true, false);
INSERT INTO role_permission VALUES (309, 7, 4, true, true, true, false);
INSERT INTO role_permission VALUES (310, 7, 5, true, true, true, false);
INSERT INTO role_permission VALUES (311, 7, 6, true, true, true, false);
INSERT INTO role_permission VALUES (312, 7, 7, true, true, true, false);
INSERT INTO role_permission VALUES (313, 7, 8, true, true, true, false);
INSERT INTO role_permission VALUES (314, 7, 9, true, true, true, false);
INSERT INTO role_permission VALUES (315, 7, 10, true, true, true, false);
INSERT INTO role_permission VALUES (316, 7, 11, true, true, false, true);
INSERT INTO role_permission VALUES (317, 7, 12, true, false, false, false);
INSERT INTO role_permission VALUES (318, 7, 13, true, true, true, false);
INSERT INTO role_permission VALUES (319, 7, 15, true, true, true, false);
INSERT INTO role_permission VALUES (320, 7, 16, true, true, true, false);
INSERT INTO role_permission VALUES (321, 7, 33, true, false, false, false);
INSERT INTO role_permission VALUES (322, 7, 34, true, false, false, false);
INSERT INTO role_permission VALUES (323, 7, 35, true, true, true, true);
INSERT INTO role_permission VALUES (324, 7, 36, true, true, true, true);
INSERT INTO role_permission VALUES (325, 7, 37, true, true, true, true);
INSERT INTO role_permission VALUES (326, 7, 38, true, true, true, true);
INSERT INTO role_permission VALUES (327, 7, 43, true, false, false, false);
INSERT INTO role_permission VALUES (328, 7, 44, true, true, true, false);
INSERT INTO role_permission VALUES (329, 7, 45, true, true, true, false);
INSERT INTO role_permission VALUES (330, 7, 46, true, true, true, false);
INSERT INTO role_permission VALUES (331, 7, 73, true, false, false, false);
INSERT INTO role_permission VALUES (332, 7, 74, true, false, false, false);
INSERT INTO role_permission VALUES (333, 7, 72, true, false, false, false);
INSERT INTO role_permission VALUES (334, 7, 56, true, false, false, false);
INSERT INTO role_permission VALUES (335, 7, 57, true, false, false, false);
INSERT INTO role_permission VALUES (336, 7, 58, true, false, false, false);
INSERT INTO role_permission VALUES (337, 7, 59, true, false, false, false);
INSERT INTO role_permission VALUES (338, 8, 60, true, false, false, false);
INSERT INTO role_permission VALUES (339, 8, 61, true, false, false, false);
INSERT INTO role_permission VALUES (340, 8, 63, true, false, false, false);
INSERT INTO role_permission VALUES (341, 8, 64, true, true, true, true);
INSERT INTO role_permission VALUES (342, 8, 65, true, false, true, false);
INSERT INTO role_permission VALUES (343, 8, 66, true, false, false, false);
INSERT INTO role_permission VALUES (344, 8, 67, true, false, true, false);
INSERT INTO role_permission VALUES (345, 8, 68, true, false, true, false);
INSERT INTO role_permission VALUES (346, 8, 69, false, false, true, false);
INSERT INTO role_permission VALUES (347, 8, 17, true, false, false, false);
INSERT INTO role_permission VALUES (348, 8, 18, true, true, true, true);
INSERT INTO role_permission VALUES (349, 8, 19, true, true, false, true);
INSERT INTO role_permission VALUES (350, 8, 20, true, true, true, true);
INSERT INTO role_permission VALUES (351, 8, 21, true, true, true, true);
INSERT INTO role_permission VALUES (352, 8, 22, true, false, false, false);
INSERT INTO role_permission VALUES (353, 8, 23, true, true, true, true);
INSERT INTO role_permission VALUES (354, 8, 26, true, false, false, false);
INSERT INTO role_permission VALUES (355, 8, 27, true, false, false, false);
INSERT INTO role_permission VALUES (356, 8, 28, true, false, false, false);
INSERT INTO role_permission VALUES (357, 8, 29, true, true, false, true);
INSERT INTO role_permission VALUES (358, 8, 30, true, false, false, false);
INSERT INTO role_permission VALUES (359, 8, 31, true, false, false, false);
INSERT INTO role_permission VALUES (360, 8, 1, true, false, false, false);
INSERT INTO role_permission VALUES (361, 8, 2, true, true, true, true);
INSERT INTO role_permission VALUES (362, 8, 3, true, true, true, false);
INSERT INTO role_permission VALUES (363, 8, 4, true, true, true, true);
INSERT INTO role_permission VALUES (364, 8, 6, true, false, false, false);
INSERT INTO role_permission VALUES (365, 8, 7, true, false, false, false);
INSERT INTO role_permission VALUES (366, 8, 8, true, false, false, false);
INSERT INTO role_permission VALUES (367, 8, 9, true, false, false, false);
INSERT INTO role_permission VALUES (368, 8, 10, true, false, false, false);
INSERT INTO role_permission VALUES (369, 8, 11, true, true, false, true);
INSERT INTO role_permission VALUES (370, 8, 13, true, true, true, true);
INSERT INTO role_permission VALUES (371, 8, 15, true, false, false, false);
INSERT INTO role_permission VALUES (372, 8, 16, true, false, false, false);
INSERT INTO role_permission VALUES (373, 8, 33, true, false, false, false);
INSERT INTO role_permission VALUES (374, 8, 34, true, false, false, false);
INSERT INTO role_permission VALUES (375, 8, 35, true, true, true, true);
INSERT INTO role_permission VALUES (376, 8, 36, true, true, true, true);
INSERT INTO role_permission VALUES (377, 8, 37, true, true, true, true);
INSERT INTO role_permission VALUES (378, 8, 38, true, true, true, true);
INSERT INTO role_permission VALUES (379, 8, 43, true, false, false, false);
INSERT INTO role_permission VALUES (380, 8, 44, true, false, false, false);
INSERT INTO role_permission VALUES (381, 8, 45, true, true, true, true);
INSERT INTO role_permission VALUES (382, 8, 46, true, false, false, false);
INSERT INTO role_permission VALUES (383, 8, 73, true, false, false, false);
INSERT INTO role_permission VALUES (384, 8, 74, true, false, false, false);
INSERT INTO role_permission VALUES (385, 8, 72, true, false, false, false);
INSERT INTO role_permission VALUES (386, 8, 56, true, false, false, false);
INSERT INTO role_permission VALUES (387, 8, 57, true, false, false, false);
INSERT INTO role_permission VALUES (388, 8, 58, true, false, false, false);
INSERT INTO role_permission VALUES (389, 8, 59, true, false, false, false);
INSERT INTO role_permission VALUES (390, 9, 60, true, false, false, false);
INSERT INTO role_permission VALUES (391, 9, 61, true, false, false, false);
INSERT INTO role_permission VALUES (392, 9, 63, true, false, false, false);
INSERT INTO role_permission VALUES (393, 9, 64, true, true, true, true);
INSERT INTO role_permission VALUES (394, 9, 65, true, false, true, false);
INSERT INTO role_permission VALUES (395, 9, 66, true, false, false, false);
INSERT INTO role_permission VALUES (396, 9, 67, true, false, true, false);
INSERT INTO role_permission VALUES (397, 9, 68, true, false, true, false);
INSERT INTO role_permission VALUES (398, 9, 69, false, false, true, false);
INSERT INTO role_permission VALUES (399, 9, 33, true, false, false, false);
INSERT INTO role_permission VALUES (400, 9, 34, true, false, false, false);
INSERT INTO role_permission VALUES (401, 9, 35, true, true, true, true);
INSERT INTO role_permission VALUES (402, 9, 36, true, true, true, true);
INSERT INTO role_permission VALUES (403, 9, 37, true, true, true, true);
INSERT INTO role_permission VALUES (404, 9, 38, true, true, true, true);
INSERT INTO role_permission VALUES (405, 9, 73, true, true, true, true);
INSERT INTO role_permission VALUES (406, 9, 74, true, true, true, true);
INSERT INTO role_permission VALUES (407, 9, 72, true, false, false, false);
INSERT INTO role_permission VALUES (408, 9, 56, true, false, false, false);
INSERT INTO role_permission VALUES (409, 9, 57, true, false, false, false);
INSERT INTO role_permission VALUES (410, 9, 58, true, false, false, false);
INSERT INTO role_permission VALUES (411, 9, 59, true, false, false, false);


--
-- Data for TOC entry 557 (OID 554209)
-- Name: lookup_stage; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_stage VALUES (1, 1, 'Prospecting', false, 1, true);
INSERT INTO lookup_stage VALUES (2, 2, 'Qualification', false, 2, true);
INSERT INTO lookup_stage VALUES (3, 3, 'Needs Analysis', false, 3, true);
INSERT INTO lookup_stage VALUES (4, 4, 'Value Proposition', false, 4, true);
INSERT INTO lookup_stage VALUES (5, 5, 'Perception Analysis', false, 5, true);
INSERT INTO lookup_stage VALUES (6, 6, 'Proposal/Price Quote', false, 6, true);
INSERT INTO lookup_stage VALUES (7, 7, 'Negotiation/Review', false, 7, true);
INSERT INTO lookup_stage VALUES (8, 8, 'Closed Won', false, 8, true);
INSERT INTO lookup_stage VALUES (9, 9, 'Closed Lost', false, 9, true);


--
-- Data for TOC entry 558 (OID 554219)
-- Name: lookup_delivery_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_delivery_options VALUES (1, 'Email only', false, 1, true);
INSERT INTO lookup_delivery_options VALUES (2, 'Fax only', false, 2, true);
INSERT INTO lookup_delivery_options VALUES (3, 'Letter only', false, 3, true);
INSERT INTO lookup_delivery_options VALUES (4, 'Email then Fax', false, 4, true);
INSERT INTO lookup_delivery_options VALUES (5, 'Email then Letter', false, 5, true);
INSERT INTO lookup_delivery_options VALUES (6, 'Email, Fax, then Letter', false, 6, true);


--
-- Data for TOC entry 559 (OID 554229)
-- Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 560 (OID 554244)
-- Name: organization_address; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 561 (OID 554269)
-- Name: organization_emailaddress; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 562 (OID 554294)
-- Name: organization_phone; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 563 (OID 554319)
-- Name: contact_address; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 564 (OID 554344)
-- Name: contact_emailaddress; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 565 (OID 554369)
-- Name: contact_phone; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 566 (OID 554394)
-- Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 567 (OID 554406)
-- Name: cfsinbox_message; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 568 (OID 554427)
-- Name: cfsinbox_messagelink; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 569 (OID 554443)
-- Name: account_type_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 570 (OID 554455)
-- Name: contact_type_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 571 (OID 554469)
-- Name: lookup_lists_lookup; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_lists_lookup VALUES (1, 1, 1, 'lookupList', 'lookup_account_types', 10, 'Account Types', '2003-12-04 16:47:29.893', 1);
INSERT INTO lookup_lists_lookup VALUES (2, 1, 2, 'lookupList', 'lookup_revenue_types', 20, 'Revenue Types', '2003-12-04 16:47:29.978', 1);
INSERT INTO lookup_lists_lookup VALUES (3, 1, 3, 'contactType', 'lookup_contact_types', 30, 'Contact Types', '2003-12-04 16:47:29.982', 1);
INSERT INTO lookup_lists_lookup VALUES (4, 2, 1, 'contactType', 'lookup_contact_types', 10, 'Types', '2003-12-04 16:47:30.653', 2);
INSERT INTO lookup_lists_lookup VALUES (5, 2, 2, 'lookupList', 'lookup_contactemail_types', 20, 'Email Types', '2003-12-04 16:47:30.657', 2);
INSERT INTO lookup_lists_lookup VALUES (6, 2, 3, 'lookupList', 'lookup_contactaddress_types', 30, 'Address Types', '2003-12-04 16:47:30.661', 2);
INSERT INTO lookup_lists_lookup VALUES (7, 2, 4, 'lookupList', 'lookup_contactphone_types', 40, 'Phone Types', '2003-12-04 16:47:30.665', 2);
INSERT INTO lookup_lists_lookup VALUES (8, 4, 1, 'lookupList', 'lookup_stage', 10, 'Stage', '2003-12-04 16:47:30.761', 4);
INSERT INTO lookup_lists_lookup VALUES (9, 4, 2, 'lookupList', 'lookup_opportunity_types', 20, 'Opportunity Types', '2003-12-04 16:47:30.775', 4);
INSERT INTO lookup_lists_lookup VALUES (10, 8, 1, 'lookupList', 'lookup_ticketsource', 10, 'Ticket Source', '2003-12-04 16:47:30.972', 8);
INSERT INTO lookup_lists_lookup VALUES (11, 8, 2, 'lookupList', 'ticket_severity', 20, 'Ticket Severity', '2003-12-04 16:47:30.976', 8);
INSERT INTO lookup_lists_lookup VALUES (12, 8, 3, 'lookupList', 'ticket_priority', 30, 'Ticket Priority', '2003-12-04 16:47:30.979', 8);
INSERT INTO lookup_lists_lookup VALUES (13, 15, 1111031132, 'lookupList', 'lookup_department', 10, 'Departments', '2003-12-04 16:47:31.363', 15);


--
-- Data for TOC entry 572 (OID 554485)
-- Name: viewpoint; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 573 (OID 554511)
-- Name: viewpoint_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 574 (OID 554530)
-- Name: report; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO report VALUES (1, 1, NULL, 'accounts_type.xml', 1, 'Accounts by Type', 'What are my accounts by type?', '2003-12-04 16:47:29.986', 0, '2003-12-04 16:47:29.986', 0, true, false);
INSERT INTO report VALUES (2, 1, NULL, 'accounts_recent.xml', 1, 'Accounts by Date Added', 'What are my recent accounts?', '2003-12-04 16:47:30.526', 0, '2003-12-04 16:47:30.526', 0, true, false);
INSERT INTO report VALUES (3, 1, NULL, 'accounts_expire.xml', 1, 'Accounts by Contract End Date', 'Which accounts are expiring?', '2003-12-04 16:47:30.531', 0, '2003-12-04 16:47:30.531', 0, true, false);
INSERT INTO report VALUES (4, 1, NULL, 'accounts_current.xml', 1, 'Current Accounts', 'What are my current accounts?', '2003-12-04 16:47:30.536', 0, '2003-12-04 16:47:30.536', 0, true, false);
INSERT INTO report VALUES (5, 1, NULL, 'accounts_contacts.xml', 1, 'Account Contacts', 'Who are the contacts in each account?', '2003-12-04 16:47:30.541', 0, '2003-12-04 16:47:30.541', 0, true, false);
INSERT INTO report VALUES (6, 1, NULL, 'folder_accounts.xml', 1, 'Account Folders', 'What is the folder data for each account?', '2003-12-04 16:47:30.547', 0, '2003-12-04 16:47:30.547', 0, true, false);
INSERT INTO report VALUES (7, 2, NULL, 'contacts_user.xml', 1, 'Contacts', 'Who are my contacts?', '2003-12-04 16:47:30.669', 0, '2003-12-04 16:47:30.669', 0, true, false);
INSERT INTO report VALUES (8, 4, NULL, 'opportunity_pipeline.xml', 1, 'Opportunities by Stage', 'What are my upcoming opportunities by stage?', '2003-12-04 16:47:30.779', 0, '2003-12-04 16:47:30.779', 0, true, false);
INSERT INTO report VALUES (9, 4, NULL, 'opportunity_account.xml', 1, 'Opportunities by Account', 'What are all the accounts associated with my opportunities?', '2003-12-04 16:47:30.784', 0, '2003-12-04 16:47:30.784', 0, true, false);
INSERT INTO report VALUES (10, 4, NULL, 'opportunity_owner.xml', 1, 'Opportunities by Owner', 'What are all the opportunities based on ownership?', '2003-12-04 16:47:30.789', 0, '2003-12-04 16:47:30.789', 0, true, false);
INSERT INTO report VALUES (11, 4, NULL, 'opportunity_contact.xml', 1, 'Opportunity Contacts', 'Who are the contacts of my opportunities?', '2003-12-04 16:47:30.793', 0, '2003-12-04 16:47:30.793', 0, true, false);
INSERT INTO report VALUES (12, 6, NULL, 'campaign.xml', 1, 'Campaigns by date', 'What are my active campaigns?', '2003-12-04 16:47:30.888', 0, '2003-12-04 16:47:30.888', 0, true, false);
INSERT INTO report VALUES (13, 8, NULL, 'tickets_department.xml', 1, 'Tickets by Department', 'What tickets are there in each department?', '2003-12-04 16:47:30.983', 0, '2003-12-04 16:47:30.983', 0, true, false);
INSERT INTO report VALUES (14, 8, NULL, 'ticket_summary_date.xml', 1, 'Ticket counts by Department', 'How man tickets are there in the system on a particular date?', '2003-12-04 16:47:30.987', 0, '2003-12-04 16:47:30.987', 0, true, false);
INSERT INTO report VALUES (15, 8, NULL, 'ticket_summary_range.xml', 1, 'Ticket activity by Department', 'How many tickets exist within a date range?', '2003-12-04 16:47:30.991', 0, '2003-12-04 16:47:30.991', 0, true, false);
INSERT INTO report VALUES (16, 9, NULL, 'users.xml', 1, 'System Users', 'Who are all the users of the system?', '2003-12-04 16:47:31.186', 0, '2003-12-04 16:47:31.186', 0, true, false);
INSERT INTO report VALUES (17, 12, NULL, 'task_date.xml', 1, 'Task list by due date', 'What are the tasks due withing a date range?', '2003-12-04 16:47:31.304', 0, '2003-12-04 16:47:31.304', 0, true, false);
INSERT INTO report VALUES (18, 12, NULL, 'task_nodate.xml', 1, 'Task list', 'What are all the tasks in the system?', '2003-12-04 16:47:31.308', 0, '2003-12-04 16:47:31.308', 0, true, false);
INSERT INTO report VALUES (19, 15, NULL, 'employees.xml', 1, 'Employees', 'Who are the employees in my organization?', '2003-12-04 16:47:31.367', 0, '2003-12-04 16:47:31.367', 0, true, false);


--
-- Data for TOC entry 575 (OID 554561)
-- Name: report_criteria; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 576 (OID 554587)
-- Name: report_criteria_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 577 (OID 554601)
-- Name: report_queue; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 578 (OID 554620)
-- Name: report_queue_criteria; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 579 (OID 554634)
-- Name: action_list; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 580 (OID 554656)
-- Name: action_item; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 581 (OID 554678)
-- Name: action_item_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 582 (OID 554700)
-- Name: database_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO database_version VALUES (1, 'att/source/dhv/cfs2/src/sql/init/workflow.bsh', 'att/source/dhv/cfs2/src/sql/init/workflow', '2003-12-04 16:47:37.529');


--
-- Data for TOC entry 583 (OID 554825)
-- Name: lookup_call_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_call_types VALUES (1, 'Phone Call', true, 10, true);
INSERT INTO lookup_call_types VALUES (2, 'Fax', false, 20, true);
INSERT INTO lookup_call_types VALUES (3, 'In-Person', false, 30, true);


--
-- Data for TOC entry 584 (OID 554835)
-- Name: lookup_opportunity_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_opportunity_types VALUES (1, NULL, 'Type 1', false, 0, true);
INSERT INTO lookup_opportunity_types VALUES (2, NULL, 'Type 2', false, 1, true);
INSERT INTO lookup_opportunity_types VALUES (3, NULL, 'Type 3', false, 2, true);
INSERT INTO lookup_opportunity_types VALUES (4, NULL, 'Type 4', false, 3, true);


--
-- Data for TOC entry 585 (OID 554845)
-- Name: opportunity_header; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 586 (OID 554864)
-- Name: opportunity_component; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 587 (OID 554898)
-- Name: opportunity_component_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 588 (OID 554912)
-- Name: call_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 589 (OID 554965)
-- Name: ticket_level; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ticket_level VALUES (1, 'Entry level', false, 0, true);
INSERT INTO ticket_level VALUES (2, 'First level', false, 1, true);
INSERT INTO ticket_level VALUES (3, 'Second level', false, 2, true);
INSERT INTO ticket_level VALUES (4, 'Third level', false, 3, true);
INSERT INTO ticket_level VALUES (5, 'Top level', false, 4, true);


--
-- Data for TOC entry 590 (OID 554977)
-- Name: ticket_severity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ticket_severity VALUES (1, 'Normal', 'background-color:lightgreen;color:black;', false, 0, true);
INSERT INTO ticket_severity VALUES (2, 'Important', 'background-color:yellow;color:black;', false, 1, true);
INSERT INTO ticket_severity VALUES (3, 'Critical', 'background-color:red;color:black;font-weight:bold;', false, 2, true);


--
-- Data for TOC entry 591 (OID 554993)
-- Name: lookup_ticketsource; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_ticketsource VALUES (1, 'Phone', false, 1, true);
INSERT INTO lookup_ticketsource VALUES (2, 'Email', false, 2, true);
INSERT INTO lookup_ticketsource VALUES (3, 'Letter', false, 3, true);
INSERT INTO lookup_ticketsource VALUES (4, 'Other', false, 4, true);


--
-- Data for TOC entry 592 (OID 555005)
-- Name: ticket_priority; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ticket_priority VALUES (1, 'Scheduled', 'background-color:lightgreen;color:black;', false, 0, true);
INSERT INTO ticket_priority VALUES (2, 'Next', 'background-color:yellow;color:black;', false, 1, true);
INSERT INTO ticket_priority VALUES (3, 'Immediate', 'background-color:red;color:black;font-weight:bold;', false, 2, true);


--
-- Data for TOC entry 593 (OID 555021)
-- Name: ticket_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ticket_category VALUES (1, 0, 0, 'Sales', '', false, 1, true);
INSERT INTO ticket_category VALUES (2, 0, 0, 'Billing', '', false, 2, true);
INSERT INTO ticket_category VALUES (3, 0, 0, 'Technical', '', false, 3, true);
INSERT INTO ticket_category VALUES (4, 0, 0, 'Order', '', false, 4, true);
INSERT INTO ticket_category VALUES (5, 0, 0, 'Other', '', false, 5, true);


--
-- Data for TOC entry 594 (OID 555036)
-- Name: ticket_category_draft; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 595 (OID 555052)
-- Name: ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 596 (OID 555106)
-- Name: ticketlog; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 597 (OID 555166)
-- Name: module_field_categorylink; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO module_field_categorylink VALUES (1, 1, 1, 10, 'Accounts', '2003-12-04 16:47:29.507');
INSERT INTO module_field_categorylink VALUES (2, 2, 2, 10, 'Contacts', '2003-12-04 16:47:30.648');


--
-- Data for TOC entry 598 (OID 555184)
-- Name: custom_field_category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 599 (OID 555206)
-- Name: custom_field_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 600 (OID 555225)
-- Name: custom_field_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 601 (OID 555246)
-- Name: custom_field_lookup; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 602 (OID 555262)
-- Name: custom_field_record; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 603 (OID 555283)
-- Name: custom_field_data; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 604 (OID 555300)
-- Name: lookup_project_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_project_activity VALUES (1, 'Project Initialization', false, 1, true, 0, 0);
INSERT INTO lookup_project_activity VALUES (2, 'Analysis/Software Requirements', false, 2, true, 0, 0);
INSERT INTO lookup_project_activity VALUES (3, 'Functional Specifications', false, 3, true, 0, 0);
INSERT INTO lookup_project_activity VALUES (4, 'Prototype', false, 4, true, 0, 0);
INSERT INTO lookup_project_activity VALUES (5, 'System Development', false, 5, true, 0, 0);
INSERT INTO lookup_project_activity VALUES (6, 'Testing', false, 6, true, 0, 0);
INSERT INTO lookup_project_activity VALUES (7, 'Training', false, 7, true, 0, 0);
INSERT INTO lookup_project_activity VALUES (8, 'Documentation', false, 8, true, 0, 0);
INSERT INTO lookup_project_activity VALUES (9, 'Deployment', false, 9, true, 0, 0);
INSERT INTO lookup_project_activity VALUES (10, 'Post Implementation Review', false, 10, true, 0, 0);


--
-- Data for TOC entry 605 (OID 555312)
-- Name: lookup_project_priority; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_project_priority VALUES (1, 'Low', false, 1, true, 0, NULL, 10);
INSERT INTO lookup_project_priority VALUES (2, 'Normal', true, 2, true, 0, NULL, 20);
INSERT INTO lookup_project_priority VALUES (3, 'High', false, 3, true, 0, NULL, 30);


--
-- Data for TOC entry 606 (OID 555323)
-- Name: lookup_project_issues; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_project_issues VALUES (1, 'Status Update', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (2, 'Bug Report', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (3, 'Network', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (4, 'Hardware', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (5, 'Permissions', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (6, 'User', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (7, 'Documentation', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (8, 'Feature', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (9, 'Procedure', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (10, 'Training', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (11, '3rd-Party Software', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (12, 'Database', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (13, 'Information', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (14, 'Testing', false, 0, true, 0);
INSERT INTO lookup_project_issues VALUES (15, 'Security', false, 0, true, 0);


--
-- Data for TOC entry 607 (OID 555334)
-- Name: lookup_project_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_project_status VALUES (1, 'Not Started', false, 1, true, 0, 'box.gif', 1);
INSERT INTO lookup_project_status VALUES (2, 'In Progress', false, 2, true, 0, 'box.gif', 2);
INSERT INTO lookup_project_status VALUES (3, 'On Hold', false, 5, true, 0, 'box-hold.gif', 5);
INSERT INTO lookup_project_status VALUES (4, 'Waiting on Reqs', false, 6, true, 0, 'box-hold.gif', 5);
INSERT INTO lookup_project_status VALUES (5, 'Complete', false, 3, true, 0, 'box-checked.gif', 3);
INSERT INTO lookup_project_status VALUES (6, 'Closed', false, 4, true, 0, 'box-checked.gif', 4);


--
-- Data for TOC entry 608 (OID 555345)
-- Name: lookup_project_loe; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_project_loe VALUES (1, 'Minute(s)', 60, false, 1, true, 0);
INSERT INTO lookup_project_loe VALUES (2, 'Hour(s)', 3600, true, 1, true, 0);
INSERT INTO lookup_project_loe VALUES (3, 'Day(s)', 86400, false, 1, true, 0);
INSERT INTO lookup_project_loe VALUES (4, 'Week(s)', 604800, false, 1, true, 0);
INSERT INTO lookup_project_loe VALUES (5, 'Month(s)', 18144000, false, 1, true, 0);


--
-- Data for TOC entry 609 (OID 555357)
-- Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 610 (OID 555380)
-- Name: project_requirements; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 611 (OID 555420)
-- Name: project_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 612 (OID 555477)
-- Name: project_assignments_status; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 613 (OID 555496)
-- Name: project_issues; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 614 (OID 555528)
-- Name: project_issue_replies; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 615 (OID 555553)
-- Name: project_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 616 (OID 555563)
-- Name: project_files; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 617 (OID 555590)
-- Name: project_files_version; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 618 (OID 555613)
-- Name: project_files_download; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 619 (OID 555625)
-- Name: project_team; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 620 (OID 555686)
-- Name: saved_criterialist; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 621 (OID 555709)
-- Name: campaign; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 622 (OID 555739)
-- Name: campaign_run; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 623 (OID 555756)
-- Name: excluded_recipient; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 624 (OID 555769)
-- Name: campaign_list_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 625 (OID 555781)
-- Name: active_campaign_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 626 (OID 555795)
-- Name: scheduled_recipient; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 627 (OID 555814)
-- Name: lookup_survey_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_survey_types VALUES (1, 'Open-Ended', false, 0, true);
INSERT INTO lookup_survey_types VALUES (2, 'Quantitative (no comments)', false, 0, true);
INSERT INTO lookup_survey_types VALUES (3, 'Quantitative (with comments)', false, 0, true);
INSERT INTO lookup_survey_types VALUES (4, 'Item List', false, 0, true);


--
-- Data for TOC entry 628 (OID 555824)
-- Name: survey; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 629 (OID 555846)
-- Name: campaign_survey_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 630 (OID 555858)
-- Name: survey_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 631 (OID 555875)
-- Name: survey_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 632 (OID 555887)
-- Name: active_survey; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 633 (OID 555917)
-- Name: active_survey_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 634 (OID 555942)
-- Name: active_survey_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 635 (OID 555954)
-- Name: active_survey_responses; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 636 (OID 555967)
-- Name: active_survey_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 637 (OID 555986)
-- Name: active_survey_answer_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 638 (OID 556004)
-- Name: active_survey_answer_avg; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 639 (OID 556020)
-- Name: field_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO field_types VALUES (1, 0, 'string', '=', 'is', true);
INSERT INTO field_types VALUES (2, 0, 'string', '!=', 'is not', true);
INSERT INTO field_types VALUES (3, 0, 'string', '= | or field_name is null', 'is empty', false);
INSERT INTO field_types VALUES (4, 0, 'string', '!= | and field_name is not null', 'is not empty', false);
INSERT INTO field_types VALUES (5, 0, 'string', 'like %search_value%', 'contains', false);
INSERT INTO field_types VALUES (6, 0, 'string', 'not like %search_value%', 'does not contain', false);
INSERT INTO field_types VALUES (7, 1, 'date', '<', 'before', true);
INSERT INTO field_types VALUES (8, 1, 'date', '>', 'after', true);
INSERT INTO field_types VALUES (9, 1, 'date', 'between', 'between', false);
INSERT INTO field_types VALUES (10, 1, 'date', '<=', 'on or before', true);
INSERT INTO field_types VALUES (11, 1, 'date', '>=', 'on or after', true);
INSERT INTO field_types VALUES (12, 2, 'number', '>', 'greater than', true);
INSERT INTO field_types VALUES (13, 2, 'number', '<', 'less than', true);
INSERT INTO field_types VALUES (14, 2, 'number', '=', 'equals', true);
INSERT INTO field_types VALUES (15, 2, 'number', '>=', 'greater than or equal to', true);
INSERT INTO field_types VALUES (16, 2, 'number', '<=', 'less than or equal to', true);
INSERT INTO field_types VALUES (17, 2, 'number', 'is not null', 'exist', true);
INSERT INTO field_types VALUES (18, 2, 'number', 'is null', 'does not exist', true);


--
-- Data for TOC entry 640 (OID 556029)
-- Name: search_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO search_fields VALUES (1, 'company', 'Company Name', true, 0, NULL, NULL, true);
INSERT INTO search_fields VALUES (2, 'namefirst', 'Contact First Name', true, 0, NULL, NULL, true);
INSERT INTO search_fields VALUES (3, 'namelast', 'Contact Last Name', true, 0, NULL, NULL, true);
INSERT INTO search_fields VALUES (4, 'entered', 'Entered Date', true, 1, NULL, NULL, true);
INSERT INTO search_fields VALUES (5, 'zip', 'Zip Code', true, 0, NULL, NULL, true);
INSERT INTO search_fields VALUES (6, 'areacode', 'Area Code', true, 0, NULL, NULL, true);
INSERT INTO search_fields VALUES (7, 'city', 'City', true, 0, NULL, NULL, true);
INSERT INTO search_fields VALUES (8, 'typeId', 'Contact Type', true, 0, NULL, NULL, true);
INSERT INTO search_fields VALUES (9, 'contactId', 'Contact ID', false, 0, NULL, NULL, true);
INSERT INTO search_fields VALUES (10, 'title', 'Contact Title', false, 0, NULL, NULL, true);
INSERT INTO search_fields VALUES (11, 'accountTypeId', 'Account Type', true, 0, NULL, NULL, true);


--
-- Data for TOC entry 641 (OID 556039)
-- Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 642 (OID 556064)
-- Name: message_template; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 643 (OID 556080)
-- Name: saved_criteriaelement; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 644 (OID 556138)
-- Name: help_module; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 645 (OID 556152)
-- Name: help_contents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 646 (OID 556193)
-- Name: help_tableof_contents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 647 (OID 556227)
-- Name: help_tableofcontentitem_links; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 648 (OID 556253)
-- Name: lookup_help_features; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 649 (OID 556266)
-- Name: help_features; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 650 (OID 556300)
-- Name: help_related_links; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 651 (OID 556326)
-- Name: help_faqs; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 652 (OID 556355)
-- Name: help_business_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 653 (OID 556384)
-- Name: help_notes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 654 (OID 556413)
-- Name: help_tips; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 655 (OID 556438)
-- Name: sync_client; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 656 (OID 556447)
-- Name: sync_system; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sync_system VALUES (1, 'Vport Telemarketing', true);
INSERT INTO sync_system VALUES (2, 'Land Mark: Auto Guide PocketPC', true);
INSERT INTO sync_system VALUES (3, 'Street Smart Speakers: Web Portal', true);
INSERT INTO sync_system VALUES (4, 'CFSHttpXMLWriter', true);
INSERT INTO sync_system VALUES (5, 'Fluency', true);


--
-- Data for TOC entry 657 (OID 556455)
-- Name: sync_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sync_table VALUES (1, 1, 'ticket', 'org.aspcfs.modules.troubletickets.base.Ticket', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, 'id');
INSERT INTO sync_table VALUES (2, 2, 'syncClient', 'org.aspcfs.modules.service.base.SyncClient', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 2, false, NULL);
INSERT INTO sync_table VALUES (3, 2, 'user', 'org.aspcfs.modules.admin.base.User', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 4, false, NULL);
INSERT INTO sync_table VALUES (4, 2, 'account', 'org.aspcfs.modules.accounts.base.Organization', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 5, false, NULL);
INSERT INTO sync_table VALUES (5, 2, 'accountInventory', 'org.aspcfs.modules.media.autoguide.base.Inventory', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 6, false, NULL);
INSERT INTO sync_table VALUES (6, 2, 'inventoryOption', 'org.aspcfs.modules.media.autoguide.base.InventoryOption', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 8, false, NULL);
INSERT INTO sync_table VALUES (7, 2, 'adRun', 'org.aspcfs.modules.media.autoguide.base.AdRun', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 10, false, NULL);
INSERT INTO sync_table VALUES (8, 2, 'tableList', 'org.aspcfs.modules.service.base.SyncTableList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 12, false, NULL);
INSERT INTO sync_table VALUES (9, 2, 'status_master', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 14, false, NULL);
INSERT INTO sync_table VALUES (10, 2, 'system', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 16, false, NULL);
INSERT INTO sync_table VALUES (11, 2, 'userList', 'org.aspcfs.modules.admin.base.UserList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE users ( user_id              int NOT NULL, record_status_id     int NULL, user_name            nvarchar(20) NULL, pin                  nvarchar(20) NULL, modified             datetime NULL, PRIMARY KEY (user_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )', 50, true, NULL);
INSERT INTO sync_table VALUES (12, 2, 'XIF18users', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF18users ON users ( record_status_id )', 60, false, NULL);
INSERT INTO sync_table VALUES (13, 2, 'makeList', 'org.aspcfs.modules.media.autoguide.base.MakeList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE make ( make_id              int NOT NULL, make_name            nvarchar(20) NULL, record_status_id     int NULL, entered              datetime NULL, modified             datetime NULL, enteredby            int NULL, modifiedby           int NULL, PRIMARY KEY (make_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )', 70, true, NULL);
INSERT INTO sync_table VALUES (14, 2, 'XIF2make', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF2make ON make ( record_status_id )', 80, false, NULL);
INSERT INTO sync_table VALUES (15, 2, 'modelList', 'org.aspcfs.modules.media.autoguide.base.ModelList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE model ( model_id             int NOT NULL, make_id              int NULL, record_status_id     int NULL, model_name           nvarchar(40) NULL, entered              datetime NULL, modified             datetime NULL, enteredby            int NULL, modifiedby           int NULL, PRIMARY KEY (model_id), FOREIGN KEY (make_id) REFERENCES make (make_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )', 100, true, NULL);
INSERT INTO sync_table VALUES (16, 2, 'XIF3model', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF3model ON model ( record_status_id )', 110, false, NULL);
INSERT INTO sync_table VALUES (17, 2, 'XIF5model', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF5model ON model ( make_id )', 120, false, NULL);
INSERT INTO sync_table VALUES (18, 2, 'vehicleList', 'org.aspcfs.modules.media.autoguide.base.VehicleList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE vehicle ( year                 nvarchar(4) NOT NULL, vehicle_id           int NOT NULL, model_id             int NULL, make_id              int NULL, record_status_id     int NULL, entered              datetime NULL, modified             datetime NULL, enteredby            int NULL, modifiedby           int NULL, PRIMARY KEY (vehicle_id), FOREIGN KEY (model_id) REFERENCES model (model_id), FOREIGN KEY (make_id) REFERENCES make (make_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )', 130, true, NULL);
INSERT INTO sync_table VALUES (19, 2, 'XIF30vehicle', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF30vehicle ON vehicle ( make_id )', 140, false, NULL);
INSERT INTO sync_table VALUES (20, 2, 'XIF31vehicle', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF31vehicle ON vehicle ( model_id )', 150, false, NULL);
INSERT INTO sync_table VALUES (21, 2, 'XIF4vehicle', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF4vehicle ON vehicle ( record_status_id )', 160, false, NULL);
INSERT INTO sync_table VALUES (22, 2, 'accountList', 'org.aspcfs.modules.accounts.base.OrganizationList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE account ( account_id           int NOT NULL, account_name         nvarchar(80) NULL, record_status_id     int NULL, address              nvarchar(80) NULL, modified             datetime NULL, city                 nvarchar(80) NULL, state                nvarchar(2) NULL, notes                nvarchar(255) NULL, zip                  nvarchar(11) NULL, phone                nvarchar(20) NULL, contact              nvarchar(20) NULL, dmv_number           nvarchar(20) NULL, owner_id             int NULL, entered              datetime NULL, enteredby            int NULL, modifiedby           int NULL, PRIMARY KEY (account_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )', 170, true, NULL);
INSERT INTO sync_table VALUES (23, 2, 'XIF16account', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF16account ON account ( record_status_id )', 180, false, NULL);
INSERT INTO sync_table VALUES (24, 2, 'accountInventoryList', 'org.aspcfs.modules.media.autoguide.base.InventoryList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE account_inventory ( inventory_id         int NOT NULL, vin                  nvarchar(20) NULL, vehicle_id           int NULL, account_id           int NULL, mileage              nvarchar(20) NULL, enteredby            int NULL, new                  bit, condition            nvarchar(20) NULL, comments             nvarchar(255) NULL, stock_no             nvarchar(20) NULL, ext_color            nvarchar(20) NULL, int_color            nvarchar(20) NULL, style                nvarchar(40) NULL, invoice_price        money NULL, selling_price        money NULL, selling_price_text		nvarchar(100) NULL, modified             datetime NULL, sold                 int NULL, modifiedby           int NULL, record_status_id     int NULL, entered              datetime NULL, PRIMARY KEY (inventory_id), FOREIGN KEY (account_id) REFERENCES account (account_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )', 190, true, NULL);
INSERT INTO sync_table VALUES (25, 2, 'XIF10account_inventory', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF10account_inventory ON account_inventory ( record_status_id )', 200, false, NULL);
INSERT INTO sync_table VALUES (26, 2, 'XIF10account_inventory', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF11account_inventory ON account_inventory ( modifiedby )', 210, false, NULL);
INSERT INTO sync_table VALUES (27, 2, 'XIF19account_inventory', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF19account_inventory ON account_inventory ( account_id )', 220, false, NULL);
INSERT INTO sync_table VALUES (28, 2, 'XIF35account_inventory', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF35account_inventory ON account_inventory ( vehicle_id )', 230, false, NULL);
INSERT INTO sync_table VALUES (29, 2, 'optionList', 'org.aspcfs.modules.media.autoguide.base.OptionList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE options ( option_id            int NOT NULL, option_name          nvarchar(20) NULL, record_status_id     int NULL, record_status_date   datetime NULL, PRIMARY KEY (option_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )', 330, true, NULL);
INSERT INTO sync_table VALUES (30, 2, 'XIF24options', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF24options ON options ( record_status_id )', 340, false, NULL);
INSERT INTO sync_table VALUES (31, 2, 'inventoryOptionList', 'org.aspcfs.modules.media.autoguide.base.InventoryOptionList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE inventory_options ( inventory_id         int NOT NULL, option_id            int NOT NULL, record_status_id     int NULL, modified             datetime NULL, PRIMARY KEY (option_id, inventory_id), FOREIGN KEY (inventory_id) REFERENCES account_inventory (inventory_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id), FOREIGN KEY (option_id) REFERENCES options (option_id) )', 350, true, NULL);
INSERT INTO sync_table VALUES (32, 2, 'XIF25inventory_options', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF25inventory_options ON inventory_options ( option_id )', 360, false, NULL);
INSERT INTO sync_table VALUES (33, 2, 'XIF27inventory_options', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF27inventory_options ON inventory_options ( record_status_id )', 370, false, NULL);
INSERT INTO sync_table VALUES (34, 2, 'XIF33inventory_options', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF33inventory_options ON inventory_options ( inventory_id )', 380, false, NULL);
INSERT INTO sync_table VALUES (35, 2, 'adTypeList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE ad_type ( ad_type_id           int NOT NULL, ad_type_name         nvarchar(20) NULL, PRIMARY KEY (ad_type_id) )', 385, true, NULL);
INSERT INTO sync_table VALUES (36, 2, 'adRunList', 'org.aspcfs.modules.media.autoguide.base.AdRunList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE ad_run ( ad_run_id            int NOT NULL, record_status_id     int NULL, inventory_id         int NULL, ad_type_id           int NULL, ad_run_date          datetime NULL, has_picture          int NULL, modified             datetime NULL, entered              datetime NULL, modifiedby           int NULL, enteredby            int NULL, PRIMARY KEY (ad_run_id), FOREIGN KEY (inventory_id) REFERENCES account_inventory (inventory_id), FOREIGN KEY (ad_type_id) REFERENCES ad_type (ad_type_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )', 390, true, NULL);
INSERT INTO sync_table VALUES (37, 2, 'XIF22ad_run', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF22ad_run ON ad_run ( record_status_id )', 400, false, NULL);
INSERT INTO sync_table VALUES (38, 2, 'XIF36ad_run', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF36ad_run ON ad_run ( ad_type_id )', 402, false, NULL);
INSERT INTO sync_table VALUES (39, 2, 'XIF37ad_run', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF37ad_run ON ad_run ( inventory_id )', 404, false, NULL);
INSERT INTO sync_table VALUES (40, 2, 'inventory_picture', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE inventory_picture ( picture_name         nvarchar(20) NOT NULL, inventory_id         int NOT NULL, record_status_id     int NULL, entered              datetime NULL, modified             datetime NULL, modifiedby           int NULL, enteredby            int NULL, PRIMARY KEY (picture_name, inventory_id), FOREIGN KEY (inventory_id) REFERENCES account_inventory (inventory_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )', 410, false, NULL);
INSERT INTO sync_table VALUES (41, 2, 'XIF23inventory_picture', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF23inventory_picture ON inventory_picture ( record_status_id )', 420, false, NULL);
INSERT INTO sync_table VALUES (42, 2, 'XIF32inventory_picture', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF32inventory_picture ON inventory_picture ( inventory_id )', 430, false, NULL);
INSERT INTO sync_table VALUES (43, 2, 'preferences', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE preferences ( user_id              int NOT NULL, record_status_id     int NULL, modified             datetime NULL, PRIMARY KEY (user_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id), FOREIGN KEY (user_id) REFERENCES users (user_id) )', 440, false, NULL);
INSERT INTO sync_table VALUES (44, 2, 'XIF29preferences', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF29preferences ON preferences ( record_status_id )', 450, false, NULL);
INSERT INTO sync_table VALUES (45, 2, 'user_account', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE TABLE user_account ( user_id              int NOT NULL, account_id           int NOT NULL, record_status_id     int NULL, modified             datetime NULL, PRIMARY KEY (user_id, account_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id), FOREIGN KEY (account_id) REFERENCES account (account_id), FOREIGN KEY (user_id) REFERENCES users (user_id) )', 460, false, NULL);
INSERT INTO sync_table VALUES (46, 2, 'XIF14user_account', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF14user_account ON user_account ( user_id )', 470, false, NULL);
INSERT INTO sync_table VALUES (47, 2, 'XIF15user_account', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF15user_account ON user_account ( account_id )', 480, false, NULL);
INSERT INTO sync_table VALUES (48, 2, 'XIF17user_account', NULL, '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', 'CREATE INDEX XIF17user_account ON user_account ( record_status_id )', 490, false, NULL);
INSERT INTO sync_table VALUES (49, 2, 'deleteInventoryCache', 'org.aspcfs.modules.media.autoguide.actions.DeleteInventoryCache', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 500, false, NULL);
INSERT INTO sync_table VALUES (50, 4, 'lookupIndustry', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (51, 4, 'lookupIndustryList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (52, 4, 'systemPrefs', 'org.aspcfs.utils.web.CustomLookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (53, 4, 'systemModules', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (54, 4, 'systemModulesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (55, 4, 'lookupContactTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (56, 4, 'lookupContactTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (57, 4, 'lookupAccountTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (58, 4, 'lookupAccountTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (59, 4, 'lookupDepartment', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (60, 4, 'lookupDepartmentList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (61, 4, 'lookupOrgAddressTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (62, 4, 'lookupOrgAddressTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (63, 4, 'lookupOrgEmailTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (64, 4, 'lookupOrgEmailTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (65, 4, 'lookupOrgPhoneTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (66, 4, 'lookupOrgPhoneTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (67, 4, 'lookupInstantMessengerTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (68, 4, 'lookupInstantMessengerTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (69, 4, 'lookupEmploymentTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (70, 4, 'lookupEmploymentTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (71, 4, 'lookupLocale', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (72, 4, 'lookupLocaleList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (73, 4, 'lookupContactAddressTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (74, 4, 'lookupContactAddressTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (75, 4, 'lookupContactEmailTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (76, 4, 'lookupContactEmailTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (77, 4, 'lookupContactPhoneTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (78, 4, 'lookupContactPhoneTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (79, 4, 'lookupStage', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (80, 4, 'lookupStageList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (81, 4, 'lookupDeliveryOptions', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (82, 4, 'lookupDeliveryOptionsList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (83, 4, 'lookupCallTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (84, 4, 'lookupCallTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (85, 4, 'ticketCategory', 'org.aspcfs.modules.troubletickets.base.TicketCategory', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (86, 4, 'ticketCategoryList', 'org.aspcfs.modules.troubletickets.base.TicketCategoryList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (87, 4, 'ticketSeverity', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (88, 4, 'ticketSeverityList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (89, 4, 'lookupTicketSource', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (90, 4, 'lookupTicketSourceList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (91, 4, 'ticketPriority', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (92, 4, 'ticketPriorityList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (93, 4, 'lookupRevenueTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (94, 4, 'lookupRevenueTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (95, 4, 'lookupRevenueDetailTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (96, 4, 'lookupRevenueDetailTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (97, 4, 'lookupSurveyTypes', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (98, 4, 'lookupSurveyTypesList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (99, 4, 'syncClient', 'org.aspcfs.modules.service.base.SyncClient', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (100, 4, 'user', 'org.aspcfs.modules.admin.base.User', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (101, 4, 'userList', 'org.aspcfs.modules.admin.base.UserList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (102, 4, 'contact', 'org.aspcfs.modules.contacts.base.Contact', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (103, 4, 'contactList', 'org.aspcfs.modules.contacts.base.ContactList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (104, 4, 'ticket', 'org.aspcfs.modules.troubletickets.base.Ticket', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, 'id');
INSERT INTO sync_table VALUES (105, 4, 'ticketList', 'org.aspcfs.modules.troubletickets.base.TicketList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (106, 4, 'account', 'org.aspcfs.modules.accounts.base.Organization', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (107, 4, 'accountList', 'org.aspcfs.modules.accounts.base.OrganizationList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (108, 4, 'role', 'org.aspcfs.modules.admin.base.Role', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (109, 4, 'roleList', 'org.aspcfs.modules.admin.base.RoleList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (110, 4, 'permissionCategory', 'org.aspcfs.modules.admin.base.PermissionCategory', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (111, 4, 'permissionCategoryList', 'org.aspcfs.modules.admin.base.PermissionCategoryList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (112, 4, 'permission', 'org.aspcfs.modules.admin.base.Permission', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (113, 4, 'permissionList', 'org.aspcfs.modules.admin.base.PermissionList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (114, 4, 'rolePermission', 'org.aspcfs.modules.admin.base.RolePermission', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (115, 4, 'rolePermissionList', 'org.aspcfs.modules.admin.base.RolePermissionList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (116, 4, 'opportunity', 'org.aspcfs.modules.pipeline.base.Opportunity', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (117, 4, 'opportunityList', 'org.aspcfs.modules.pipeline.base.OpportunityList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (118, 4, 'call', 'org.aspcfs.modules.contacts.base.Call', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (119, 4, 'callList', 'org.aspcfs.modules.contacts.base.CallList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (120, 4, 'customFieldCategory', 'org.aspcfs.modules.base.CustomFieldCategory', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (121, 4, 'customFieldCategoryList', 'org.aspcfs.modules.base.CustomFieldCategoryList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (122, 4, 'customFieldGroup', 'org.aspcfs.modules.base.CustomFieldGroup', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (123, 4, 'customFieldGroupList', 'org.aspcfs.modules.base.CustomFieldGroupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (124, 4, 'customField', 'org.aspcfs.modules.base.CustomField', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (125, 4, 'customFieldList', 'org.aspcfs.modules.base.CustomFieldList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (126, 4, 'customFieldLookup', 'org.aspcfs.utils.web.LookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (127, 4, 'customFieldLookupList', 'org.aspcfs.utils.web.LookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (128, 4, 'customFieldRecord', 'org.aspcfs.modules.base.CustomFieldRecord', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (129, 4, 'customFieldRecordList', 'org.aspcfs.modules.base.CustomFieldRecordList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (130, 4, 'contactEmailAddress', 'org.aspcfs.modules.contacts.base.ContactEmailAddress', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (131, 4, 'contactEmailAddressList', 'org.aspcfs.modules.contacts.base.ContactEmailAddressList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (132, 4, 'customFieldData', 'org.aspcfs.modules.base.CustomFieldData', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (133, 4, 'lookupProjectActivity', 'org.aspcfs.utils.web.CustomLookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (134, 4, 'lookupProjectActivityList', 'org.aspcfs.utils.web.CustomLookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (135, 4, 'lookupProjectIssues', 'org.aspcfs.utils.web.CustomLookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (136, 4, 'lookupProjectIssuesList', 'org.aspcfs.utils.web.CustomLookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (137, 4, 'lookupProjectLoe', 'org.aspcfs.utils.web.CustomLookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (138, 4, 'lookupProjectLoeList', 'org.aspcfs.utils.web.CustomLookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (139, 4, 'lookupProjectPriority', 'org.aspcfs.utils.web.CustomLookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (140, 4, 'lookupProjectPriorityList', 'org.aspcfs.utils.web.CustomLookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (141, 4, 'lookupProjectStatus', 'org.aspcfs.utils.web.CustomLookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (142, 4, 'lookupProjectStatusList', 'org.aspcfs.utils.web.CustomLookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (143, 4, 'project', 'com.zeroio.iteam.base.Project', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (144, 4, 'projectList', 'com.zeroio.iteam.base.ProjectList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (145, 4, 'requirement', 'com.zeroio.iteam.base.Requirement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (146, 4, 'requirementList', 'com.zeroio.iteam.base.RequirementList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (147, 4, 'assignment', 'com.zeroio.iteam.base.Assignment', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (148, 4, 'assignmentList', 'com.zeroio.iteam.base.AssignmentList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (149, 4, 'issue', 'com.zeroio.iteam.base.Issue', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (150, 4, 'issueList', 'com.zeroio.iteam.base.IssueList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (151, 4, 'issueReply', 'com.zeroio.iteam.base.IssueReply', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (152, 4, 'issueReplyList', 'com.zeroio.iteam.base.IssueReplyList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (153, 4, 'teamMember', 'com.zeroio.iteam.base.TeamMember', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (154, 4, 'fileItem', 'com.zeroio.iteam.base.FileItem', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (155, 4, 'fileItemList', 'com.zeroio.iteam.base.FileItemList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (156, 4, 'fileItemVersion', 'com.zeroio.iteam.base.FileItemVersion', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (157, 4, 'fileItemVersionList', 'com.zeroio.iteam.base.FileItemVersionList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (158, 4, 'fileDownloadLog', 'com.zeroio.iteam.base.FileDownloadLog', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (159, 4, 'contactAddress', 'org.aspcfs.modules.contacts.base.ContactAddress', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (160, 4, 'contactAddressList', 'org.aspcfs.modules.contacts.base.ContactAddressList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (161, 4, 'contactPhoneNumber', 'org.aspcfs.modules.contacts.base.ContactPhoneNumber', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (162, 4, 'contactPhoneNumberList', 'org.aspcfs.modules.contacts.base.ContactPhoneNumberList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (163, 4, 'organizationPhoneNumber', 'org.aspcfs.modules.accounts.base.OrganizationPhoneNumber', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (164, 4, 'organizationPhoneNumberList', 'org.aspcfs.modules.accounts.base.OrganizationPhoneNumberList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (165, 4, 'organizationEmailAddress', 'org.aspcfs.modules.accounts.base.OrganizationEmailAddress', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (166, 4, 'organizationEmailAddressList', 'org.aspcfs.modules.accounts.base.OrganizationEmailAddressList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (167, 4, 'organizationAddress', 'org.aspcfs.modules.accounts.base.OrganizationAddress', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (168, 4, 'organizationAddressList', 'org.aspcfs.modules.accounts.base.OrganizationAddressList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (169, 4, 'ticketLog', 'org.aspcfs.modules.troubletickets.base.TicketLog', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (170, 4, 'ticketLogList', 'org.aspcfs.modules.troubletickets.base.TicketLogList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (171, 4, 'message', 'org.aspcfs.modules.communications.base.Message', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (172, 4, 'messageList', 'org.aspcfs.modules.communications.base.MessageList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (173, 4, 'searchCriteriaElements', 'org.aspcfs.modules.communications.base.SearchCriteriaList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (174, 4, 'searchCriteriaElementsList', 'org.aspcfs.modules.communications.base.SearchCriteriaListList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (175, 4, 'savedCriteriaElement', 'org.aspcfs.modules.communications.base.SavedCriteriaElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (176, 4, 'searchFieldElement', 'org.aspcfs.utils.web.CustomLookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (177, 4, 'searchFieldElementList', 'org.aspcfs.utils.web.CustomLookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (178, 4, 'revenue', 'org.aspcfs.modules.accounts.base.Revenue', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (179, 4, 'revenueList', 'org.aspcfs.modules.accounts.base.RevenueList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (180, 4, 'campaign', 'org.aspcfs.modules.communications.base.Campaign', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (181, 4, 'campaignList', 'org.aspcfs.modules.communications.base.CampaignList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (182, 4, 'scheduledRecipient', 'org.aspcfs.modules.communications.base.ScheduledRecipient', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (183, 4, 'scheduledRecipientList', 'org.aspcfs.modules.communications.base.ScheduledRecipientList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (184, 4, 'accessLog', 'org.aspcfs.modules.admin.base.AccessLog', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (185, 4, 'accessLogList', 'org.aspcfs.modules.admin.base.AccessLogList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (186, 4, 'accountTypeLevels', 'org.aspcfs.modules.accounts.base.AccountTypeLevel', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (187, 4, 'fieldTypes', 'org.aspcfs.utils.web.CustomLookupElement', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (188, 4, 'fieldTypesList', 'org.aspcfs.utils.web.CustomLookupList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (189, 4, 'excludedRecipient', 'org.aspcfs.modules.communications.base.ExcludedRecipient', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (190, 4, 'campaignRun', 'org.aspcfs.modules.communications.base.CampaignRun', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (191, 4, 'campaignRunList', 'org.aspcfs.modules.communications.base.CampaignRunList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (192, 4, 'campaignListGroups', 'org.aspcfs.modules.communications.base.CampaignListGroup', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (193, 5, 'ticket', 'org.aspcfs.modules.troubletickets.base.Ticket', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, 'id');
INSERT INTO sync_table VALUES (194, 5, 'ticketCategory', 'org.aspcfs.modules.troubletickets.base.TicketCategory', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (195, 5, 'ticketCategoryList', 'org.aspcfs.modules.troubletickets.base.TicketCategoryList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (196, 5, 'syncClient', 'org.aspcfs.modules.service.base.SyncClient', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, 2, false, NULL);
INSERT INTO sync_table VALUES (197, 5, 'accountList', 'org.aspcfs.modules.accounts.base.OrganizationList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (198, 5, 'userList', 'org.aspcfs.modules.admin.base.UserList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);
INSERT INTO sync_table VALUES (199, 5, 'contactList', 'org.aspcfs.modules.contacts.base.ContactList', '2003-12-04 16:47:15.316', '2003-12-04 16:47:15.316', NULL, -1, false, NULL);


--
-- Data for TOC entry 658 (OID 556471)
-- Name: sync_map; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 659 (OID 556483)
-- Name: sync_conflict_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 660 (OID 556496)
-- Name: sync_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 661 (OID 556512)
-- Name: sync_transaction_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 662 (OID 556526)
-- Name: process_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 663 (OID 556749)
-- Name: autoguide_make; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 664 (OID 556758)
-- Name: autoguide_model; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 665 (OID 556771)
-- Name: autoguide_vehicle; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 666 (OID 556788)
-- Name: autoguide_inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 667 (OID 556807)
-- Name: autoguide_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO autoguide_options VALUES (1, 'A/T', false, 10, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (2, '4-CYL', false, 20, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (3, '6-CYL', false, 30, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (4, 'V-8', false, 40, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (5, 'CRUISE', false, 50, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (6, '5-SPD', false, 60, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (7, '4X4', false, 70, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (8, '2-DOOR', false, 80, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (9, '4-DOOR', false, 90, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (10, 'LEATHER', false, 100, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (11, 'P/DL', false, 110, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (12, 'T/W', false, 120, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (13, 'P/SEATS', false, 130, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (14, 'P/WIND', false, 140, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (15, 'P/S', false, 150, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (16, 'BEDLINE', false, 160, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (17, 'LOW MILES', false, 170, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (18, 'EX CLEAN', false, 180, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (19, 'LOADED', false, 190, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (20, 'A/C', false, 200, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (21, 'SUNROOF', false, 210, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (22, 'AM/FM ST', false, 220, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (23, 'CASS', false, 225, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (24, 'CD PLYR', false, 230, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (25, 'ABS', false, 240, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (26, 'ALARM', false, 250, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (27, 'SLD R. WIN', false, 260, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (28, 'AIRBAG', false, 270, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (29, '1 OWNER', false, 280, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_options VALUES (30, 'ALLOY WH', false, 290, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');


--
-- Data for TOC entry 668 (OID 556817)
-- Name: autoguide_inventory_options; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 669 (OID 556826)
-- Name: autoguide_ad_run; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 670 (OID 556841)
-- Name: autoguide_ad_run_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO autoguide_ad_run_types VALUES (1, 'In Column', false, 1, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_ad_run_types VALUES (2, 'Display', false, 2, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');
INSERT INTO autoguide_ad_run_types VALUES (3, 'Both', false, 3, true, '2003-12-04 16:47:17.635', '2003-12-04 16:47:17.635');


--
-- Data for TOC entry 671 (OID 556886)
-- Name: lookup_revenue_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_revenue_types VALUES (1, 'Technical', false, 0, true);


--
-- Data for TOC entry 672 (OID 556896)
-- Name: lookup_revenuedetail_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 673 (OID 556906)
-- Name: revenue; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 674 (OID 556939)
-- Name: revenue_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 675 (OID 556970)
-- Name: lookup_task_priority; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_task_priority VALUES (1, '1', true, 1, true);
INSERT INTO lookup_task_priority VALUES (2, '2', false, 2, true);
INSERT INTO lookup_task_priority VALUES (3, '3', false, 3, true);
INSERT INTO lookup_task_priority VALUES (4, '4', false, 4, true);
INSERT INTO lookup_task_priority VALUES (5, '5', false, 5, true);


--
-- Data for TOC entry 676 (OID 556980)
-- Name: lookup_task_loe; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lookup_task_loe VALUES (1, 'Minute(s)', false, 1, true);
INSERT INTO lookup_task_loe VALUES (2, 'Hour(s)', true, 1, true);
INSERT INTO lookup_task_loe VALUES (3, 'Day(s)', false, 1, true);
INSERT INTO lookup_task_loe VALUES (4, 'Week(s)', false, 1, true);
INSERT INTO lookup_task_loe VALUES (5, 'Month(s)', false, 1, true);


--
-- Data for TOC entry 677 (OID 556990)
-- Name: lookup_task_category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 678 (OID 557000)
-- Name: task; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 679 (OID 557037)
-- Name: tasklink_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 680 (OID 557047)
-- Name: tasklink_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 681 (OID 557057)
-- Name: tasklink_project; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 682 (OID 557067)
-- Name: taskcategory_project; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 683 (OID 557089)
-- Name: business_process_component_library; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO business_process_component_library VALUES (1, 'org.aspcfs.modules.troubletickets.components.LoadTicketDetails', 1, 'org.aspcfs.modules.troubletickets.components.LoadTicketDetails', 'Load all ticket information for use in other steps', true);
INSERT INTO business_process_component_library VALUES (2, 'org.aspcfs.modules.troubletickets.components.QueryTicketJustClosed', 1, 'org.aspcfs.modules.troubletickets.components.QueryTicketJustClosed', 'Was the ticket just closed?', true);
INSERT INTO business_process_component_library VALUES (3, 'org.aspcfs.modules.components.SendUserNotification', 1, 'org.aspcfs.modules.components.SendUserNotification', 'Send an email notification to a user', true);
INSERT INTO business_process_component_library VALUES (4, 'org.aspcfs.modules.troubletickets.components.SendTicketSurvey', 1, 'org.aspcfs.modules.troubletickets.components.SendTicketSurvey', 'org.aspcfs.modules.troubletickets.components.SendTicketSurvey', true);
INSERT INTO business_process_component_library VALUES (5, 'org.aspcfs.modules.troubletickets.components.QueryTicketJustAssigned', 1, 'org.aspcfs.modules.troubletickets.components.QueryTicketJustAssigned', 'Was the ticket just assigned or re-assigned?', true);
INSERT INTO business_process_component_library VALUES (6, 'org.aspcfs.modules.troubletickets.components.GenerateTicketList', 2, 'org.aspcfs.modules.troubletickets.components.GenerateTicketList', 'Generate a list of tickets based on specified parameters.  Are there any tickets matching the parameters?', true);
INSERT INTO business_process_component_library VALUES (7, 'org.aspcfs.modules.troubletickets.components.SendTicketListReport', 2, 'org.aspcfs.modules.troubletickets.components.SendTicketListReport', 'Sends a ticket report to specified users with the specified parameters', true);


--
-- Data for TOC entry 684 (OID 557100)
-- Name: business_process_component_result_lookup; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO business_process_component_result_lookup VALUES (1, 2, 1, 'Yes', 0, true);
INSERT INTO business_process_component_result_lookup VALUES (2, 2, 0, 'No', 1, true);
INSERT INTO business_process_component_result_lookup VALUES (3, 5, 1, 'Yes', 0, true);


--
-- Data for TOC entry 685 (OID 557113)
-- Name: business_process_parameter_library; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO business_process_parameter_library VALUES (1, 3, 'notification.module', NULL, 'Tickets', true);
INSERT INTO business_process_parameter_library VALUES (2, 3, 'notification.itemId', NULL, '${this.id}', true);
INSERT INTO business_process_parameter_library VALUES (3, 3, 'notification.itemModified', NULL, '${this.modified}', true);
INSERT INTO business_process_parameter_library VALUES (4, 3, 'notification.userToNotify', NULL, '${previous.enteredBy}', true);
INSERT INTO business_process_parameter_library VALUES (5, 3, 'notification.subject', NULL, 'Dark Horse CRM Ticket Closed: ${this.paddedId}', true);
INSERT INTO business_process_parameter_library VALUES (6, 3, 'notification.body', NULL, 'The following ticket in Dark Horse CRM has been closed:

--- Ticket Details ---

Ticket # ${this.paddedId}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Comment: ${this.comment}

Closed by: ${ticketModifiedByContact.nameFirstLast}

Solution: ${this.solution}
', true);
INSERT INTO business_process_parameter_library VALUES (7, 6, 'notification.module', NULL, 'Tickets', true);
INSERT INTO business_process_parameter_library VALUES (8, 6, 'notification.itemId', NULL, '${this.id}', true);
INSERT INTO business_process_parameter_library VALUES (9, 6, 'notification.itemModified', NULL, '${this.modified}', true);
INSERT INTO business_process_parameter_library VALUES (10, 6, 'notification.userToNotify', NULL, '${this.assignedTo}', true);
INSERT INTO business_process_parameter_library VALUES (11, 6, 'notification.subject', NULL, 'Dark Horse CRM Ticket Assigned: ${this.paddedId}', true);
INSERT INTO business_process_parameter_library VALUES (12, 6, 'notification.body', NULL, 'The following ticket in Dark Horse CRM has been assigned to you:

--- Ticket Details ---

Ticket # ${this.paddedId}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Assigned By: ${ticketModifiedByContact.nameFirstLast}
Comment: ${this.comment}
', true);
INSERT INTO business_process_parameter_library VALUES (13, 7, 'ticketList.onlyOpen', NULL, 'true', true);
INSERT INTO business_process_parameter_library VALUES (14, 7, 'ticketList.onlyAssigned', NULL, 'true', true);
INSERT INTO business_process_parameter_library VALUES (15, 7, 'ticketList.onlyUnassigned', NULL, 'true', true);
INSERT INTO business_process_parameter_library VALUES (16, 7, 'ticketList.minutesOlderThan', NULL, '10', true);
INSERT INTO business_process_parameter_library VALUES (17, 7, 'ticketList.lastAnchor', NULL, '${process.lastAnchor}', true);
INSERT INTO business_process_parameter_library VALUES (18, 7, 'ticketList.nextAnchor', NULL, '${process.nextAnchor}', true);
INSERT INTO business_process_parameter_library VALUES (19, 8, 'notification.users.to', NULL, '${this.enteredBy}', true);
INSERT INTO business_process_parameter_library VALUES (20, 8, 'notification.contacts.to', NULL, '${this.contactId}', true);
INSERT INTO business_process_parameter_library VALUES (21, 8, 'notification.subject', NULL, 'Dark Horse CRM Unassigned Ticket Report (${objects.size})', true);
INSERT INTO business_process_parameter_library VALUES (22, 8, 'notification.body', NULL, '** This is an automated message **

The following tickets in Dark Horse CRM are unassigned and need attention:

', true);
INSERT INTO business_process_parameter_library VALUES (23, 8, 'report.ticket.content', NULL, '----- Ticket Details -----
Ticket # ${this.paddedId}
Created: ${this.enteredString}
Organization: ${ticketOrganization.name}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Last Modified By: ${ticketModifiedByContact.nameFirstLast}
Comment: ${this.comment}


', true);


--
-- Data for TOC entry 686 (OID 557124)
-- Name: business_process; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO business_process VALUES (1, 'dhv.ticket.insert', 'Ticket change notification', 1, 8, 1, true, '2003-12-04 16:47:36.525');
INSERT INTO business_process VALUES (2, 'dhv.report.ticketList.overdue', 'Overdue ticket notification', 2, 8, 7, true, '2003-12-04 16:47:36.525');


--
-- Data for TOC entry 687 (OID 557142)
-- Name: business_process_component; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO business_process_component VALUES (1, 1, 1, NULL, NULL, true);
INSERT INTO business_process_component VALUES (2, 1, 2, 1, NULL, true);
INSERT INTO business_process_component VALUES (3, 1, 3, 2, 1, true);
INSERT INTO business_process_component VALUES (4, 1, 4, 2, 1, false);
INSERT INTO business_process_component VALUES (5, 1, 5, 2, 0, true);
INSERT INTO business_process_component VALUES (6, 1, 3, 5, 1, true);
INSERT INTO business_process_component VALUES (7, 2, 6, NULL, NULL, true);
INSERT INTO business_process_component VALUES (8, 2, 7, 7, NULL, true);


--
-- Data for TOC entry 688 (OID 557162)
-- Name: business_process_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 689 (OID 557177)
-- Name: business_process_component_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO business_process_component_parameter VALUES (1, 3, 1, 'Tickets', true);
INSERT INTO business_process_component_parameter VALUES (2, 3, 2, '${this.id}', true);
INSERT INTO business_process_component_parameter VALUES (3, 3, 3, '${this.modified}', true);
INSERT INTO business_process_component_parameter VALUES (4, 3, 4, '${previous.enteredBy}', true);
INSERT INTO business_process_component_parameter VALUES (5, 3, 5, 'Dark Horse CRM Ticket Closed: ${this.paddedId}', true);
INSERT INTO business_process_component_parameter VALUES (6, 3, 6, 'The following ticket in Dark Horse CRM has been closed:

--- Ticket Details ---

Ticket # ${this.paddedId}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Comment: ${this.comment}

Closed by: ${ticketModifiedByContact.nameFirstLast}

Solution: ${this.solution}
', true);
INSERT INTO business_process_component_parameter VALUES (7, 6, 7, 'Tickets', true);
INSERT INTO business_process_component_parameter VALUES (8, 6, 8, '${this.id}', true);
INSERT INTO business_process_component_parameter VALUES (9, 6, 9, '${this.modified}', true);
INSERT INTO business_process_component_parameter VALUES (10, 6, 10, '${this.assignedTo}', true);
INSERT INTO business_process_component_parameter VALUES (11, 6, 11, 'Dark Horse CRM Ticket Assigned: ${this.paddedId}', true);
INSERT INTO business_process_component_parameter VALUES (12, 6, 12, 'The following ticket in Dark Horse CRM has been assigned to you:

--- Ticket Details ---

Ticket # ${this.paddedId}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Assigned By: ${ticketModifiedByContact.nameFirstLast}
Comment: ${this.comment}
', true);
INSERT INTO business_process_component_parameter VALUES (13, 7, 13, 'true', true);
INSERT INTO business_process_component_parameter VALUES (14, 7, 14, 'true', false);
INSERT INTO business_process_component_parameter VALUES (15, 7, 15, 'true', true);
INSERT INTO business_process_component_parameter VALUES (16, 7, 16, '10', true);
INSERT INTO business_process_component_parameter VALUES (17, 7, 17, '${process.lastAnchor}', true);
INSERT INTO business_process_component_parameter VALUES (18, 7, 18, '${process.nextAnchor}', true);
INSERT INTO business_process_component_parameter VALUES (19, 8, 19, '${this.enteredBy}', true);
INSERT INTO business_process_component_parameter VALUES (20, 8, 20, '${this.contactId}', false);
INSERT INTO business_process_component_parameter VALUES (21, 8, 21, 'Dark Horse CRM Unassigned Ticket Report (${objects.size})', true);
INSERT INTO business_process_component_parameter VALUES (22, 8, 22, '** This is an automated message **

The following tickets in Dark Horse CRM are unassigned and need attention:

', true);
INSERT INTO business_process_component_parameter VALUES (23, 8, 23, '----- Ticket Details -----
Ticket # ${this.paddedId}
Created: ${this.enteredString}
Organization: ${ticketOrganization.name}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Last Modified By: ${ticketModifiedByContact.nameFirstLast}
Comment: ${this.comment}


', true);


--
-- Data for TOC entry 690 (OID 557196)
-- Name: business_process_events; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 691 (OID 557218)
-- Name: business_process_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for TOC entry 692 (OID 557224)
-- Name: business_process_hook_library; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO business_process_hook_library VALUES (1, 8, 'org.aspcfs.modules.troubletickets.base.Ticket', true);


--
-- Data for TOC entry 693 (OID 557236)
-- Name: business_process_hook_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO business_process_hook_triggers VALUES (1, 2, 1, true);
INSERT INTO business_process_hook_triggers VALUES (2, 1, 1, true);


--
-- Data for TOC entry 694 (OID 557248)
-- Name: business_process_hook; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO business_process_hook VALUES (1, 1, 1, true);
INSERT INTO business_process_hook VALUES (2, 2, 1, true);


--
-- TOC entry 379 (OID 554074)
-- Name: orglist_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orglist_name ON organization USING btree (name);


--
-- TOC entry 382 (OID 554129)
-- Name: contact_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX contact_user_id_idx ON contact USING btree (user_id);


--
-- TOC entry 384 (OID 554130)
-- Name: contactlist_namecompany; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX contactlist_namecompany ON contact USING btree (namelast, namefirst, company);


--
-- TOC entry 383 (OID 554131)
-- Name: contactlist_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX contactlist_company ON contact USING btree (company, namelast, namefirst);


--
-- TOC entry 415 (OID 554896)
-- Name: oppcomplist_closedate; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oppcomplist_closedate ON opportunity_component USING btree (closedate);


--
-- TOC entry 416 (OID 554897)
-- Name: oppcomplist_description; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oppcomplist_description ON opportunity_component USING btree (description);


--
-- TOC entry 418 (OID 554946)
-- Name: call_log_cidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX call_log_cidx ON call_log USING btree (alertdate, enteredby);


--
-- TOC entry 430 (OID 555102)
-- Name: ticket_cidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ticket_cidx ON ticket USING btree (assigned_to, closed);


--
-- TOC entry 432 (OID 555103)
-- Name: ticketlist_entered; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ticketlist_entered ON ticket USING btree (entered);


--
-- TOC entry 436 (OID 555203)
-- Name: custom_field_cat_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX custom_field_cat_idx ON custom_field_category USING btree (module_id);


--
-- TOC entry 439 (OID 555222)
-- Name: custom_field_grp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX custom_field_grp_idx ON custom_field_group USING btree (category_id);


--
-- TOC entry 440 (OID 555243)
-- Name: custom_field_inf_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX custom_field_inf_idx ON custom_field_info USING btree (group_id);


--
-- TOC entry 443 (OID 555282)
-- Name: custom_field_rec_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX custom_field_rec_idx ON custom_field_record USING btree (link_module_id, link_item_id, category_id);


--
-- TOC entry 445 (OID 555297)
-- Name: custom_field_dat_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX custom_field_dat_idx ON custom_field_data USING btree (record_id, field_id);


--
-- TOC entry 451 (OID 555377)
-- Name: projects_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_idx ON projects USING btree (group_id, project_id);


--
-- TOC entry 455 (OID 555473)
-- Name: project_assignments_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX project_assignments_idx ON project_assignments USING btree (activity_id);


--
-- TOC entry 454 (OID 555474)
-- Name: project_assignments_cidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX project_assignments_cidx ON project_assignments USING btree (complete_date, user_assign_id);


--
-- TOC entry 459 (OID 555524)
-- Name: project_issues_limit_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX project_issues_limit_idx ON project_issues USING btree (type_id, project_id, enteredby);


--
-- TOC entry 458 (OID 555525)
-- Name: project_issues_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX project_issues_idx ON project_issues USING btree (issue_id);


--
-- TOC entry 463 (OID 555589)
-- Name: project_files_cidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX project_files_cidx ON project_files USING btree (link_module_id, link_item_id);


--
-- TOC entry 500 (OID 556482)
-- Name: idx_sync_map; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_sync_map ON sync_map USING btree (client_id, table_id, record_id);


--
-- TOC entry 509 (OID 556823)
-- Name: idx_autog_inv_opt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_autog_inv_opt ON autoguide_inventory_options USING btree (inventory_id, option_id);


--
-- TOC entry 360 (OID 553874)
-- Name: access_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "access"
    ADD CONSTRAINT access_pkey PRIMARY KEY (user_id);


--
-- TOC entry 361 (OID 553884)
-- Name: lookup_industry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_industry
    ADD CONSTRAINT lookup_industry_pkey PRIMARY KEY (code);


--
-- TOC entry 362 (OID 553892)
-- Name: access_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY access_log
    ADD CONSTRAINT access_log_pkey PRIMARY KEY (id);


--
-- TOC entry 695 (OID 553894)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY access_log
    ADD CONSTRAINT "$1" FOREIGN KEY (user_id) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 363 (OID 553904)
-- Name: usage_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usage_log
    ADD CONSTRAINT usage_log_pkey PRIMARY KEY (usage_id);


--
-- TOC entry 364 (OID 553915)
-- Name: lookup_contact_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_contact_types
    ADD CONSTRAINT lookup_contact_types_pkey PRIMARY KEY (code);


--
-- TOC entry 696 (OID 553917)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_contact_types
    ADD CONSTRAINT "$1" FOREIGN KEY (user_id) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 365 (OID 553929)
-- Name: lookup_account_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_account_types
    ADD CONSTRAINT lookup_account_types_pkey PRIMARY KEY (code);


--
-- TOC entry 366 (OID 553933)
-- Name: state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY state
    ADD CONSTRAINT state_pkey PRIMARY KEY (state_code);


--
-- TOC entry 367 (OID 553943)
-- Name: lookup_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_department
    ADD CONSTRAINT lookup_department_pkey PRIMARY KEY (code);


--
-- TOC entry 368 (OID 553953)
-- Name: lookup_orgaddress_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_orgaddress_types
    ADD CONSTRAINT lookup_orgaddress_types_pkey PRIMARY KEY (code);


--
-- TOC entry 369 (OID 553963)
-- Name: lookup_orgemail_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_orgemail_types
    ADD CONSTRAINT lookup_orgemail_types_pkey PRIMARY KEY (code);


--
-- TOC entry 370 (OID 553973)
-- Name: lookup_orgphone_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_orgphone_types
    ADD CONSTRAINT lookup_orgphone_types_pkey PRIMARY KEY (code);


--
-- TOC entry 371 (OID 553983)
-- Name: lookup_instantmessenger_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_instantmessenger_types
    ADD CONSTRAINT lookup_instantmessenger_types_pkey PRIMARY KEY (code);


--
-- TOC entry 372 (OID 553993)
-- Name: lookup_employment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_employment_types
    ADD CONSTRAINT lookup_employment_types_pkey PRIMARY KEY (code);


--
-- TOC entry 373 (OID 554003)
-- Name: lookup_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_locale
    ADD CONSTRAINT lookup_locale_pkey PRIMARY KEY (code);


--
-- TOC entry 374 (OID 554013)
-- Name: lookup_contactaddress_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_contactaddress_types
    ADD CONSTRAINT lookup_contactaddress_types_pkey PRIMARY KEY (code);


--
-- TOC entry 375 (OID 554023)
-- Name: lookup_contactemail_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_contactemail_types
    ADD CONSTRAINT lookup_contactemail_types_pkey PRIMARY KEY (code);


--
-- TOC entry 376 (OID 554033)
-- Name: lookup_contactphone_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_contactphone_types
    ADD CONSTRAINT lookup_contactphone_types_pkey PRIMARY KEY (code);


--
-- TOC entry 377 (OID 554042)
-- Name: lookup_access_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_access_types
    ADD CONSTRAINT lookup_access_types_pkey PRIMARY KEY (code);


--
-- TOC entry 378 (OID 554060)
-- Name: organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (org_id);


--
-- TOC entry 697 (OID 554062)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT "$1" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 698 (OID 554066)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT "$2" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 699 (OID 554070)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT "$3" FOREIGN KEY ("owner") REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 381 (OID 554089)
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (contact_id);


--
-- TOC entry 380 (OID 554091)
-- Name: contact_employee_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_employee_id_key UNIQUE (employee_id);


--
-- TOC entry 700 (OID 554093)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT "$1" FOREIGN KEY (user_id) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 701 (OID 554097)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT "$2" FOREIGN KEY (org_id) REFERENCES organization(org_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 702 (OID 554101)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT "$3" FOREIGN KEY (department) REFERENCES lookup_department(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 703 (OID 554105)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT "$4" FOREIGN KEY (super) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 704 (OID 554109)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT "$5" FOREIGN KEY (assistant) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 705 (OID 554113)
-- Name: $6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT "$6" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 706 (OID 554117)
-- Name: $7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT "$7" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 707 (OID 554121)
-- Name: $8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT "$8" FOREIGN KEY ("owner") REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 708 (OID 554125)
-- Name: $9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT "$9" FOREIGN KEY (access_type) REFERENCES lookup_access_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 385 (OID 554141)
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 709 (OID 554143)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role
    ADD CONSTRAINT "$1" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 710 (OID 554147)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role
    ADD CONSTRAINT "$2" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 386 (OID 554166)
-- Name: permission_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission_category
    ADD CONSTRAINT permission_category_pkey PRIMARY KEY (category_id);


--
-- TOC entry 387 (OID 554182)
-- Name: permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (permission_id);


--
-- TOC entry 711 (OID 554184)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission
    ADD CONSTRAINT "$1" FOREIGN KEY (category_id) REFERENCES permission_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 388 (OID 554197)
-- Name: role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 712 (OID 554199)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role_permission
    ADD CONSTRAINT "$1" FOREIGN KEY (role_id) REFERENCES role(role_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 713 (OID 554203)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role_permission
    ADD CONSTRAINT "$2" FOREIGN KEY (permission_id) REFERENCES permission(permission_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 389 (OID 554215)
-- Name: lookup_stage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_stage
    ADD CONSTRAINT lookup_stage_pkey PRIMARY KEY (code);


--
-- TOC entry 390 (OID 554225)
-- Name: lookup_delivery_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_delivery_options
    ADD CONSTRAINT lookup_delivery_options_pkey PRIMARY KEY (code);


--
-- TOC entry 391 (OID 554236)
-- Name: news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY news
    ADD CONSTRAINT news_pkey PRIMARY KEY (rec_id);


--
-- TOC entry 714 (OID 554238)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY news
    ADD CONSTRAINT "$1" FOREIGN KEY (org_id) REFERENCES organization(org_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 392 (OID 554249)
-- Name: organization_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_address
    ADD CONSTRAINT organization_address_pkey PRIMARY KEY (address_id);


--
-- TOC entry 715 (OID 554251)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_address
    ADD CONSTRAINT "$1" FOREIGN KEY (org_id) REFERENCES organization(org_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 716 (OID 554255)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_address
    ADD CONSTRAINT "$2" FOREIGN KEY (address_type) REFERENCES lookup_orgaddress_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 717 (OID 554259)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_address
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 718 (OID 554263)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_address
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 393 (OID 554274)
-- Name: organization_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_emailaddress
    ADD CONSTRAINT organization_emailaddress_pkey PRIMARY KEY (emailaddress_id);


--
-- TOC entry 719 (OID 554276)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_emailaddress
    ADD CONSTRAINT "$1" FOREIGN KEY (org_id) REFERENCES organization(org_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 720 (OID 554280)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_emailaddress
    ADD CONSTRAINT "$2" FOREIGN KEY (emailaddress_type) REFERENCES lookup_orgemail_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 721 (OID 554284)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_emailaddress
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 722 (OID 554288)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_emailaddress
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 394 (OID 554299)
-- Name: organization_phone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_phone
    ADD CONSTRAINT organization_phone_pkey PRIMARY KEY (phone_id);


--
-- TOC entry 723 (OID 554301)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_phone
    ADD CONSTRAINT "$1" FOREIGN KEY (org_id) REFERENCES organization(org_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 724 (OID 554305)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_phone
    ADD CONSTRAINT "$2" FOREIGN KEY (phone_type) REFERENCES lookup_orgphone_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 725 (OID 554309)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_phone
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 726 (OID 554313)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_phone
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 395 (OID 554324)
-- Name: contact_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_address
    ADD CONSTRAINT contact_address_pkey PRIMARY KEY (address_id);


--
-- TOC entry 727 (OID 554326)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_address
    ADD CONSTRAINT "$1" FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 728 (OID 554330)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_address
    ADD CONSTRAINT "$2" FOREIGN KEY (address_type) REFERENCES lookup_contactaddress_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 729 (OID 554334)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_address
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 730 (OID 554338)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_address
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 396 (OID 554349)
-- Name: contact_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_emailaddress
    ADD CONSTRAINT contact_emailaddress_pkey PRIMARY KEY (emailaddress_id);


--
-- TOC entry 731 (OID 554351)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_emailaddress
    ADD CONSTRAINT "$1" FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 732 (OID 554355)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_emailaddress
    ADD CONSTRAINT "$2" FOREIGN KEY (emailaddress_type) REFERENCES lookup_contactemail_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 733 (OID 554359)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_emailaddress
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 734 (OID 554363)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_emailaddress
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 397 (OID 554374)
-- Name: contact_phone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_phone
    ADD CONSTRAINT contact_phone_pkey PRIMARY KEY (phone_id);


--
-- TOC entry 735 (OID 554376)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_phone
    ADD CONSTRAINT "$1" FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 736 (OID 554380)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_phone
    ADD CONSTRAINT "$2" FOREIGN KEY (phone_type) REFERENCES lookup_contactphone_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 737 (OID 554384)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_phone
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 738 (OID 554388)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_phone
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 398 (OID 554402)
-- Name: notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (notification_id);


--
-- TOC entry 399 (OID 554417)
-- Name: cfsinbox_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cfsinbox_message
    ADD CONSTRAINT cfsinbox_message_pkey PRIMARY KEY (id);


--
-- TOC entry 739 (OID 554419)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cfsinbox_message
    ADD CONSTRAINT "$1" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 740 (OID 554423)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cfsinbox_message
    ADD CONSTRAINT "$2" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 741 (OID 554431)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cfsinbox_messagelink
    ADD CONSTRAINT "$1" FOREIGN KEY (id) REFERENCES cfsinbox_message(id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 742 (OID 554435)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cfsinbox_messagelink
    ADD CONSTRAINT "$2" FOREIGN KEY (sent_to) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 743 (OID 554439)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cfsinbox_messagelink
    ADD CONSTRAINT "$3" FOREIGN KEY (sent_from) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 744 (OID 554447)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_type_levels
    ADD CONSTRAINT "$1" FOREIGN KEY (org_id) REFERENCES organization(org_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 745 (OID 554451)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account_type_levels
    ADD CONSTRAINT "$2" FOREIGN KEY (type_id) REFERENCES lookup_account_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 746 (OID 554459)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_type_levels
    ADD CONSTRAINT "$1" FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 747 (OID 554463)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_type_levels
    ADD CONSTRAINT "$2" FOREIGN KEY (type_id) REFERENCES lookup_contact_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 400 (OID 554477)
-- Name: lookup_lists_lookup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_lists_lookup
    ADD CONSTRAINT lookup_lists_lookup_pkey PRIMARY KEY (id);


--
-- TOC entry 748 (OID 554479)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_lists_lookup
    ADD CONSTRAINT "$1" FOREIGN KEY (module_id) REFERENCES permission_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 401 (OID 554491)
-- Name: viewpoint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viewpoint
    ADD CONSTRAINT viewpoint_pkey PRIMARY KEY (viewpoint_id);


--
-- TOC entry 749 (OID 554493)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viewpoint
    ADD CONSTRAINT "$1" FOREIGN KEY (user_id) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 750 (OID 554497)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viewpoint
    ADD CONSTRAINT "$2" FOREIGN KEY (vp_user_id) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 751 (OID 554501)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viewpoint
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 752 (OID 554505)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viewpoint
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 402 (OID 554518)
-- Name: viewpoint_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viewpoint_permission
    ADD CONSTRAINT viewpoint_permission_pkey PRIMARY KEY (vp_permission_id);


--
-- TOC entry 753 (OID 554520)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viewpoint_permission
    ADD CONSTRAINT "$1" FOREIGN KEY (viewpoint_id) REFERENCES viewpoint(viewpoint_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 754 (OID 554524)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viewpoint_permission
    ADD CONSTRAINT "$2" FOREIGN KEY (permission_id) REFERENCES permission(permission_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 403 (OID 554541)
-- Name: report_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_pkey PRIMARY KEY (report_id);


--
-- TOC entry 755 (OID 554543)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report
    ADD CONSTRAINT "$1" FOREIGN KEY (category_id) REFERENCES permission_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 756 (OID 554547)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report
    ADD CONSTRAINT "$2" FOREIGN KEY (permission_id) REFERENCES permission(permission_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 757 (OID 554551)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 758 (OID 554555)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 404 (OID 554567)
-- Name: report_criteria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_criteria
    ADD CONSTRAINT report_criteria_pkey PRIMARY KEY (criteria_id);


--
-- TOC entry 759 (OID 554569)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_criteria
    ADD CONSTRAINT "$1" FOREIGN KEY (report_id) REFERENCES report(report_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 760 (OID 554573)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_criteria
    ADD CONSTRAINT "$2" FOREIGN KEY ("owner") REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 761 (OID 554577)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_criteria
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 762 (OID 554581)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_criteria
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 405 (OID 554593)
-- Name: report_criteria_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_criteria_parameter
    ADD CONSTRAINT report_criteria_parameter_pkey PRIMARY KEY (parameter_id);


--
-- TOC entry 763 (OID 554595)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_criteria_parameter
    ADD CONSTRAINT "$1" FOREIGN KEY (criteria_id) REFERENCES report_criteria(criteria_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 406 (OID 554608)
-- Name: report_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_queue
    ADD CONSTRAINT report_queue_pkey PRIMARY KEY (queue_id);


--
-- TOC entry 764 (OID 554610)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_queue
    ADD CONSTRAINT "$1" FOREIGN KEY (report_id) REFERENCES report(report_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 765 (OID 554614)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_queue
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 407 (OID 554626)
-- Name: report_queue_criteria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_queue_criteria
    ADD CONSTRAINT report_queue_criteria_pkey PRIMARY KEY (criteria_id);


--
-- TOC entry 766 (OID 554628)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_queue_criteria
    ADD CONSTRAINT "$1" FOREIGN KEY (queue_id) REFERENCES report_queue(queue_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 408 (OID 554640)
-- Name: action_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_list
    ADD CONSTRAINT action_list_pkey PRIMARY KEY (action_id);


--
-- TOC entry 767 (OID 554642)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_list
    ADD CONSTRAINT "$1" FOREIGN KEY ("owner") REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 768 (OID 554646)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_list
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 769 (OID 554650)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_list
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 409 (OID 554662)
-- Name: action_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_item
    ADD CONSTRAINT action_item_pkey PRIMARY KEY (item_id);


--
-- TOC entry 770 (OID 554664)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_item
    ADD CONSTRAINT "$1" FOREIGN KEY (action_id) REFERENCES action_list(action_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 771 (OID 554668)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_item
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 772 (OID 554672)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_item
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 410 (OID 554684)
-- Name: action_item_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_item_log
    ADD CONSTRAINT action_item_log_pkey PRIMARY KEY (log_id);


--
-- TOC entry 773 (OID 554686)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_item_log
    ADD CONSTRAINT "$1" FOREIGN KEY (item_id) REFERENCES action_item(item_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 774 (OID 554690)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_item_log
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 775 (OID 554694)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY action_item_log
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 411 (OID 554704)
-- Name: database_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY database_version
    ADD CONSTRAINT database_version_pkey PRIMARY KEY (version_id);


--
-- TOC entry 412 (OID 554831)
-- Name: lookup_call_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_call_types
    ADD CONSTRAINT lookup_call_types_pkey PRIMARY KEY (code);


--
-- TOC entry 413 (OID 554841)
-- Name: lookup_opportunity_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_opportunity_types
    ADD CONSTRAINT lookup_opportunity_types_pkey PRIMARY KEY (code);


--
-- TOC entry 414 (OID 554852)
-- Name: opportunity_header_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_header
    ADD CONSTRAINT opportunity_header_pkey PRIMARY KEY (opp_id);


--
-- TOC entry 776 (OID 554854)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_header
    ADD CONSTRAINT "$1" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 777 (OID 554858)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_header
    ADD CONSTRAINT "$2" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 417 (OID 554874)
-- Name: opportunity_component_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_component
    ADD CONSTRAINT opportunity_component_pkey PRIMARY KEY (id);


--
-- TOC entry 778 (OID 554876)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_component
    ADD CONSTRAINT "$1" FOREIGN KEY (opp_id) REFERENCES opportunity_header(opp_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 779 (OID 554880)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_component
    ADD CONSTRAINT "$2" FOREIGN KEY ("owner") REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 780 (OID 554884)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_component
    ADD CONSTRAINT "$3" FOREIGN KEY (stage) REFERENCES lookup_stage(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 781 (OID 554888)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_component
    ADD CONSTRAINT "$4" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 782 (OID 554892)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_component
    ADD CONSTRAINT "$5" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 783 (OID 554902)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_component_levels
    ADD CONSTRAINT "$1" FOREIGN KEY (opp_id) REFERENCES opportunity_component(id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 784 (OID 554906)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunity_component_levels
    ADD CONSTRAINT "$2" FOREIGN KEY (type_id) REFERENCES lookup_opportunity_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 419 (OID 554920)
-- Name: call_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY call_log
    ADD CONSTRAINT call_log_pkey PRIMARY KEY (call_id);


--
-- TOC entry 785 (OID 554922)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY call_log
    ADD CONSTRAINT "$1" FOREIGN KEY (org_id) REFERENCES organization(org_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 786 (OID 554926)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY call_log
    ADD CONSTRAINT "$2" FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 787 (OID 554930)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY call_log
    ADD CONSTRAINT "$3" FOREIGN KEY (opp_id) REFERENCES opportunity_header(opp_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 788 (OID 554934)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY call_log
    ADD CONSTRAINT "$4" FOREIGN KEY (call_type_id) REFERENCES lookup_call_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 789 (OID 554938)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY call_log
    ADD CONSTRAINT "$5" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 790 (OID 554942)
-- Name: $6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY call_log
    ADD CONSTRAINT "$6" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 421 (OID 554971)
-- Name: ticket_level_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket_level
    ADD CONSTRAINT ticket_level_pkey PRIMARY KEY (code);


--
-- TOC entry 420 (OID 554973)
-- Name: ticket_level_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket_level
    ADD CONSTRAINT ticket_level_description_key UNIQUE (description);


--
-- TOC entry 423 (OID 554987)
-- Name: ticket_severity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket_severity
    ADD CONSTRAINT ticket_severity_pkey PRIMARY KEY (code);


--
-- TOC entry 422 (OID 554989)
-- Name: ticket_severity_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket_severity
    ADD CONSTRAINT ticket_severity_description_key UNIQUE (description);


--
-- TOC entry 425 (OID 554999)
-- Name: lookup_ticketsource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_ticketsource
    ADD CONSTRAINT lookup_ticketsource_pkey PRIMARY KEY (code);


--
-- TOC entry 424 (OID 555001)
-- Name: lookup_ticketsource_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_ticketsource
    ADD CONSTRAINT lookup_ticketsource_description_key UNIQUE (description);


--
-- TOC entry 427 (OID 555015)
-- Name: ticket_priority_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket_priority
    ADD CONSTRAINT ticket_priority_pkey PRIMARY KEY (code);


--
-- TOC entry 426 (OID 555017)
-- Name: ticket_priority_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket_priority
    ADD CONSTRAINT ticket_priority_description_key UNIQUE (description);


--
-- TOC entry 428 (OID 555032)
-- Name: ticket_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket_category
    ADD CONSTRAINT ticket_category_pkey PRIMARY KEY (id);


--
-- TOC entry 429 (OID 555048)
-- Name: ticket_category_draft_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket_category_draft
    ADD CONSTRAINT ticket_category_draft_pkey PRIMARY KEY (id);


--
-- TOC entry 431 (OID 555060)
-- Name: ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (ticketid);


--
-- TOC entry 791 (OID 555062)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT "$1" FOREIGN KEY (org_id) REFERENCES organization(org_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 792 (OID 555066)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT "$2" FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 793 (OID 555070)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 794 (OID 555074)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 795 (OID 555078)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT "$5" FOREIGN KEY (pri_code) REFERENCES ticket_priority(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 796 (OID 555082)
-- Name: $6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT "$6" FOREIGN KEY (level_code) REFERENCES ticket_level(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 797 (OID 555086)
-- Name: $7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT "$7" FOREIGN KEY (department_code) REFERENCES lookup_department(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 798 (OID 555090)
-- Name: $8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT "$8" FOREIGN KEY (source_code) REFERENCES lookup_ticketsource(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 799 (OID 555094)
-- Name: $9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT "$9" FOREIGN KEY (assigned_to) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 800 (OID 555098)
-- Name: $10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT "$10" FOREIGN KEY (scode) REFERENCES ticket_severity(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 433 (OID 555114)
-- Name: ticketlog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticketlog
    ADD CONSTRAINT ticketlog_pkey PRIMARY KEY (id);


--
-- TOC entry 801 (OID 555116)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticketlog
    ADD CONSTRAINT "$1" FOREIGN KEY (ticketid) REFERENCES ticket(ticketid) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 802 (OID 555120)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticketlog
    ADD CONSTRAINT "$2" FOREIGN KEY (assigned_to) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 803 (OID 555124)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticketlog
    ADD CONSTRAINT "$3" FOREIGN KEY (pri_code) REFERENCES ticket_priority(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 804 (OID 555128)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticketlog
    ADD CONSTRAINT "$4" FOREIGN KEY (department_code) REFERENCES lookup_department(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 805 (OID 555132)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticketlog
    ADD CONSTRAINT "$5" FOREIGN KEY (scode) REFERENCES ticket_severity(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 806 (OID 555136)
-- Name: $6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticketlog
    ADD CONSTRAINT "$6" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 807 (OID 555140)
-- Name: $7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ticketlog
    ADD CONSTRAINT "$7" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 435 (OID 555174)
-- Name: module_field_categorylink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY module_field_categorylink
    ADD CONSTRAINT module_field_categorylink_pkey PRIMARY KEY (id);


--
-- TOC entry 434 (OID 555176)
-- Name: module_field_categorylink_category_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY module_field_categorylink
    ADD CONSTRAINT module_field_categorylink_category_id_key UNIQUE (category_id);


--
-- TOC entry 808 (OID 555178)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY module_field_categorylink
    ADD CONSTRAINT "$1" FOREIGN KEY (module_id) REFERENCES permission_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 437 (OID 555197)
-- Name: custom_field_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_category
    ADD CONSTRAINT custom_field_category_pkey PRIMARY KEY (category_id);


--
-- TOC entry 809 (OID 555199)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_category
    ADD CONSTRAINT "$1" FOREIGN KEY (module_id) REFERENCES module_field_categorylink(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 438 (OID 555216)
-- Name: custom_field_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_group
    ADD CONSTRAINT custom_field_group_pkey PRIMARY KEY (group_id);


--
-- TOC entry 810 (OID 555218)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_group
    ADD CONSTRAINT "$1" FOREIGN KEY (category_id) REFERENCES custom_field_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 441 (OID 555237)
-- Name: custom_field_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_info
    ADD CONSTRAINT custom_field_info_pkey PRIMARY KEY (field_id);


--
-- TOC entry 811 (OID 555239)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_info
    ADD CONSTRAINT "$1" FOREIGN KEY (group_id) REFERENCES custom_field_group(group_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 442 (OID 555254)
-- Name: custom_field_lookup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_lookup
    ADD CONSTRAINT custom_field_lookup_pkey PRIMARY KEY (code);


--
-- TOC entry 812 (OID 555256)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_lookup
    ADD CONSTRAINT "$1" FOREIGN KEY (field_id) REFERENCES custom_field_info(field_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 444 (OID 555268)
-- Name: custom_field_record_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_record
    ADD CONSTRAINT custom_field_record_pkey PRIMARY KEY (record_id);


--
-- TOC entry 813 (OID 555270)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_record
    ADD CONSTRAINT "$1" FOREIGN KEY (category_id) REFERENCES custom_field_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 814 (OID 555274)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_record
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 815 (OID 555278)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_record
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 816 (OID 555289)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_data
    ADD CONSTRAINT "$1" FOREIGN KEY (record_id) REFERENCES custom_field_record(record_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 817 (OID 555293)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custom_field_data
    ADD CONSTRAINT "$2" FOREIGN KEY (field_id) REFERENCES custom_field_info(field_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 446 (OID 555308)
-- Name: lookup_project_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_project_activity
    ADD CONSTRAINT lookup_project_activity_pkey PRIMARY KEY (code);


--
-- TOC entry 447 (OID 555319)
-- Name: lookup_project_priority_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_project_priority
    ADD CONSTRAINT lookup_project_priority_pkey PRIMARY KEY (code);


--
-- TOC entry 448 (OID 555330)
-- Name: lookup_project_issues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_project_issues
    ADD CONSTRAINT lookup_project_issues_pkey PRIMARY KEY (code);


--
-- TOC entry 449 (OID 555341)
-- Name: lookup_project_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_project_status
    ADD CONSTRAINT lookup_project_status_pkey PRIMARY KEY (code);


--
-- TOC entry 450 (OID 555353)
-- Name: lookup_project_loe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_project_loe
    ADD CONSTRAINT lookup_project_loe_pkey PRIMARY KEY (code);


--
-- TOC entry 452 (OID 555363)
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);


--
-- TOC entry 818 (OID 555365)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT "$1" FOREIGN KEY (department_id) REFERENCES lookup_department(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 819 (OID 555369)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 820 (OID 555373)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 453 (OID 555388)
-- Name: project_requirements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_requirements
    ADD CONSTRAINT project_requirements_pkey PRIMARY KEY (requirement_id);


--
-- TOC entry 821 (OID 555390)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_requirements
    ADD CONSTRAINT "$1" FOREIGN KEY (project_id) REFERENCES projects(project_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 822 (OID 555394)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_requirements
    ADD CONSTRAINT "$2" FOREIGN KEY (estimated_loetype) REFERENCES lookup_project_loe(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 823 (OID 555398)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_requirements
    ADD CONSTRAINT "$3" FOREIGN KEY (actual_loetype) REFERENCES lookup_project_loe(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 824 (OID 555402)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_requirements
    ADD CONSTRAINT "$4" FOREIGN KEY (approvedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 825 (OID 555406)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_requirements
    ADD CONSTRAINT "$5" FOREIGN KEY (closedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 826 (OID 555410)
-- Name: $6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_requirements
    ADD CONSTRAINT "$6" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 827 (OID 555414)
-- Name: $7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_requirements
    ADD CONSTRAINT "$7" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 456 (OID 555427)
-- Name: project_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT project_assignments_pkey PRIMARY KEY (assignment_id);


--
-- TOC entry 828 (OID 555429)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$1" FOREIGN KEY (project_id) REFERENCES projects(project_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 829 (OID 555433)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$2" FOREIGN KEY (requirement_id) REFERENCES project_requirements(requirement_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 830 (OID 555437)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$3" FOREIGN KEY (assignedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 831 (OID 555441)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$4" FOREIGN KEY (user_assign_id) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 832 (OID 555445)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$5" FOREIGN KEY (activity_id) REFERENCES lookup_project_activity(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 833 (OID 555449)
-- Name: $6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$6" FOREIGN KEY (estimated_loetype) REFERENCES lookup_project_loe(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 834 (OID 555453)
-- Name: $7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$7" FOREIGN KEY (actual_loetype) REFERENCES lookup_project_loe(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 835 (OID 555457)
-- Name: $8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$8" FOREIGN KEY (priority_id) REFERENCES lookup_project_priority(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 836 (OID 555461)
-- Name: $9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$9" FOREIGN KEY (status_id) REFERENCES lookup_project_status(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 837 (OID 555465)
-- Name: $10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$10" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 838 (OID 555469)
-- Name: $11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments
    ADD CONSTRAINT "$11" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 457 (OID 555484)
-- Name: project_assignments_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments_status
    ADD CONSTRAINT project_assignments_status_pkey PRIMARY KEY (status_id);


--
-- TOC entry 839 (OID 555486)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments_status
    ADD CONSTRAINT "$1" FOREIGN KEY (assignment_id) REFERENCES project_assignments(assignment_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 840 (OID 555490)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_assignments_status
    ADD CONSTRAINT "$2" FOREIGN KEY (user_id) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 460 (OID 555506)
-- Name: project_issues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_issues
    ADD CONSTRAINT project_issues_pkey PRIMARY KEY (issue_id);


--
-- TOC entry 841 (OID 555508)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_issues
    ADD CONSTRAINT "$1" FOREIGN KEY (project_id) REFERENCES projects(project_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 842 (OID 555512)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_issues
    ADD CONSTRAINT "$2" FOREIGN KEY (type_id) REFERENCES lookup_project_issues(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 843 (OID 555516)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_issues
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 844 (OID 555520)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_issues
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 461 (OID 555537)
-- Name: project_issue_replies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_issue_replies
    ADD CONSTRAINT project_issue_replies_pkey PRIMARY KEY (reply_id);


--
-- TOC entry 845 (OID 555539)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_issue_replies
    ADD CONSTRAINT "$1" FOREIGN KEY (issue_id) REFERENCES project_issues(issue_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 846 (OID 555543)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_issue_replies
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 847 (OID 555547)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_issue_replies
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 462 (OID 555559)
-- Name: project_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_folders
    ADD CONSTRAINT project_folders_pkey PRIMARY KEY (folder_id);


--
-- TOC entry 464 (OID 555575)
-- Name: project_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_files
    ADD CONSTRAINT project_files_pkey PRIMARY KEY (item_id);


--
-- TOC entry 848 (OID 555577)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_files
    ADD CONSTRAINT "$1" FOREIGN KEY (folder_id) REFERENCES project_folders(folder_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 849 (OID 555581)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_files
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 850 (OID 555585)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_files
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 851 (OID 555601)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_files_version
    ADD CONSTRAINT "$1" FOREIGN KEY (item_id) REFERENCES project_files(item_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 852 (OID 555605)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_files_version
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 853 (OID 555609)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_files_version
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 854 (OID 555617)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_files_download
    ADD CONSTRAINT "$1" FOREIGN KEY (item_id) REFERENCES project_files(item_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 855 (OID 555621)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_files_download
    ADD CONSTRAINT "$2" FOREIGN KEY (user_download_id) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 856 (OID 555629)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_team
    ADD CONSTRAINT "$1" FOREIGN KEY (project_id) REFERENCES projects(project_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 857 (OID 555633)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_team
    ADD CONSTRAINT "$2" FOREIGN KEY (user_id) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 858 (OID 555637)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_team
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 859 (OID 555641)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_team
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 465 (OID 555693)
-- Name: saved_criterialist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY saved_criterialist
    ADD CONSTRAINT saved_criterialist_pkey PRIMARY KEY (id);


--
-- TOC entry 860 (OID 555695)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY saved_criterialist
    ADD CONSTRAINT "$1" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 861 (OID 555699)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY saved_criterialist
    ADD CONSTRAINT "$2" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 862 (OID 555703)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY saved_criterialist
    ADD CONSTRAINT "$3" FOREIGN KEY ("owner") REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 466 (OID 555723)
-- Name: campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_pkey PRIMARY KEY (campaign_id);


--
-- TOC entry 863 (OID 555725)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT "$1" FOREIGN KEY (approvedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 864 (OID 555729)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 865 (OID 555733)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 467 (OID 555748)
-- Name: campaign_run_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign_run
    ADD CONSTRAINT campaign_run_pkey PRIMARY KEY (id);


--
-- TOC entry 866 (OID 555750)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign_run
    ADD CONSTRAINT "$1" FOREIGN KEY (campaign_id) REFERENCES campaign(campaign_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 468 (OID 555759)
-- Name: excluded_recipient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY excluded_recipient
    ADD CONSTRAINT excluded_recipient_pkey PRIMARY KEY (id);


--
-- TOC entry 867 (OID 555761)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY excluded_recipient
    ADD CONSTRAINT "$1" FOREIGN KEY (campaign_id) REFERENCES campaign(campaign_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 868 (OID 555765)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY excluded_recipient
    ADD CONSTRAINT "$2" FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 869 (OID 555771)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign_list_groups
    ADD CONSTRAINT "$1" FOREIGN KEY (campaign_id) REFERENCES campaign(campaign_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 870 (OID 555775)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign_list_groups
    ADD CONSTRAINT "$2" FOREIGN KEY (group_id) REFERENCES saved_criterialist(id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 469 (OID 555787)
-- Name: active_campaign_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_campaign_groups
    ADD CONSTRAINT active_campaign_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 871 (OID 555789)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_campaign_groups
    ADD CONSTRAINT "$1" FOREIGN KEY (campaign_id) REFERENCES campaign(campaign_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 470 (OID 555802)
-- Name: scheduled_recipient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scheduled_recipient
    ADD CONSTRAINT scheduled_recipient_pkey PRIMARY KEY (id);


--
-- TOC entry 872 (OID 555804)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scheduled_recipient
    ADD CONSTRAINT "$1" FOREIGN KEY (campaign_id) REFERENCES campaign(campaign_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 873 (OID 555808)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scheduled_recipient
    ADD CONSTRAINT "$2" FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 471 (OID 555820)
-- Name: lookup_survey_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_survey_types
    ADD CONSTRAINT lookup_survey_types_pkey PRIMARY KEY (code);


--
-- TOC entry 472 (OID 555836)
-- Name: survey_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey
    ADD CONSTRAINT survey_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 874 (OID 555838)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey
    ADD CONSTRAINT "$1" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 875 (OID 555842)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey
    ADD CONSTRAINT "$2" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 876 (OID 555848)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign_survey_link
    ADD CONSTRAINT "$1" FOREIGN KEY (campaign_id) REFERENCES campaign(campaign_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 877 (OID 555852)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign_survey_link
    ADD CONSTRAINT "$2" FOREIGN KEY (survey_id) REFERENCES survey(survey_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 473 (OID 555863)
-- Name: survey_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_questions
    ADD CONSTRAINT survey_questions_pkey PRIMARY KEY (question_id);


--
-- TOC entry 878 (OID 555865)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_questions
    ADD CONSTRAINT "$1" FOREIGN KEY (survey_id) REFERENCES survey(survey_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 879 (OID 555869)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_questions
    ADD CONSTRAINT "$2" FOREIGN KEY ("type") REFERENCES lookup_survey_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 474 (OID 555879)
-- Name: survey_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_items
    ADD CONSTRAINT survey_items_pkey PRIMARY KEY (item_id);


--
-- TOC entry 880 (OID 555881)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_items
    ADD CONSTRAINT "$1" FOREIGN KEY (question_id) REFERENCES survey_questions(question_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 475 (OID 555897)
-- Name: active_survey_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey
    ADD CONSTRAINT active_survey_pkey PRIMARY KEY (active_survey_id);


--
-- TOC entry 881 (OID 555899)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey
    ADD CONSTRAINT "$1" FOREIGN KEY (campaign_id) REFERENCES campaign(campaign_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 882 (OID 555903)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey
    ADD CONSTRAINT "$2" FOREIGN KEY ("type") REFERENCES lookup_survey_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 883 (OID 555907)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 884 (OID 555911)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 476 (OID 555930)
-- Name: active_survey_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_questions
    ADD CONSTRAINT active_survey_questions_pkey PRIMARY KEY (question_id);


--
-- TOC entry 885 (OID 555932)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_questions
    ADD CONSTRAINT "$1" FOREIGN KEY (active_survey_id) REFERENCES active_survey(active_survey_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 886 (OID 555936)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_questions
    ADD CONSTRAINT "$2" FOREIGN KEY ("type") REFERENCES lookup_survey_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 477 (OID 555946)
-- Name: active_survey_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_items
    ADD CONSTRAINT active_survey_items_pkey PRIMARY KEY (item_id);


--
-- TOC entry 887 (OID 555948)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_items
    ADD CONSTRAINT "$1" FOREIGN KEY (question_id) REFERENCES active_survey_questions(question_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 478 (OID 555959)
-- Name: active_survey_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_responses
    ADD CONSTRAINT active_survey_responses_pkey PRIMARY KEY (response_id);


--
-- TOC entry 888 (OID 555961)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_responses
    ADD CONSTRAINT "$1" FOREIGN KEY (active_survey_id) REFERENCES active_survey(active_survey_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 479 (OID 555974)
-- Name: active_survey_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_answers
    ADD CONSTRAINT active_survey_answers_pkey PRIMARY KEY (answer_id);


--
-- TOC entry 889 (OID 555976)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_answers
    ADD CONSTRAINT "$1" FOREIGN KEY (response_id) REFERENCES active_survey_responses(response_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 890 (OID 555980)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_answers
    ADD CONSTRAINT "$2" FOREIGN KEY (question_id) REFERENCES active_survey_questions(question_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 480 (OID 555992)
-- Name: active_survey_answer_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_answer_items
    ADD CONSTRAINT active_survey_answer_items_pkey PRIMARY KEY (id);


--
-- TOC entry 891 (OID 555994)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_answer_items
    ADD CONSTRAINT "$1" FOREIGN KEY (item_id) REFERENCES active_survey_items(item_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 892 (OID 555998)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_answer_items
    ADD CONSTRAINT "$2" FOREIGN KEY (answer_id) REFERENCES active_survey_answers(answer_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 481 (OID 556008)
-- Name: active_survey_answer_avg_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_answer_avg
    ADD CONSTRAINT active_survey_answer_avg_pkey PRIMARY KEY (id);


--
-- TOC entry 893 (OID 556010)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_answer_avg
    ADD CONSTRAINT "$1" FOREIGN KEY (question_id) REFERENCES active_survey_questions(question_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 894 (OID 556014)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_survey_answer_avg
    ADD CONSTRAINT "$2" FOREIGN KEY (item_id) REFERENCES active_survey_items(item_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 482 (OID 556025)
-- Name: field_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY field_types
    ADD CONSTRAINT field_types_pkey PRIMARY KEY (id);


--
-- TOC entry 483 (OID 556035)
-- Name: search_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY search_fields
    ADD CONSTRAINT search_fields_pkey PRIMARY KEY (id);


--
-- TOC entry 484 (OID 556048)
-- Name: message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- TOC entry 895 (OID 556050)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message
    ADD CONSTRAINT "$1" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 896 (OID 556054)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message
    ADD CONSTRAINT "$2" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 897 (OID 556058)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message
    ADD CONSTRAINT "$3" FOREIGN KEY (access_type) REFERENCES lookup_access_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 485 (OID 556070)
-- Name: message_template_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message_template
    ADD CONSTRAINT message_template_pkey PRIMARY KEY (id);


--
-- TOC entry 898 (OID 556072)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message_template
    ADD CONSTRAINT "$1" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 899 (OID 556076)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message_template
    ADD CONSTRAINT "$2" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 900 (OID 556083)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY saved_criteriaelement
    ADD CONSTRAINT "$1" FOREIGN KEY (id) REFERENCES saved_criterialist(id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 901 (OID 556087)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY saved_criteriaelement
    ADD CONSTRAINT "$2" FOREIGN KEY (field) REFERENCES search_fields(id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 902 (OID 556091)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY saved_criteriaelement
    ADD CONSTRAINT "$3" FOREIGN KEY (operatorid) REFERENCES field_types(id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 486 (OID 556144)
-- Name: help_module_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_module
    ADD CONSTRAINT help_module_pkey PRIMARY KEY (module_id);


--
-- TOC entry 903 (OID 556146)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_module
    ADD CONSTRAINT "$1" FOREIGN KEY (category_id) REFERENCES permission_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 487 (OID 556161)
-- Name: help_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_contents
    ADD CONSTRAINT help_contents_pkey PRIMARY KEY (help_id);


--
-- TOC entry 904 (OID 556163)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_contents
    ADD CONSTRAINT "$1" FOREIGN KEY (category_id) REFERENCES permission_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 905 (OID 556167)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_contents
    ADD CONSTRAINT "$2" FOREIGN KEY (link_module_id) REFERENCES help_module(module_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 906 (OID 556171)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_contents
    ADD CONSTRAINT "$3" FOREIGN KEY (nextcontent) REFERENCES help_contents(help_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 907 (OID 556175)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_contents
    ADD CONSTRAINT "$4" FOREIGN KEY (prevcontent) REFERENCES help_contents(help_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 908 (OID 556179)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_contents
    ADD CONSTRAINT "$5" FOREIGN KEY (upcontent) REFERENCES help_contents(help_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 909 (OID 556183)
-- Name: $6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_contents
    ADD CONSTRAINT "$6" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 910 (OID 556187)
-- Name: $7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_contents
    ADD CONSTRAINT "$7" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 488 (OID 556199)
-- Name: help_tableof_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableof_contents
    ADD CONSTRAINT help_tableof_contents_pkey PRIMARY KEY (content_id);


--
-- TOC entry 911 (OID 556201)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableof_contents
    ADD CONSTRAINT "$1" FOREIGN KEY (firstchild) REFERENCES help_tableof_contents(content_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 912 (OID 556205)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableof_contents
    ADD CONSTRAINT "$2" FOREIGN KEY (nextsibling) REFERENCES help_tableof_contents(content_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 913 (OID 556209)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableof_contents
    ADD CONSTRAINT "$3" FOREIGN KEY (parent) REFERENCES help_tableof_contents(content_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 914 (OID 556213)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableof_contents
    ADD CONSTRAINT "$4" FOREIGN KEY (category_id) REFERENCES permission_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 915 (OID 556217)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableof_contents
    ADD CONSTRAINT "$5" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 916 (OID 556221)
-- Name: $6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableof_contents
    ADD CONSTRAINT "$6" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 489 (OID 556233)
-- Name: help_tableofcontentitem_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableofcontentitem_links
    ADD CONSTRAINT help_tableofcontentitem_links_pkey PRIMARY KEY (link_id);


--
-- TOC entry 917 (OID 556235)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableofcontentitem_links
    ADD CONSTRAINT "$1" FOREIGN KEY (global_link_id) REFERENCES help_tableof_contents(content_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 918 (OID 556239)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableofcontentitem_links
    ADD CONSTRAINT "$2" FOREIGN KEY (linkto_content_id) REFERENCES help_contents(help_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 919 (OID 556243)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableofcontentitem_links
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 920 (OID 556247)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tableofcontentitem_links
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 490 (OID 556262)
-- Name: lookup_help_features_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_help_features
    ADD CONSTRAINT lookup_help_features_pkey PRIMARY KEY (code);


--
-- TOC entry 491 (OID 556276)
-- Name: help_features_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_features
    ADD CONSTRAINT help_features_pkey PRIMARY KEY (feature_id);


--
-- TOC entry 921 (OID 556278)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_features
    ADD CONSTRAINT "$1" FOREIGN KEY (link_help_id) REFERENCES help_contents(help_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 922 (OID 556282)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_features
    ADD CONSTRAINT "$2" FOREIGN KEY (link_feature_id) REFERENCES lookup_help_features(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 923 (OID 556286)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_features
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 924 (OID 556290)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_features
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 925 (OID 556294)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_features
    ADD CONSTRAINT "$5" FOREIGN KEY (completedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 492 (OID 556306)
-- Name: help_related_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_related_links
    ADD CONSTRAINT help_related_links_pkey PRIMARY KEY (relatedlink_id);


--
-- TOC entry 926 (OID 556308)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_related_links
    ADD CONSTRAINT "$1" FOREIGN KEY (owning_module_id) REFERENCES help_module(module_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 927 (OID 556312)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_related_links
    ADD CONSTRAINT "$2" FOREIGN KEY (linkto_content_id) REFERENCES help_contents(help_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 928 (OID 556316)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_related_links
    ADD CONSTRAINT "$3" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 929 (OID 556320)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_related_links
    ADD CONSTRAINT "$4" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 493 (OID 556335)
-- Name: help_faqs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_faqs
    ADD CONSTRAINT help_faqs_pkey PRIMARY KEY (faq_id);


--
-- TOC entry 930 (OID 556337)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_faqs
    ADD CONSTRAINT "$1" FOREIGN KEY (owning_module_id) REFERENCES help_module(module_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 931 (OID 556341)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_faqs
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 932 (OID 556345)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_faqs
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 933 (OID 556349)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_faqs
    ADD CONSTRAINT "$4" FOREIGN KEY (completedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 494 (OID 556364)
-- Name: help_business_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_business_rules
    ADD CONSTRAINT help_business_rules_pkey PRIMARY KEY (rule_id);


--
-- TOC entry 934 (OID 556366)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_business_rules
    ADD CONSTRAINT "$1" FOREIGN KEY (link_help_id) REFERENCES help_contents(help_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 935 (OID 556370)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_business_rules
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 936 (OID 556374)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_business_rules
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 937 (OID 556378)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_business_rules
    ADD CONSTRAINT "$4" FOREIGN KEY (completedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 495 (OID 556393)
-- Name: help_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_notes
    ADD CONSTRAINT help_notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 938 (OID 556395)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_notes
    ADD CONSTRAINT "$1" FOREIGN KEY (link_help_id) REFERENCES help_contents(help_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 939 (OID 556399)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_notes
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 940 (OID 556403)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_notes
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 941 (OID 556407)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_notes
    ADD CONSTRAINT "$4" FOREIGN KEY (completedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 496 (OID 556422)
-- Name: help_tips_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tips
    ADD CONSTRAINT help_tips_pkey PRIMARY KEY (tip_id);


--
-- TOC entry 942 (OID 556424)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tips
    ADD CONSTRAINT "$1" FOREIGN KEY (link_help_id) REFERENCES help_contents(help_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 943 (OID 556428)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tips
    ADD CONSTRAINT "$2" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 944 (OID 556432)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY help_tips
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 497 (OID 556443)
-- Name: sync_client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_client
    ADD CONSTRAINT sync_client_pkey PRIMARY KEY (client_id);


--
-- TOC entry 498 (OID 556451)
-- Name: sync_system_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_system
    ADD CONSTRAINT sync_system_pkey PRIMARY KEY (system_id);


--
-- TOC entry 499 (OID 556465)
-- Name: sync_table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_table
    ADD CONSTRAINT sync_table_pkey PRIMARY KEY (table_id);


--
-- TOC entry 945 (OID 556467)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_table
    ADD CONSTRAINT "$1" FOREIGN KEY (system_id) REFERENCES sync_system(system_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 946 (OID 556474)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_map
    ADD CONSTRAINT "$1" FOREIGN KEY (client_id) REFERENCES sync_client(client_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 947 (OID 556478)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_map
    ADD CONSTRAINT "$2" FOREIGN KEY (table_id) REFERENCES sync_table(table_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 948 (OID 556486)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_conflict_log
    ADD CONSTRAINT "$1" FOREIGN KEY (client_id) REFERENCES sync_client(client_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 949 (OID 556490)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_conflict_log
    ADD CONSTRAINT "$2" FOREIGN KEY (table_id) REFERENCES sync_table(table_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 501 (OID 556500)
-- Name: sync_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_log
    ADD CONSTRAINT sync_log_pkey PRIMARY KEY (log_id);


--
-- TOC entry 950 (OID 556502)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_log
    ADD CONSTRAINT "$1" FOREIGN KEY (system_id) REFERENCES sync_system(system_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 951 (OID 556506)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_log
    ADD CONSTRAINT "$2" FOREIGN KEY (client_id) REFERENCES sync_client(client_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 502 (OID 556518)
-- Name: sync_transaction_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_transaction_log
    ADD CONSTRAINT sync_transaction_log_pkey PRIMARY KEY (transaction_id);


--
-- TOC entry 952 (OID 556520)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sync_transaction_log
    ADD CONSTRAINT "$1" FOREIGN KEY (log_id) REFERENCES sync_log(log_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 503 (OID 556533)
-- Name: process_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY process_log
    ADD CONSTRAINT process_log_pkey PRIMARY KEY (process_id);


--
-- TOC entry 953 (OID 556535)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY process_log
    ADD CONSTRAINT "$1" FOREIGN KEY (system_id) REFERENCES sync_system(system_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 954 (OID 556539)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY process_log
    ADD CONSTRAINT "$2" FOREIGN KEY (client_id) REFERENCES sync_client(client_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 504 (OID 556754)
-- Name: autoguide_make_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_make
    ADD CONSTRAINT autoguide_make_pkey PRIMARY KEY (make_id);


--
-- TOC entry 505 (OID 556763)
-- Name: autoguide_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_model
    ADD CONSTRAINT autoguide_model_pkey PRIMARY KEY (model_id);


--
-- TOC entry 955 (OID 556765)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_model
    ADD CONSTRAINT "$1" FOREIGN KEY (make_id) REFERENCES autoguide_make(make_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 506 (OID 556776)
-- Name: autoguide_vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_vehicle
    ADD CONSTRAINT autoguide_vehicle_pkey PRIMARY KEY (vehicle_id);


--
-- TOC entry 956 (OID 556778)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_vehicle
    ADD CONSTRAINT "$1" FOREIGN KEY (make_id) REFERENCES autoguide_make(make_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 957 (OID 556782)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_vehicle
    ADD CONSTRAINT "$2" FOREIGN KEY (model_id) REFERENCES autoguide_model(model_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 507 (OID 556795)
-- Name: autoguide_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_inventory
    ADD CONSTRAINT autoguide_inventory_pkey PRIMARY KEY (inventory_id);


--
-- TOC entry 958 (OID 556797)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_inventory
    ADD CONSTRAINT "$1" FOREIGN KEY (vehicle_id) REFERENCES autoguide_vehicle(vehicle_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 959 (OID 556801)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_inventory
    ADD CONSTRAINT "$2" FOREIGN KEY (account_id) REFERENCES organization(org_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 508 (OID 556815)
-- Name: autoguide_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_options
    ADD CONSTRAINT autoguide_options_pkey PRIMARY KEY (option_id);


--
-- TOC entry 960 (OID 556819)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_inventory_options
    ADD CONSTRAINT "$1" FOREIGN KEY (inventory_id) REFERENCES autoguide_inventory(inventory_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 510 (OID 556833)
-- Name: autoguide_ad_run_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_ad_run
    ADD CONSTRAINT autoguide_ad_run_pkey PRIMARY KEY (ad_run_id);


--
-- TOC entry 961 (OID 556835)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_ad_run
    ADD CONSTRAINT "$1" FOREIGN KEY (inventory_id) REFERENCES autoguide_inventory(inventory_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 511 (OID 556849)
-- Name: autoguide_ad_run_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autoguide_ad_run_types
    ADD CONSTRAINT autoguide_ad_run_types_pkey PRIMARY KEY (code);


--
-- TOC entry 512 (OID 556892)
-- Name: lookup_revenue_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_revenue_types
    ADD CONSTRAINT lookup_revenue_types_pkey PRIMARY KEY (code);


--
-- TOC entry 513 (OID 556902)
-- Name: lookup_revenuedetail_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_revenuedetail_types
    ADD CONSTRAINT lookup_revenuedetail_types_pkey PRIMARY KEY (code);


--
-- TOC entry 514 (OID 556915)
-- Name: revenue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue
    ADD CONSTRAINT revenue_pkey PRIMARY KEY (id);


--
-- TOC entry 962 (OID 556917)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue
    ADD CONSTRAINT "$1" FOREIGN KEY (org_id) REFERENCES organization(org_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 963 (OID 556921)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue
    ADD CONSTRAINT "$2" FOREIGN KEY ("type") REFERENCES lookup_revenue_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 964 (OID 556925)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue
    ADD CONSTRAINT "$3" FOREIGN KEY ("owner") REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 965 (OID 556929)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue
    ADD CONSTRAINT "$4" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 966 (OID 556933)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue
    ADD CONSTRAINT "$5" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 515 (OID 556945)
-- Name: revenue_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue_detail
    ADD CONSTRAINT revenue_detail_pkey PRIMARY KEY (id);


--
-- TOC entry 967 (OID 556947)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue_detail
    ADD CONSTRAINT "$1" FOREIGN KEY (revenue_id) REFERENCES revenue(id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 968 (OID 556951)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue_detail
    ADD CONSTRAINT "$2" FOREIGN KEY ("type") REFERENCES lookup_revenue_types(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 969 (OID 556955)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue_detail
    ADD CONSTRAINT "$3" FOREIGN KEY ("owner") REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 970 (OID 556959)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue_detail
    ADD CONSTRAINT "$4" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 971 (OID 556963)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revenue_detail
    ADD CONSTRAINT "$5" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 516 (OID 556976)
-- Name: lookup_task_priority_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_task_priority
    ADD CONSTRAINT lookup_task_priority_pkey PRIMARY KEY (code);


--
-- TOC entry 517 (OID 556986)
-- Name: lookup_task_loe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_task_loe
    ADD CONSTRAINT lookup_task_loe_pkey PRIMARY KEY (code);


--
-- TOC entry 518 (OID 556996)
-- Name: lookup_task_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lookup_task_category
    ADD CONSTRAINT lookup_task_category_pkey PRIMARY KEY (code);


--
-- TOC entry 519 (OID 557011)
-- Name: task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_pkey PRIMARY KEY (task_id);


--
-- TOC entry 972 (OID 557013)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT "$1" FOREIGN KEY (enteredby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 973 (OID 557017)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT "$2" FOREIGN KEY (priority) REFERENCES lookup_task_priority(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 974 (OID 557021)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT "$3" FOREIGN KEY (modifiedby) REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 975 (OID 557025)
-- Name: $4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT "$4" FOREIGN KEY (estimatedloetype) REFERENCES lookup_task_loe(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 976 (OID 557029)
-- Name: $5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT "$5" FOREIGN KEY ("owner") REFERENCES "access"(user_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 977 (OID 557033)
-- Name: $6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT "$6" FOREIGN KEY (category_id) REFERENCES lookup_task_category(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 978 (OID 557039)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tasklink_contact
    ADD CONSTRAINT "$1" FOREIGN KEY (task_id) REFERENCES task(task_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 979 (OID 557043)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tasklink_contact
    ADD CONSTRAINT "$2" FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 980 (OID 557049)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tasklink_ticket
    ADD CONSTRAINT "$1" FOREIGN KEY (task_id) REFERENCES task(task_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 981 (OID 557053)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tasklink_ticket
    ADD CONSTRAINT "$2" FOREIGN KEY (ticket_id) REFERENCES ticket(ticketid) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 982 (OID 557059)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tasklink_project
    ADD CONSTRAINT "$1" FOREIGN KEY (task_id) REFERENCES task(task_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 983 (OID 557063)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tasklink_project
    ADD CONSTRAINT "$2" FOREIGN KEY (project_id) REFERENCES projects(project_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 984 (OID 557069)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY taskcategory_project
    ADD CONSTRAINT "$1" FOREIGN KEY (category_id) REFERENCES lookup_task_category(code) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 985 (OID 557073)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY taskcategory_project
    ADD CONSTRAINT "$2" FOREIGN KEY (project_id) REFERENCES projects(project_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 520 (OID 557096)
-- Name: business_process_component_library_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_component_library
    ADD CONSTRAINT business_process_component_library_pkey PRIMARY KEY (component_id);


--
-- TOC entry 521 (OID 557105)
-- Name: business_process_component_result_lookup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_component_result_lookup
    ADD CONSTRAINT business_process_component_result_lookup_pkey PRIMARY KEY (result_id);


--
-- TOC entry 986 (OID 557107)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_component_result_lookup
    ADD CONSTRAINT "$1" FOREIGN KEY (component_id) REFERENCES business_process_component_library(component_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 522 (OID 557120)
-- Name: business_process_parameter_library_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_parameter_library
    ADD CONSTRAINT business_process_parameter_library_pkey PRIMARY KEY (parameter_id);


--
-- TOC entry 523 (OID 557132)
-- Name: business_process_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process
    ADD CONSTRAINT business_process_pkey PRIMARY KEY (process_id);


--
-- TOC entry 524 (OID 557134)
-- Name: business_process_process_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process
    ADD CONSTRAINT business_process_process_name_key UNIQUE (process_name);


--
-- TOC entry 987 (OID 557136)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process
    ADD CONSTRAINT "$1" FOREIGN KEY (link_module_id) REFERENCES permission_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 525 (OID 557146)
-- Name: business_process_component_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_component
    ADD CONSTRAINT business_process_component_pkey PRIMARY KEY (id);


--
-- TOC entry 988 (OID 557148)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_component
    ADD CONSTRAINT "$1" FOREIGN KEY (process_id) REFERENCES business_process(process_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 989 (OID 557152)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_component
    ADD CONSTRAINT "$2" FOREIGN KEY (component_id) REFERENCES business_process_component_library(component_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 990 (OID 557156)
-- Name: $3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_component
    ADD CONSTRAINT "$3" FOREIGN KEY (parent_id) REFERENCES business_process_component(id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 526 (OID 557169)
-- Name: business_process_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_parameter
    ADD CONSTRAINT business_process_parameter_pkey PRIMARY KEY (id);


--
-- TOC entry 991 (OID 557171)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_parameter
    ADD CONSTRAINT "$1" FOREIGN KEY (process_id) REFERENCES business_process(process_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 527 (OID 557184)
-- Name: business_process_component_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_component_parameter
    ADD CONSTRAINT business_process_component_parameter_pkey PRIMARY KEY (id);


--
-- TOC entry 992 (OID 557186)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_component_parameter
    ADD CONSTRAINT "$1" FOREIGN KEY (component_id) REFERENCES business_process_component(id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 993 (OID 557190)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_component_parameter
    ADD CONSTRAINT "$2" FOREIGN KEY (parameter_id) REFERENCES business_process_parameter_library(parameter_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 528 (OID 557212)
-- Name: business_process_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_events
    ADD CONSTRAINT business_process_events_pkey PRIMARY KEY (event_id);


--
-- TOC entry 994 (OID 557214)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_events
    ADD CONSTRAINT "$1" FOREIGN KEY (process_id) REFERENCES business_process(process_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 529 (OID 557220)
-- Name: business_process_log_process_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_log
    ADD CONSTRAINT business_process_log_process_name_key UNIQUE (process_name);


--
-- TOC entry 530 (OID 557228)
-- Name: business_process_hook_library_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_hook_library
    ADD CONSTRAINT business_process_hook_library_pkey PRIMARY KEY (hook_id);


--
-- TOC entry 995 (OID 557230)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_hook_library
    ADD CONSTRAINT "$1" FOREIGN KEY (link_module_id) REFERENCES permission_category(category_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 531 (OID 557240)
-- Name: business_process_hook_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_hook_triggers
    ADD CONSTRAINT business_process_hook_triggers_pkey PRIMARY KEY (trigger_id);


--
-- TOC entry 996 (OID 557242)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_hook_triggers
    ADD CONSTRAINT "$1" FOREIGN KEY (hook_id) REFERENCES business_process_hook_library(hook_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 532 (OID 557252)
-- Name: business_process_hook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_hook
    ADD CONSTRAINT business_process_hook_pkey PRIMARY KEY (id);


--
-- TOC entry 997 (OID 557254)
-- Name: $1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_hook
    ADD CONSTRAINT "$1" FOREIGN KEY (trigger_id) REFERENCES business_process_hook_triggers(trigger_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 998 (OID 557258)
-- Name: $2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY business_process_hook
    ADD CONSTRAINT "$2" FOREIGN KEY (process_id) REFERENCES business_process(process_id) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
-- TOC entry 3 (OID 553854)
-- Name: access_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('access_user_id_seq', 0, true);


--
-- TOC entry 272 (OID 553876)
-- Name: lookup_industry_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_industry_code_seq', 20, true);


--
-- TOC entry 273 (OID 553886)
-- Name: access_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('access_log_id_seq', 1, false);


--
-- TOC entry 274 (OID 553898)
-- Name: usage_log_usage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('usage_log_usage_id_seq', 1, false);


--
-- TOC entry 275 (OID 553906)
-- Name: lookup_contact_types_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_contact_types_code_seq', 3, true);


--
-- TOC entry 276 (OID 553921)
-- Name: lookup_account_types_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_account_types_code_seq', 6, true);


--
-- TOC entry 277 (OID 553935)
-- Name: lookup_department_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_department_code_seq', 7, true);


--
-- TOC entry 5 (OID 553945)
-- Name: lookup_orgaddress_type_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_orgaddress_type_code_seq', 4, true);


--
-- TOC entry 278 (OID 553955)
-- Name: lookup_orgemail_types_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_orgemail_types_code_seq', 2, true);


--
-- TOC entry 279 (OID 553965)
-- Name: lookup_orgphone_types_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_orgphone_types_code_seq', 2, true);


--
-- TOC entry 7 (OID 553975)
-- Name: lookup_instantmessenge_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_instantmessenge_code_seq', 1, false);


--
-- TOC entry 9 (OID 553985)
-- Name: lookup_employment_type_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_employment_type_code_seq', 1, false);


--
-- TOC entry 280 (OID 553995)
-- Name: lookup_locale_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_locale_code_seq', 1, false);


--
-- TOC entry 11 (OID 554005)
-- Name: lookup_contactaddress__code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_contactaddress__code_seq', 3, true);


--
-- TOC entry 13 (OID 554015)
-- Name: lookup_contactemail_ty_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_contactemail_ty_code_seq', 3, true);


--
-- TOC entry 15 (OID 554025)
-- Name: lookup_contactphone_ty_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_contactphone_ty_code_seq', 9, true);


--
-- TOC entry 281 (OID 554035)
-- Name: lookup_access_types_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_access_types_code_seq', 8, true);


--
-- TOC entry 17 (OID 554044)
-- Name: organization_org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('organization_org_id_seq', 0, true);


--
-- TOC entry 282 (OID 554075)
-- Name: contact_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('contact_contact_id_seq', 1, false);


--
-- TOC entry 283 (OID 554132)
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('role_role_id_seq', 9, true);


--
-- TOC entry 19 (OID 554151)
-- Name: permission_cate_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('permission_cate_category_id_seq', 15, true);


--
-- TOC entry 284 (OID 554168)
-- Name: permission_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('permission_permission_id_seq', 74, true);


--
-- TOC entry 285 (OID 554188)
-- Name: role_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('role_permission_id_seq', 411, true);


--
-- TOC entry 286 (OID 554207)
-- Name: lookup_stage_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_stage_code_seq', 9, true);


--
-- TOC entry 21 (OID 554217)
-- Name: lookup_delivery_option_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_delivery_option_code_seq', 6, true);


--
-- TOC entry 287 (OID 554227)
-- Name: news_rec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('news_rec_id_seq', 1, false);


--
-- TOC entry 23 (OID 554242)
-- Name: organization_add_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('organization_add_address_id_seq', 1, false);


--
-- TOC entry 25 (OID 554267)
-- Name: organization__emailaddress__seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('organization__emailaddress__seq', 1, false);


--
-- TOC entry 27 (OID 554292)
-- Name: organization_phone_phone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('organization_phone_phone_id_seq', 1, false);


--
-- TOC entry 288 (OID 554317)
-- Name: contact_address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('contact_address_address_id_seq', 1, false);


--
-- TOC entry 29 (OID 554342)
-- Name: contact_email_emailaddress__seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('contact_email_emailaddress__seq', 1, false);


--
-- TOC entry 289 (OID 554367)
-- Name: contact_phone_phone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('contact_phone_phone_id_seq', 1, false);


--
-- TOC entry 31 (OID 554392)
-- Name: notification_notification_i_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('notification_notification_i_seq', 1, false);


--
-- TOC entry 290 (OID 554404)
-- Name: cfsinbox_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('cfsinbox_message_id_seq', 1, false);


--
-- TOC entry 291 (OID 554467)
-- Name: lookup_lists_lookup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_lists_lookup_id_seq', 13, true);


--
-- TOC entry 292 (OID 554483)
-- Name: viewpoint_viewpoint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('viewpoint_viewpoint_id_seq', 1, false);


--
-- TOC entry 33 (OID 554509)
-- Name: viewpoint_per_vp_permission_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('viewpoint_per_vp_permission_seq', 1, false);


--
-- TOC entry 293 (OID 554528)
-- Name: report_report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('report_report_id_seq', 19, true);


--
-- TOC entry 294 (OID 554559)
-- Name: report_criteria_criteria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('report_criteria_criteria_id_seq', 1, false);


--
-- TOC entry 295 (OID 554585)
-- Name: report_criteria_parameter_parameter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('report_criteria_parameter_parameter_id_seq', 1, false);


--
-- TOC entry 296 (OID 554599)
-- Name: report_queue_queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('report_queue_queue_id_seq', 1, false);


--
-- TOC entry 297 (OID 554618)
-- Name: report_queue_criteria_criteria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('report_queue_criteria_criteria_id_seq', 1, false);


--
-- TOC entry 35 (OID 554632)
-- Name: action_list_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('action_list_code_seq', 1, false);


--
-- TOC entry 37 (OID 554654)
-- Name: action_item_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('action_item_code_seq', 1, false);


--
-- TOC entry 39 (OID 554676)
-- Name: action_item_log_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('action_item_log_code_seq', 1, false);


--
-- TOC entry 298 (OID 554698)
-- Name: database_version_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('database_version_version_id_seq', 1, true);


--
-- TOC entry 299 (OID 554823)
-- Name: lookup_call_types_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_call_types_code_seq', 3, true);


--
-- TOC entry 41 (OID 554833)
-- Name: lookup_opportunity_typ_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_opportunity_typ_code_seq', 4, true);


--
-- TOC entry 300 (OID 554843)
-- Name: opportunity_header_opp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('opportunity_header_opp_id_seq', 1, false);


--
-- TOC entry 301 (OID 554862)
-- Name: opportunity_component_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('opportunity_component_id_seq', 1, false);


--
-- TOC entry 302 (OID 554910)
-- Name: call_log_call_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('call_log_call_id_seq', 1, false);


--
-- TOC entry 303 (OID 554963)
-- Name: ticket_level_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('ticket_level_code_seq', 5, true);


--
-- TOC entry 304 (OID 554975)
-- Name: ticket_severity_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('ticket_severity_code_seq', 3, true);


--
-- TOC entry 305 (OID 554991)
-- Name: lookup_ticketsource_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_ticketsource_code_seq', 4, true);


--
-- TOC entry 306 (OID 555003)
-- Name: ticket_priority_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('ticket_priority_code_seq', 3, true);


--
-- TOC entry 307 (OID 555019)
-- Name: ticket_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('ticket_category_id_seq', 5, true);


--
-- TOC entry 308 (OID 555034)
-- Name: ticket_category_draft_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('ticket_category_draft_id_seq', 1, false);


--
-- TOC entry 309 (OID 555050)
-- Name: ticket_ticketid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('ticket_ticketid_seq', 1, false);


--
-- TOC entry 310 (OID 555104)
-- Name: ticketlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('ticketlog_id_seq', 1, false);


--
-- TOC entry 43 (OID 555164)
-- Name: module_field_categorylin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('module_field_categorylin_id_seq', 2, true);


--
-- TOC entry 45 (OID 555182)
-- Name: custom_field_ca_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('custom_field_ca_category_id_seq', 1, false);


--
-- TOC entry 47 (OID 555204)
-- Name: custom_field_group_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('custom_field_group_group_id_seq', 1, false);


--
-- TOC entry 311 (OID 555223)
-- Name: custom_field_info_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('custom_field_info_field_id_seq', 1, false);


--
-- TOC entry 312 (OID 555244)
-- Name: custom_field_lookup_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('custom_field_lookup_code_seq', 1, false);


--
-- TOC entry 49 (OID 555260)
-- Name: custom_field_reco_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('custom_field_reco_record_id_seq', 1, false);


--
-- TOC entry 51 (OID 555298)
-- Name: lookup_project_activit_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_project_activit_code_seq', 10, true);


--
-- TOC entry 53 (OID 555310)
-- Name: lookup_project_priorit_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_project_priorit_code_seq', 3, true);


--
-- TOC entry 313 (OID 555321)
-- Name: lookup_project_issues_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_project_issues_code_seq', 15, true);


--
-- TOC entry 314 (OID 555332)
-- Name: lookup_project_status_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_project_status_code_seq', 6, true);


--
-- TOC entry 315 (OID 555343)
-- Name: lookup_project_loe_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_project_loe_code_seq', 5, true);


--
-- TOC entry 316 (OID 555355)
-- Name: projects_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('projects_project_id_seq', 1, false);


--
-- TOC entry 55 (OID 555378)
-- Name: project_requi_requirement_i_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('project_requi_requirement_i_seq', 1, false);


--
-- TOC entry 57 (OID 555418)
-- Name: project_assig_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('project_assig_assignment_id_seq', 1, false);


--
-- TOC entry 59 (OID 555475)
-- Name: project_assignmen_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('project_assignmen_status_id_seq', 1, false);


--
-- TOC entry 317 (OID 555494)
-- Name: project_issues_issue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('project_issues_issue_id_seq', 1, false);


--
-- TOC entry 61 (OID 555526)
-- Name: project_issue_repl_reply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('project_issue_repl_reply_id_seq', 1, false);


--
-- TOC entry 318 (OID 555551)
-- Name: project_folders_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('project_folders_folder_id_seq', 1, false);


--
-- TOC entry 319 (OID 555561)
-- Name: project_files_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('project_files_item_id_seq', 1, false);


--
-- TOC entry 320 (OID 555684)
-- Name: saved_criterialist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('saved_criterialist_id_seq', 1, false);


--
-- TOC entry 321 (OID 555707)
-- Name: campaign_campaign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('campaign_campaign_id_seq', 1, false);


--
-- TOC entry 322 (OID 555737)
-- Name: campaign_run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('campaign_run_id_seq', 1, false);


--
-- TOC entry 323 (OID 555754)
-- Name: excluded_recipient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('excluded_recipient_id_seq', 1, false);


--
-- TOC entry 324 (OID 555779)
-- Name: active_campaign_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('active_campaign_groups_id_seq', 1, false);


--
-- TOC entry 325 (OID 555793)
-- Name: scheduled_recipient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('scheduled_recipient_id_seq', 1, false);


--
-- TOC entry 326 (OID 555812)
-- Name: lookup_survey_types_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_survey_types_code_seq', 4, true);


--
-- TOC entry 327 (OID 555822)
-- Name: survey_survey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('survey_survey_id_seq', 1, false);


--
-- TOC entry 63 (OID 555856)
-- Name: survey_question_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('survey_question_question_id_seq', 1, false);


--
-- TOC entry 328 (OID 555873)
-- Name: survey_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('survey_items_item_id_seq', 1, false);


--
-- TOC entry 65 (OID 555885)
-- Name: active_survey_active_survey_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('active_survey_active_survey_seq', 1, false);


--
-- TOC entry 67 (OID 555915)
-- Name: active_survey_q_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('active_survey_q_question_id_seq', 1, false);


--
-- TOC entry 69 (OID 555940)
-- Name: active_survey_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('active_survey_items_item_id_seq', 1, false);


--
-- TOC entry 71 (OID 555952)
-- Name: active_survey_r_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('active_survey_r_response_id_seq', 1, false);


--
-- TOC entry 73 (OID 555965)
-- Name: active_survey_ans_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('active_survey_ans_answer_id_seq', 1, false);


--
-- TOC entry 75 (OID 555984)
-- Name: active_survey_answer_ite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('active_survey_answer_ite_id_seq', 1, false);


--
-- TOC entry 77 (OID 556002)
-- Name: active_survey_answer_avg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('active_survey_answer_avg_id_seq', 1, false);


--
-- TOC entry 329 (OID 556018)
-- Name: field_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('field_types_id_seq', 18, true);


--
-- TOC entry 330 (OID 556027)
-- Name: search_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('search_fields_id_seq', 11, true);


--
-- TOC entry 331 (OID 556037)
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('message_id_seq', 1, false);


--
-- TOC entry 332 (OID 556062)
-- Name: message_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('message_template_id_seq', 1, false);


--
-- TOC entry 333 (OID 556136)
-- Name: help_module_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('help_module_module_id_seq', 1, false);


--
-- TOC entry 334 (OID 556150)
-- Name: help_contents_help_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('help_contents_help_id_seq', 1, false);


--
-- TOC entry 335 (OID 556191)
-- Name: help_tableof_contents_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('help_tableof_contents_content_id_seq', 1, false);


--
-- TOC entry 336 (OID 556225)
-- Name: help_tableofcontentitem_links_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('help_tableofcontentitem_links_link_id_seq', 1, false);


--
-- TOC entry 337 (OID 556251)
-- Name: lookup_help_features_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_help_features_code_seq', 1, false);


--
-- TOC entry 338 (OID 556264)
-- Name: help_features_feature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('help_features_feature_id_seq', 1, false);


--
-- TOC entry 339 (OID 556298)
-- Name: help_related_links_relatedlink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('help_related_links_relatedlink_id_seq', 1, false);


--
-- TOC entry 340 (OID 556324)
-- Name: help_faqs_faq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('help_faqs_faq_id_seq', 1, false);


--
-- TOC entry 341 (OID 556353)
-- Name: help_business_rules_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('help_business_rules_rule_id_seq', 1, false);


--
-- TOC entry 342 (OID 556382)
-- Name: help_notes_note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('help_notes_note_id_seq', 1, false);


--
-- TOC entry 343 (OID 556411)
-- Name: help_tips_tip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('help_tips_tip_id_seq', 1, false);


--
-- TOC entry 344 (OID 556436)
-- Name: sync_client_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('sync_client_client_id_seq', 1, false);


--
-- TOC entry 345 (OID 556445)
-- Name: sync_system_system_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('sync_system_system_id_seq', 5, true);


--
-- TOC entry 346 (OID 556453)
-- Name: sync_table_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('sync_table_table_id_seq', 199, true);


--
-- TOC entry 347 (OID 556494)
-- Name: sync_log_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('sync_log_log_id_seq', 1, false);


--
-- TOC entry 79 (OID 556510)
-- Name: sync_transact_transaction_i_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('sync_transact_transaction_i_seq', 1, false);


--
-- TOC entry 348 (OID 556524)
-- Name: process_log_process_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('process_log_process_id_seq', 1, false);


--
-- TOC entry 349 (OID 556747)
-- Name: autoguide_make_make_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('autoguide_make_make_id_seq', 1, false);


--
-- TOC entry 350 (OID 556756)
-- Name: autoguide_model_model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('autoguide_model_model_id_seq', 1, false);


--
-- TOC entry 81 (OID 556769)
-- Name: autoguide_vehicl_vehicle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('autoguide_vehicl_vehicle_id_seq', 1, false);


--
-- TOC entry 83 (OID 556786)
-- Name: autoguide_inve_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('autoguide_inve_inventory_id_seq', 1, false);


--
-- TOC entry 85 (OID 556805)
-- Name: autoguide_options_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('autoguide_options_option_id_seq', 30, true);


--
-- TOC entry 351 (OID 556824)
-- Name: autoguide_ad_run_ad_run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('autoguide_ad_run_ad_run_id_seq', 1, false);


--
-- TOC entry 87 (OID 556839)
-- Name: autoguide_ad_run_types_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('autoguide_ad_run_types_code_seq', 3, true);


--
-- TOC entry 352 (OID 556884)
-- Name: lookup_revenue_types_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_revenue_types_code_seq', 1, true);


--
-- TOC entry 89 (OID 556894)
-- Name: lookup_revenuedetail_t_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_revenuedetail_t_code_seq', 1, false);


--
-- TOC entry 353 (OID 556904)
-- Name: revenue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('revenue_id_seq', 1, false);


--
-- TOC entry 354 (OID 556937)
-- Name: revenue_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('revenue_detail_id_seq', 1, false);


--
-- TOC entry 355 (OID 556968)
-- Name: lookup_task_priority_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_task_priority_code_seq', 5, true);


--
-- TOC entry 356 (OID 556978)
-- Name: lookup_task_loe_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_task_loe_code_seq', 5, true);


--
-- TOC entry 357 (OID 556988)
-- Name: lookup_task_category_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('lookup_task_category_code_seq', 1, false);


--
-- TOC entry 358 (OID 556998)
-- Name: task_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('task_task_id_seq', 1, false);


--
-- TOC entry 91 (OID 557087)
-- Name: business_process_com_lb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_com_lb_id_seq', 7, true);


--
-- TOC entry 93 (OID 557098)
-- Name: business_process_comp_re_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_comp_re_id_seq', 3, true);


--
-- TOC entry 95 (OID 557111)
-- Name: business_process_pa_lib_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_pa_lib_id_seq', 23, true);


--
-- TOC entry 359 (OID 557122)
-- Name: business_process_process_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_process_id_seq', 2, true);


--
-- TOC entry 97 (OID 557140)
-- Name: business_process_compone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_compone_id_seq', 8, true);


--
-- TOC entry 99 (OID 557160)
-- Name: business_process_param_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_param_id_seq', 1, false);


--
-- TOC entry 101 (OID 557175)
-- Name: business_process_comp_pa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_comp_pa_id_seq', 23, true);


--
-- TOC entry 103 (OID 557194)
-- Name: business_process_e_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_e_event_id_seq', 1, false);


--
-- TOC entry 105 (OID 557222)
-- Name: business_process_hl_hook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_hl_hook_id_seq', 1, true);


--
-- TOC entry 107 (OID 557234)
-- Name: business_process_ho_trig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_ho_trig_id_seq', 2, true);


--
-- TOC entry 109 (OID 557246)
-- Name: business_process_ho_hook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval ('business_process_ho_hook_id_seq', 2, true);

COMMIT;
