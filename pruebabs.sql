-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

-- DROP SEQUENCE public.category_id_seq;

CREATE SEQUENCE public.category_id_seq
	MINVALUE 0
	NO MAXVALUE
	START 0
	NO CYCLE;
-- DROP SEQUENCE public.product_id_seq;

CREATE SEQUENCE public.product_id_seq
	MINVALUE 0
	NO MAXVALUE
	START 0
	NO CYCLE;
-- DROP SEQUENCE public.purchase_id_seq;

CREATE SEQUENCE public.purchase_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.riwi_category_id_category_seq;

CREATE SEQUENCE public.riwi_category_id_category_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.riwi_products_id_product_seq;

CREATE SEQUENCE public.riwi_products_id_product_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.suppplier_id_seq;

CREATE SEQUENCE public.suppplier_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.warehouse_id_seq;

CREATE SEQUENCE public.warehouse_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.riwi_category definition

-- Drop table

-- DROP TABLE public.riwi_category;

CREATE TABLE public.riwi_category (
	id_category serial4 NOT NULL,
	name_category varchar(50) NOT NULL,
	CONSTRAINT riwi_category_pkey PRIMARY KEY (id_category)
);


-- public.riwi_warehouse definition

-- Drop table

-- DROP TABLE public.riwi_warehouse;

CREATE TABLE public.riwi_warehouse (
	riwi_namewarehouse varchar NOT NULL,
	riwi_warehousecity varchar NOT NULL,
	id int4 DEFAULT nextval('warehouse_id_seq'::regclass) NOT NULL,
	CONSTRAINT warehouse_pk PRIMARY KEY (id)
);


-- public.riwi_products definition

-- Drop table

-- DROP TABLE public.riwi_products;

CREATE TABLE public.riwi_products (
	id_product serial4 NOT NULL,
	product_name varchar(100) NOT NULL,
	category_id int4 NOT NULL,
	unitprice int4 NULL,
	CONSTRAINT riwi_products_pkey PRIMARY KEY (id_product),
	CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES public.riwi_category(id_category) ON DELETE CASCADE
);


-- public.riwi_suppplier definition

-- Drop table

-- DROP TABLE public.riwi_suppplier;

CREATE TABLE public.riwi_suppplier (
	riwi_suppliername varchar NOT NULL,
	id int4 DEFAULT nextval('suppplier_id_seq'::regclass) NOT NULL,
	riwi_suppliercity varchar NOT NULL,
	warehouse_id int4 NULL,
	CONSTRAINT suppplier_pk PRIMARY KEY (id),
	CONSTRAINT riwi_suppplier_riwi_warehouse_fk FOREIGN KEY (warehouse_id) REFERENCES public.riwi_warehouse(id)
);


-- public.riwi_purchase definition

-- Drop table

-- DROP TABLE public.riwi_purchase;

CREATE TABLE public.riwi_purchase (
	riwi_purchaseorder varchar NOT NULL,
	id int4 DEFAULT nextval('purchase_id_seq'::regclass) NOT NULL,
	riwi_movementtype varchar NOT NULL,
	riwi_movementdate varchar NOT NULL,
	product_id int4 NULL,
	supplier_id int4 NULL,
	CONSTRAINT purchase_pk PRIMARY KEY (id),
	CONSTRAINT riwi_purchase_riwi_products_fk FOREIGN KEY (product_id) REFERENCES public.riwi_products(id_product),
	CONSTRAINT riwi_purchase_riwi_suppplier_fk FOREIGN KEY (supplier_id) REFERENCES public.riwi_suppplier(id)
);