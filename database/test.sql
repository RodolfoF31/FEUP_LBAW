--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6 (Ubuntu 16.6-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.4

-- Started on 2024-12-14 17:52:03 UTC

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

ALTER TABLE ONLY temp.wishlist_product DROP CONSTRAINT wishlist_product_id_wishlist_fkey;
ALTER TABLE ONLY temp.wishlist_product DROP CONSTRAINT wishlist_product_id_product_fkey;
ALTER TABLE ONLY temp.wishlist DROP CONSTRAINT wishlist_id_authenticated_user_fkey;
ALTER TABLE ONLY temp."shoppingCart" DROP CONSTRAINT "shoppingCart_id_authenticated_user_fkey";
ALTER TABLE ONLY temp."shoppingCartProduct" DROP CONSTRAINT "shoppingCartProduct_id_shopping_cart_fkey";
ALTER TABLE ONLY temp."shoppingCartProduct" DROP CONSTRAINT "shoppingCartProduct_id_product_fkey";
ALTER TABLE ONLY temp.review_product DROP CONSTRAINT review_product_id_product_fkey;
ALTER TABLE ONLY temp.review_product DROP CONSTRAINT review_product_id_authenticated_user_fkey;
ALTER TABLE ONLY temp.review_author DROP CONSTRAINT review_author_id_author_fkey;
ALTER TABLE ONLY temp.review_author DROP CONSTRAINT review_author_id_authenticated_user_fkey;
ALTER TABLE ONLY temp.product DROP CONSTRAINT product_id_category_fkey;
ALTER TABLE ONLY temp.product DROP CONSTRAINT product_id_author_fkey;
ALTER TABLE ONLY temp."productWishlistAvailableNotification" DROP CONSTRAINT "productWishlistAvailableNotification_id_wishlist_fkey";
ALTER TABLE ONLY temp."productWishlistAvailableNotification" DROP CONSTRAINT "productWishlistAvailableNotification_id_notification_fkey";
ALTER TABLE ONLY temp."productOnCartPriceChangeNotification" DROP CONSTRAINT "productOnCartPriceChangeNotification_id_shopping_cart_fkey";
ALTER TABLE ONLY temp."productOnCartPriceChangeNotification" DROP CONSTRAINT "productOnCartPriceChangeNotification_id_notification_fkey";
ALTER TABLE ONLY temp.payment_info DROP CONSTRAINT payment_info_id_authenticated_user_fkey;
ALTER TABLE ONLY temp.orders DROP CONSTRAINT order_id_authenticated_user_fkey;
ALTER TABLE ONLY temp.order_product DROP CONSTRAINT "orderProduct_id_product_fkey";
ALTER TABLE ONLY temp.order_product DROP CONSTRAINT "orderProduct_id_order_fkey";
ALTER TABLE ONLY temp."orderPlacedNotification" DROP CONSTRAINT "orderPlacedNotification_id_order_fkey";
ALTER TABLE ONLY temp."orderPlacedNotification" DROP CONSTRAINT "orderPlacedNotification_id_notification_fkey";
ALTER TABLE ONLY temp.notification DROP CONSTRAINT notification_id_authenticated_user_fkey;
ALTER TABLE ONLY temp."changeOrderStatusNotification" DROP CONSTRAINT "changeOrderStatusNotification_id_order_fkey";
ALTER TABLE ONLY temp."changeOrderStatusNotification" DROP CONSTRAINT "changeOrderStatusNotification_id_notification_fkey";
ALTER TABLE ONLY temp.authenticated_user DROP CONSTRAINT authenticated_user_id_fkey;
ALTER TABLE ONLY temp.admin DROP CONSTRAINT admin_id_fkey;
DROP TRIGGER remove_from_wishlist_after_order ON temp.order_product;
DROP TRIGGER reduce_stock_after_order ON temp.order_product;
DROP TRIGGER product_stock_update_trigger ON temp.product;
DROP TRIGGER product_price_update_trigger ON temp.product;
DROP TRIGGER prevent_duplicate_wishlist_items ON temp.wishlist_product;
DROP TRIGGER order_status_update_trigger ON temp.orders;
DROP TRIGGER order_placed_notification_trigger ON temp.orders;
DROP TRIGGER limit_one_review_per_product ON temp.review_product;
DROP TRIGGER create_wishlist_for_new_user_trigger ON temp.authenticated_user;
DROP TRIGGER create_payment_info_after_user_registration ON temp.authenticated_user;
DROP TRIGGER check_product_stock_in_cart_trigger ON temp."shoppingCartProduct";
DROP TRIGGER check_product_purchase ON temp.review_product;
DROP INDEX temp.idx_product_search_vector;
ALTER TABLE ONLY temp.wishlist_product DROP CONSTRAINT wishlist_product_pkey;
ALTER TABLE ONLY temp.wishlist DROP CONSTRAINT wishlist_pkey;
ALTER TABLE ONLY temp.wishlist DROP CONSTRAINT wishlist_id_authenticated_user_key;
ALTER TABLE ONLY temp.users DROP CONSTRAINT users_username_key;
ALTER TABLE ONLY temp.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY temp.users DROP CONSTRAINT users_email_key;
ALTER TABLE ONLY temp."shoppingCart" DROP CONSTRAINT "shoppingCart_pkey";
ALTER TABLE ONLY temp."shoppingCart" DROP CONSTRAINT "shoppingCart_id_authenticated_user_key";
ALTER TABLE ONLY temp."shoppingCartProduct" DROP CONSTRAINT "shoppingCartProduct_pkey";
ALTER TABLE ONLY temp.review_product DROP CONSTRAINT review_product_pkey;
ALTER TABLE ONLY temp.review_author DROP CONSTRAINT review_author_pkey;
ALTER TABLE ONLY temp.product DROP CONSTRAINT product_pkey;
ALTER TABLE ONLY temp."productWishlistAvailableNotification" DROP CONSTRAINT "productWishlistAvailableNotification_pkey";
ALTER TABLE ONLY temp."productOnCartPriceChange" DROP CONSTRAINT "productOnCartPriceChange_pkey";
ALTER TABLE ONLY temp."productOnCartPriceChangeNotification" DROP CONSTRAINT "productOnCartPriceChangeNotification_pkey";
ALTER TABLE ONLY temp.payment_info DROP CONSTRAINT payment_info_pkey;
ALTER TABLE ONLY temp.payment_info DROP CONSTRAINT payment_info_nif_key;
ALTER TABLE ONLY temp.payment_info DROP CONSTRAINT payment_info_id_authenticated_user_key;
ALTER TABLE ONLY temp.payment_info DROP CONSTRAINT payment_info_cardnumber_key;
ALTER TABLE ONLY temp.password_resets DROP CONSTRAINT password_resets_pkey;
ALTER TABLE ONLY temp.orders DROP CONSTRAINT order_pkey;
ALTER TABLE ONLY temp.order_product DROP CONSTRAINT "orderProduct_pkey";
ALTER TABLE ONLY temp."orderPlacedNotification" DROP CONSTRAINT "orderPlacedNotification_pkey";
ALTER TABLE ONLY temp.notification DROP CONSTRAINT notification_pkey;
ALTER TABLE ONLY temp."changeOrderStatusNotification" DROP CONSTRAINT "changeOrderStatusNotification_pkey";
ALTER TABLE ONLY temp.category DROP CONSTRAINT category_pkey;
ALTER TABLE ONLY temp.category DROP CONSTRAINT category_categoryname_key;
ALTER TABLE ONLY temp.author DROP CONSTRAINT author_pkey;
ALTER TABLE ONLY temp.authenticated_user DROP CONSTRAINT authenticated_user_pkey;
ALTER TABLE ONLY temp.admin DROP CONSTRAINT admin_pkey;
ALTER TABLE temp.wishlist_product ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.wishlist ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp."shoppingCartProduct" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp."shoppingCart" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.review_product ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.review_author ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp."productWishlistAvailableNotification" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp."productOnCartPriceChangeNotification" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp."productOnCartPriceChange" ALTER COLUMN id_notification DROP DEFAULT;
ALTER TABLE temp."productOnCartPriceChange" ALTER COLUMN id_order DROP DEFAULT;
ALTER TABLE temp."productOnCartPriceChange" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.product ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.payment_info ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.orders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.order_product ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp."orderPlacedNotification" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.notification ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp."changeOrderStatusNotification" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.category ALTER COLUMN id DROP DEFAULT;
ALTER TABLE temp.author ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE temp.wishlist_product_id_seq;
DROP TABLE temp.wishlist_product;
DROP SEQUENCE temp.wishlist_id_seq;
DROP TABLE temp.wishlist;
DROP SEQUENCE temp.users_id_seq;
DROP TABLE temp.users;
DROP SEQUENCE temp."shoppingCart_id_seq";
DROP SEQUENCE temp."shoppingCartProduct_id_seq";
DROP TABLE temp."shoppingCartProduct";
DROP TABLE temp."shoppingCart";
DROP SEQUENCE temp.review_product_id_seq;
DROP TABLE temp.review_product;
DROP SEQUENCE temp.review_author_id_seq;
DROP TABLE temp.review_author;
DROP SEQUENCE temp.product_id_seq;
DROP SEQUENCE temp."productWishlistAvailableNotification_id_seq";
DROP TABLE temp."productWishlistAvailableNotification";
DROP SEQUENCE temp."productOnCartPriceChange_id_seq";
DROP SEQUENCE temp."productOnCartPriceChange_id_order_seq";
DROP SEQUENCE temp."productOnCartPriceChange_id_notification_seq";
DROP SEQUENCE temp."productOnCartPriceChangeNotification_id_seq";
DROP TABLE temp."productOnCartPriceChangeNotification";
DROP TABLE temp."productOnCartPriceChange";
DROP TABLE temp.product;
DROP SEQUENCE temp.payment_info_id_seq;
DROP TABLE temp.payment_info;
DROP TABLE temp.password_resets;
DROP SEQUENCE temp.order_id_seq;
DROP TABLE temp.orders;
DROP SEQUENCE temp."orderProduct_id_seq";
DROP TABLE temp.order_product;
DROP SEQUENCE temp."orderPlacedNotification_id_seq";
DROP TABLE temp."orderPlacedNotification";
DROP SEQUENCE temp.notification_id_seq;
DROP TABLE temp.notification;
DROP SEQUENCE temp."changeOrderStatusNotification_id_seq";
DROP TABLE temp."changeOrderStatusNotification";
DROP SEQUENCE temp.category_id_seq;
DROP TABLE temp.category;
DROP SEQUENCE temp.author_id_seq;
DROP TABLE temp.author;
DROP TABLE temp.authenticated_user;
DROP TABLE temp.admin;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 449 (class 1259 OID 1637543)
-- Name: admin; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.admin (
    id bigint NOT NULL
);


ALTER TABLE temp.admin OWNER TO temp;

--
-- TOC entry 454 (class 1259 OID 1637572)
-- Name: authenticated_user; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.authenticated_user (
    id bigint NOT NULL
);


ALTER TABLE temp.authenticated_user OWNER TO temp;

--
-- TOC entry 453 (class 1259 OID 1637563)
-- Name: author; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.author (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    biography text NOT NULL,
    rating integer,
    image text,
    CONSTRAINT author_rating_check CHECK (((rating >= 0) AND (rating <= 5)))
);


ALTER TABLE temp.author OWNER TO temp;

--
-- TOC entry 452 (class 1259 OID 1637562)
-- Name: author_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.author_id_seq OWNER TO temp;

--
-- TOC entry 4268 (class 0 OID 0)
-- Dependencies: 452
-- Name: author_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.author_id_seq OWNED BY temp.author.id;


--
-- TOC entry 451 (class 1259 OID 1637554)
-- Name: category; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.category (
    id bigint NOT NULL,
    categoryname character varying(255) NOT NULL
);


ALTER TABLE temp.category OWNER TO temp;

--
-- TOC entry 450 (class 1259 OID 1637553)
-- Name: category_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.category_id_seq OWNER TO temp;

--
-- TOC entry 4269 (class 0 OID 0)
-- Dependencies: 450
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.category_id_seq OWNED BY temp.category.id;


--
-- TOC entry 474 (class 1259 OID 1637788)
-- Name: changeOrderStatusNotification; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp."changeOrderStatusNotification" (
    id bigint NOT NULL,
    id_order bigint NOT NULL,
    id_notification bigint NOT NULL
);


ALTER TABLE temp."changeOrderStatusNotification" OWNER TO temp;

--
-- TOC entry 473 (class 1259 OID 1637787)
-- Name: changeOrderStatusNotification_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp."changeOrderStatusNotification_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp."changeOrderStatusNotification_id_seq" OWNER TO temp;

--
-- TOC entry 4270 (class 0 OID 0)
-- Dependencies: 473
-- Name: changeOrderStatusNotification_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp."changeOrderStatusNotification_id_seq" OWNED BY temp."changeOrderStatusNotification".id;


--
-- TOC entry 470 (class 1259 OID 1637742)
-- Name: notification; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.notification (
    id bigint NOT NULL,
    id_authenticated_user bigint NOT NULL,
    text character varying(255) NOT NULL
);


ALTER TABLE temp.notification OWNER TO temp;

--
-- TOC entry 469 (class 1259 OID 1637741)
-- Name: notification_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.notification_id_seq OWNER TO temp;

--
-- TOC entry 4271 (class 0 OID 0)
-- Dependencies: 469
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.notification_id_seq OWNED BY temp.notification.id;


--
-- TOC entry 522 (class 1259 OID 1883611)
-- Name: orderPlacedNotification; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp."orderPlacedNotification" (
    id bigint NOT NULL,
    id_notification bigint NOT NULL,
    id_order bigint NOT NULL
);


ALTER TABLE temp."orderPlacedNotification" OWNER TO temp;

--
-- TOC entry 521 (class 1259 OID 1883610)
-- Name: orderPlacedNotification_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp."orderPlacedNotification_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp."orderPlacedNotification_id_seq" OWNER TO temp;

--
-- TOC entry 4272 (class 0 OID 0)
-- Dependencies: 521
-- Name: orderPlacedNotification_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp."orderPlacedNotification_id_seq" OWNED BY temp."orderPlacedNotification".id;


--
-- TOC entry 468 (class 1259 OID 1637725)
-- Name: order_product; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.order_product (
    id bigint NOT NULL,
    id_order bigint NOT NULL,
    id_product bigint NOT NULL
);


ALTER TABLE temp.order_product OWNER TO temp;

--
-- TOC entry 467 (class 1259 OID 1637724)
-- Name: orderProduct_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp."orderProduct_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp."orderProduct_id_seq" OWNER TO temp;

--
-- TOC entry 4273 (class 0 OID 0)
-- Dependencies: 467
-- Name: orderProduct_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp."orderProduct_id_seq" OWNED BY temp.order_product.id;


--
-- TOC entry 466 (class 1259 OID 1637708)
-- Name: orders; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.orders (
    id bigint NOT NULL,
    id_authenticated_user bigint NOT NULL,
    orderdate date NOT NULL,
    arrivaldate date NOT NULL,
    shippedaddress character varying(255) NOT NULL,
    totalprice double precision NOT NULL,
    orderstatus character varying(255) NOT NULL,
    CONSTRAINT order_check CHECK ((arrivaldate >= orderdate)),
    CONSTRAINT order_orderstatus_check CHECK (((orderstatus)::text = ANY ((ARRAY['processing'::character varying, 'shipped'::character varying, 'delivered'::character varying, 'in transit'::character varying])::text[]))),
    CONSTRAINT order_totalprice_check CHECK ((totalprice >= (0)::double precision))
);


ALTER TABLE temp.orders OWNER TO temp;

--
-- TOC entry 465 (class 1259 OID 1637707)
-- Name: order_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.order_id_seq OWNER TO temp;

--
-- TOC entry 4274 (class 0 OID 0)
-- Dependencies: 465
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.order_id_seq OWNED BY temp.orders.id;


--
-- TOC entry 523 (class 1259 OID 1904001)
-- Name: password_resets; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.password_resets (
    email character varying(255) NOT NULL,
    token character(6) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE temp.password_resets OWNER TO temp;

--
-- TOC entry 520 (class 1259 OID 1837284)
-- Name: payment_info; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.payment_info (
    id bigint NOT NULL,
    id_authenticated_user bigint NOT NULL,
    shippedaddress character varying(255),
    nif character varying(9),
    cardnumber character varying(16)
);


ALTER TABLE temp.payment_info OWNER TO temp;

--
-- TOC entry 519 (class 1259 OID 1837283)
-- Name: payment_info_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.payment_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.payment_info_id_seq OWNER TO temp;

--
-- TOC entry 4275 (class 0 OID 0)
-- Dependencies: 519
-- Name: payment_info_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.payment_info_id_seq OWNED BY temp.payment_info.id;


--
-- TOC entry 456 (class 1259 OID 1637583)
-- Name: product; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.product (
    id bigint NOT NULL,
    id_category bigint NOT NULL,
    id_author bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    price double precision NOT NULL,
    stock integer NOT NULL,
    image text,
    search_vector tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, (((COALESCE(title, ''::character varying))::text || ' '::text) || COALESCE(description, ''::text)))) STORED,
    CONSTRAINT product_price_check CHECK ((price >= (0)::double precision)),
    CONSTRAINT product_stock_check CHECK ((stock >= 0))
);


ALTER TABLE temp.product OWNER TO temp;

--
-- TOC entry 446 (class 1259 OID 1250185)
-- Name: productOnCartPriceChange; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp."productOnCartPriceChange" (
    id bigint NOT NULL,
    id_order bigint NOT NULL,
    id_notification bigint NOT NULL
);


ALTER TABLE temp."productOnCartPriceChange" OWNER TO temp;

--
-- TOC entry 478 (class 1259 OID 1664014)
-- Name: productOnCartPriceChangeNotification; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp."productOnCartPriceChangeNotification" (
    id bigint NOT NULL,
    id_shopping_cart bigint NOT NULL,
    id_notification bigint NOT NULL
);


ALTER TABLE temp."productOnCartPriceChangeNotification" OWNER TO temp;

--
-- TOC entry 477 (class 1259 OID 1664013)
-- Name: productOnCartPriceChangeNotification_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp."productOnCartPriceChangeNotification_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp."productOnCartPriceChangeNotification_id_seq" OWNER TO temp;

--
-- TOC entry 4276 (class 0 OID 0)
-- Dependencies: 477
-- Name: productOnCartPriceChangeNotification_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp."productOnCartPriceChangeNotification_id_seq" OWNED BY temp."productOnCartPriceChangeNotification".id;


--
-- TOC entry 445 (class 1259 OID 1250184)
-- Name: productOnCartPriceChange_id_notification_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp."productOnCartPriceChange_id_notification_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp."productOnCartPriceChange_id_notification_seq" OWNER TO temp;

--
-- TOC entry 4277 (class 0 OID 0)
-- Dependencies: 445
-- Name: productOnCartPriceChange_id_notification_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp."productOnCartPriceChange_id_notification_seq" OWNED BY temp."productOnCartPriceChange".id_notification;


--
-- TOC entry 444 (class 1259 OID 1250183)
-- Name: productOnCartPriceChange_id_order_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp."productOnCartPriceChange_id_order_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp."productOnCartPriceChange_id_order_seq" OWNER TO temp;

--
-- TOC entry 4278 (class 0 OID 0)
-- Dependencies: 444
-- Name: productOnCartPriceChange_id_order_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp."productOnCartPriceChange_id_order_seq" OWNED BY temp."productOnCartPriceChange".id_order;


--
-- TOC entry 443 (class 1259 OID 1250182)
-- Name: productOnCartPriceChange_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp."productOnCartPriceChange_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp."productOnCartPriceChange_id_seq" OWNER TO temp;

--
-- TOC entry 4279 (class 0 OID 0)
-- Dependencies: 443
-- Name: productOnCartPriceChange_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp."productOnCartPriceChange_id_seq" OWNED BY temp."productOnCartPriceChange".id;


--
-- TOC entry 472 (class 1259 OID 1637771)
-- Name: productWishlistAvailableNotification; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp."productWishlistAvailableNotification" (
    id bigint NOT NULL,
    id_wishlist bigint NOT NULL,
    id_notification bigint NOT NULL
);


ALTER TABLE temp."productWishlistAvailableNotification" OWNER TO temp;

--
-- TOC entry 471 (class 1259 OID 1637770)
-- Name: productWishlistAvailableNotification_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp."productWishlistAvailableNotification_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp."productWishlistAvailableNotification_id_seq" OWNER TO temp;

--
-- TOC entry 4280 (class 0 OID 0)
-- Dependencies: 471
-- Name: productWishlistAvailableNotification_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp."productWishlistAvailableNotification_id_seq" OWNED BY temp."productWishlistAvailableNotification".id;


--
-- TOC entry 455 (class 1259 OID 1637582)
-- Name: product_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.product_id_seq OWNER TO temp;

--
-- TOC entry 4281 (class 0 OID 0)
-- Dependencies: 455
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.product_id_seq OWNED BY temp.product.id;


--
-- TOC entry 462 (class 1259 OID 1637657)
-- Name: review_author; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.review_author (
    id bigint NOT NULL,
    id_author bigint NOT NULL,
    id_authenticated_user bigint NOT NULL,
    date date NOT NULL,
    comment text NOT NULL,
    rating integer NOT NULL,
    CONSTRAINT review_author_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE temp.review_author OWNER TO temp;

--
-- TOC entry 461 (class 1259 OID 1637656)
-- Name: review_author_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.review_author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.review_author_id_seq OWNER TO temp;

--
-- TOC entry 4282 (class 0 OID 0)
-- Dependencies: 461
-- Name: review_author_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.review_author_id_seq OWNED BY temp.review_author.id;


--
-- TOC entry 460 (class 1259 OID 1637637)
-- Name: review_product; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.review_product (
    id bigint NOT NULL,
    id_product bigint NOT NULL,
    id_authenticated_user bigint NOT NULL,
    date date NOT NULL,
    comment text NOT NULL,
    rating integer NOT NULL,
    CONSTRAINT review_product_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE temp.review_product OWNER TO temp;

--
-- TOC entry 459 (class 1259 OID 1637636)
-- Name: review_product_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.review_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.review_product_id_seq OWNER TO temp;

--
-- TOC entry 4283 (class 0 OID 0)
-- Dependencies: 459
-- Name: review_product_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.review_product_id_seq OWNED BY temp.review_product.id;


--
-- TOC entry 464 (class 1259 OID 1637677)
-- Name: shoppingCart; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp."shoppingCart" (
    id bigint NOT NULL,
    id_authenticated_user bigint NOT NULL
);


ALTER TABLE temp."shoppingCart" OWNER TO temp;

--
-- TOC entry 476 (class 1259 OID 1663997)
-- Name: shoppingCartProduct; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp."shoppingCartProduct" (
    id bigint NOT NULL,
    id_shopping_cart bigint NOT NULL,
    id_product bigint NOT NULL
);


ALTER TABLE temp."shoppingCartProduct" OWNER TO temp;

--
-- TOC entry 475 (class 1259 OID 1663996)
-- Name: shoppingCartProduct_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp."shoppingCartProduct_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp."shoppingCartProduct_id_seq" OWNER TO temp;

--
-- TOC entry 4284 (class 0 OID 0)
-- Dependencies: 475
-- Name: shoppingCartProduct_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp."shoppingCartProduct_id_seq" OWNED BY temp."shoppingCartProduct".id;


--
-- TOC entry 463 (class 1259 OID 1637676)
-- Name: shoppingCart_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp."shoppingCart_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp."shoppingCart_id_seq" OWNER TO temp;

--
-- TOC entry 4285 (class 0 OID 0)
-- Dependencies: 463
-- Name: shoppingCart_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp."shoppingCart_id_seq" OWNED BY temp."shoppingCart".id;


--
-- TOC entry 448 (class 1259 OID 1637531)
-- Name: users; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.users (
    id bigint NOT NULL,
    username character varying(20) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    fullname character varying(255),
    avatar text
);


ALTER TABLE temp.users OWNER TO temp;

--
-- TOC entry 447 (class 1259 OID 1637530)
-- Name: users_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.users_id_seq OWNER TO temp;

--
-- TOC entry 4286 (class 0 OID 0)
-- Dependencies: 447
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.users_id_seq OWNED BY temp.users.id;


--
-- TOC entry 458 (class 1259 OID 1637604)
-- Name: wishlist; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.wishlist (
    id bigint NOT NULL,
    id_authenticated_user bigint NOT NULL
);


ALTER TABLE temp.wishlist OWNER TO temp;

--
-- TOC entry 457 (class 1259 OID 1637603)
-- Name: wishlist_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.wishlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.wishlist_id_seq OWNER TO temp;

--
-- TOC entry 4287 (class 0 OID 0)
-- Dependencies: 457
-- Name: wishlist_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.wishlist_id_seq OWNED BY temp.wishlist.id;


--
-- TOC entry 518 (class 1259 OID 1837214)
-- Name: wishlist_product; Type: TABLE; Schema: temp; Owner: temp
--

CREATE TABLE temp.wishlist_product (
    id bigint NOT NULL,
    id_wishlist bigint NOT NULL,
    id_product bigint NOT NULL
);


ALTER TABLE temp.wishlist_product OWNER TO temp;

--
-- TOC entry 517 (class 1259 OID 1837213)
-- Name: wishlist_product_id_seq; Type: SEQUENCE; Schema: temp; Owner: temp
--

CREATE SEQUENCE temp.wishlist_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE temp.wishlist_product_id_seq OWNER TO temp;

--
-- TOC entry 4288 (class 0 OID 0)
-- Dependencies: 517
-- Name: wishlist_product_id_seq; Type: SEQUENCE OWNED BY; Schema: temp; Owner: temp
--

ALTER SEQUENCE temp.wishlist_product_id_seq OWNED BY temp.wishlist_product.id;


--
-- TOC entry 3950 (class 2604 OID 1637566)
-- Name: author id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.author ALTER COLUMN id SET DEFAULT nextval('temp.author_id_seq'::regclass);


--
-- TOC entry 3949 (class 2604 OID 1637557)
-- Name: category id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.category ALTER COLUMN id SET DEFAULT nextval('temp.category_id_seq'::regclass);


--
-- TOC entry 3961 (class 2604 OID 1637791)
-- Name: changeOrderStatusNotification id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."changeOrderStatusNotification" ALTER COLUMN id SET DEFAULT nextval('temp."changeOrderStatusNotification_id_seq"'::regclass);


--
-- TOC entry 3959 (class 2604 OID 1637745)
-- Name: notification id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.notification ALTER COLUMN id SET DEFAULT nextval('temp.notification_id_seq'::regclass);


--
-- TOC entry 3966 (class 2604 OID 1883614)
-- Name: orderPlacedNotification id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."orderPlacedNotification" ALTER COLUMN id SET DEFAULT nextval('temp."orderPlacedNotification_id_seq"'::regclass);


--
-- TOC entry 3958 (class 2604 OID 1637728)
-- Name: order_product id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.order_product ALTER COLUMN id SET DEFAULT nextval('temp."orderProduct_id_seq"'::regclass);


--
-- TOC entry 3957 (class 2604 OID 1637711)
-- Name: orders id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.orders ALTER COLUMN id SET DEFAULT nextval('temp.order_id_seq'::regclass);


--
-- TOC entry 3965 (class 2604 OID 1837287)
-- Name: payment_info id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.payment_info ALTER COLUMN id SET DEFAULT nextval('temp.payment_info_id_seq'::regclass);


--
-- TOC entry 3951 (class 2604 OID 1637586)
-- Name: product id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.product ALTER COLUMN id SET DEFAULT nextval('temp.product_id_seq'::regclass);


--
-- TOC entry 3945 (class 2604 OID 1250188)
-- Name: productOnCartPriceChange id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productOnCartPriceChange" ALTER COLUMN id SET DEFAULT nextval('temp."productOnCartPriceChange_id_seq"'::regclass);


--
-- TOC entry 3946 (class 2604 OID 1250189)
-- Name: productOnCartPriceChange id_order; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productOnCartPriceChange" ALTER COLUMN id_order SET DEFAULT nextval('temp."productOnCartPriceChange_id_order_seq"'::regclass);


--
-- TOC entry 3947 (class 2604 OID 1250190)
-- Name: productOnCartPriceChange id_notification; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productOnCartPriceChange" ALTER COLUMN id_notification SET DEFAULT nextval('temp."productOnCartPriceChange_id_notification_seq"'::regclass);


--
-- TOC entry 3963 (class 2604 OID 1664017)
-- Name: productOnCartPriceChangeNotification id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productOnCartPriceChangeNotification" ALTER COLUMN id SET DEFAULT nextval('temp."productOnCartPriceChangeNotification_id_seq"'::regclass);


--
-- TOC entry 3960 (class 2604 OID 1637774)
-- Name: productWishlistAvailableNotification id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productWishlistAvailableNotification" ALTER COLUMN id SET DEFAULT nextval('temp."productWishlistAvailableNotification_id_seq"'::regclass);


--
-- TOC entry 3955 (class 2604 OID 1637660)
-- Name: review_author id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.review_author ALTER COLUMN id SET DEFAULT nextval('temp.review_author_id_seq'::regclass);


--
-- TOC entry 3954 (class 2604 OID 1637640)
-- Name: review_product id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.review_product ALTER COLUMN id SET DEFAULT nextval('temp.review_product_id_seq'::regclass);


--
-- TOC entry 3956 (class 2604 OID 1637680)
-- Name: shoppingCart id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."shoppingCart" ALTER COLUMN id SET DEFAULT nextval('temp."shoppingCart_id_seq"'::regclass);


--
-- TOC entry 3962 (class 2604 OID 1664000)
-- Name: shoppingCartProduct id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."shoppingCartProduct" ALTER COLUMN id SET DEFAULT nextval('temp."shoppingCartProduct_id_seq"'::regclass);


--
-- TOC entry 3948 (class 2604 OID 1637534)
-- Name: users id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.users ALTER COLUMN id SET DEFAULT nextval('temp.users_id_seq'::regclass);


--
-- TOC entry 3953 (class 2604 OID 1637607)
-- Name: wishlist id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.wishlist ALTER COLUMN id SET DEFAULT nextval('temp.wishlist_id_seq'::regclass);


--
-- TOC entry 3964 (class 2604 OID 1837217)
-- Name: wishlist_product id; Type: DEFAULT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.wishlist_product ALTER COLUMN id SET DEFAULT nextval('temp.wishlist_product_id_seq'::regclass);


--
-- TOC entry 4226 (class 0 OID 1637543)
-- Dependencies: 449
-- Data for Name: admin; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.admin (id) VALUES (13);
INSERT INTO temp.admin (id) VALUES (24);


--
-- TOC entry 4231 (class 0 OID 1637572)
-- Dependencies: 454
-- Data for Name: authenticated_user; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.authenticated_user (id) VALUES (3);
INSERT INTO temp.authenticated_user (id) VALUES (8);
INSERT INTO temp.authenticated_user (id) VALUES (11);
INSERT INTO temp.authenticated_user (id) VALUES (12);
INSERT INTO temp.authenticated_user (id) VALUES (20);
INSERT INTO temp.authenticated_user (id) VALUES (21);
INSERT INTO temp.authenticated_user (id) VALUES (22);
INSERT INTO temp.authenticated_user (id) VALUES (23);
INSERT INTO temp.authenticated_user (id) VALUES (24);
INSERT INTO temp.authenticated_user (id) VALUES (25);
INSERT INTO temp.authenticated_user (id) VALUES (28);
INSERT INTO temp.authenticated_user (id) VALUES (30);
INSERT INTO temp.authenticated_user (id) VALUES (26);
INSERT INTO temp.authenticated_user (id) VALUES (32);
INSERT INTO temp.authenticated_user (id) VALUES (33);
INSERT INTO temp.authenticated_user (id) VALUES (34);
INSERT INTO temp.authenticated_user (id) VALUES (35);
INSERT INTO temp.authenticated_user (id) VALUES (36);
INSERT INTO temp.authenticated_user (id) VALUES (37);
INSERT INTO temp.authenticated_user (id) VALUES (38);
INSERT INTO temp.authenticated_user (id) VALUES (39);
INSERT INTO temp.authenticated_user (id) VALUES (40);
INSERT INTO temp.authenticated_user (id) VALUES (41);
INSERT INTO temp.authenticated_user (id) VALUES (42);
INSERT INTO temp.authenticated_user (id) VALUES (43);
INSERT INTO temp.authenticated_user (id) VALUES (44);


--
-- TOC entry 4230 (class 0 OID 1637563)
-- Dependencies: 453
-- Data for Name: author; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.author (id, name, biography, rating, image) VALUES (1, 'Emma Turner', 'Biography of Author 1', 4, NULL);
INSERT INTO temp.author (id, name, biography, rating, image) VALUES (2, 'Liam Hayes', 'Biography of Author 2', 5, NULL);
INSERT INTO temp.author (id, name, biography, rating, image) VALUES (3, 'Sophia Evans', 'Biography of Author 3', 3, NULL);
INSERT INTO temp.author (id, name, biography, rating, image) VALUES (4, 'Noah Carter', 'Biography of Author 4', 4, NULL);
INSERT INTO temp.author (id, name, biography, rating, image) VALUES (5, 'Olivia Reed', 'Biography of Author 5', 5, NULL);
INSERT INTO temp.author (id, name, biography, rating, image) VALUES (6, 'Lucas Bennett', 'Biography of Author 6', 3, NULL);
INSERT INTO temp.author (id, name, biography, rating, image) VALUES (7, 'Isabella Brooks', 'Biography of Author 7', 4, NULL);
INSERT INTO temp.author (id, name, biography, rating, image) VALUES (8, 'Mason Hughes', 'Biography of Author 8', 5, NULL);
INSERT INTO temp.author (id, name, biography, rating, image) VALUES (9, 'Mia Foster', 'Biography of Author 9', 4, NULL);
INSERT INTO temp.author (id, name, biography, rating, image) VALUES (10, 'Ethan Powell', 'Biography of Author 10', 5, NULL);


--
-- TOC entry 4228 (class 0 OID 1637554)
-- Dependencies: 451
-- Data for Name: category; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.category (id, categoryname) VALUES (1, 'Horror');
INSERT INTO temp.category (id, categoryname) VALUES (2, 'Educational');
INSERT INTO temp.category (id, categoryname) VALUES (3, 'Fantasy');
INSERT INTO temp.category (id, categoryname) VALUES (4, 'Romance');
INSERT INTO temp.category (id, categoryname) VALUES (5, 'Fiction');
INSERT INTO temp.category (id, categoryname) VALUES (6, 'Non-Fiction');
INSERT INTO temp.category (id, categoryname) VALUES (7, 'Children');
INSERT INTO temp.category (id, categoryname) VALUES (8, 'Young Adult');
INSERT INTO temp.category (id, categoryname) VALUES (9, 'Mystery');
INSERT INTO temp.category (id, categoryname) VALUES (10, 'Biography');
INSERT INTO temp.category (id, categoryname) VALUES (13, 'Books');
INSERT INTO temp.category (id, categoryname) VALUES (14, 'Electronics');


--
-- TOC entry 4251 (class 0 OID 1637788)
-- Dependencies: 474
-- Data for Name: changeOrderStatusNotification; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp."changeOrderStatusNotification" (id, id_order, id_notification) VALUES (1, 1, 6);
INSERT INTO temp."changeOrderStatusNotification" (id, id_order, id_notification) VALUES (2, 1, 7);


--
-- TOC entry 4247 (class 0 OID 1637742)
-- Dependencies: 470
-- Data for Name: notification; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (1, 11, 'The product Product A is now available!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (4, 25, 'The price of product Terror on Elm Street has changed to 1.99!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (5, 25, 'The price of product Terror on Elm Street has changed to 1.98!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (6, 11, 'Your order status has been updated to: shipped');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (7, 11, 'Your order status has been updated to: processing');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (9, 12, 'Your order has been successfully placed!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (10, 12, 'Your order has been successfully placed!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (11, 43, 'Your order has been successfully placed!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (12, 42, 'The price of product Elves of the Forest has changed to 21.12!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (13, 41, 'The price of product Elves of the Forest has changed to 21.12!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (14, 42, 'The price of product Elves of the Forest has changed to 1.99!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (15, 41, 'The price of product Elves of the Forest has changed to 1.99!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (16, 41, 'The price of product Magic Unleashed has changed to 4.99!');
INSERT INTO temp.notification (id, id_authenticated_user, text) VALUES (17, 43, 'Your order has been successfully placed!');


--
-- TOC entry 4261 (class 0 OID 1883611)
-- Dependencies: 522
-- Data for Name: orderPlacedNotification; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp."orderPlacedNotification" (id, id_notification, id_order) VALUES (1, 9, 12);
INSERT INTO temp."orderPlacedNotification" (id, id_notification, id_order) VALUES (2, 10, 14);


--
-- TOC entry 4245 (class 0 OID 1637725)
-- Dependencies: 468
-- Data for Name: order_product; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.order_product (id, id_order, id_product) VALUES (4, 1, 5);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (8, 4, 6);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (9, 5, 6);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (10, 5, 7);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (11, 5, 8);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (12, 1, 6);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (13, 1, 6);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (14, 1, 6);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (15, 1, 6);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (16, 1, 6);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (17, 1, 7);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (18, 9, 5);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (19, 9, 5);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (20, 10, 11);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (21, 10, 9);
INSERT INTO temp.order_product (id, id_order, id_product) VALUES (22, 10, 18);


--
-- TOC entry 4243 (class 0 OID 1637708)
-- Dependencies: 466
-- Data for Name: orders; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.orders (id, id_authenticated_user, orderdate, arrivaldate, shippedaddress, totalprice, orderstatus) VALUES (3, 12, '2024-12-06', '2024-12-13', '123 Main St', 100, 'processing');
INSERT INTO temp.orders (id, id_authenticated_user, orderdate, arrivaldate, shippedaddress, totalprice, orderstatus) VALUES (4, 8, '2024-12-06', '2024-12-13', 'test addr', 19.99, 'processing');
INSERT INTO temp.orders (id, id_authenticated_user, orderdate, arrivaldate, shippedaddress, totalprice, orderstatus) VALUES (1, 11, '2024-12-06', '2024-12-13', '123 Main St', 100, 'processing');
INSERT INTO temp.orders (id, id_authenticated_user, orderdate, arrivaldate, shippedaddress, totalprice, orderstatus) VALUES (5, 26, '2024-12-07', '2024-12-14', 'Rua dr Porto', 68.97, 'processing');
INSERT INTO temp.orders (id, id_authenticated_user, orderdate, arrivaldate, shippedaddress, totalprice, orderstatus) VALUES (9, 25, '2024-12-06', '2024-12-13', '123 Main St', 10, 'processing');
INSERT INTO temp.orders (id, id_authenticated_user, orderdate, arrivaldate, shippedaddress, totalprice, orderstatus) VALUES (10, 26, '2024-12-11', '2024-12-18', 'Rua dr Porto', 60.97, 'processing');
INSERT INTO temp.orders (id, id_authenticated_user, orderdate, arrivaldate, shippedaddress, totalprice, orderstatus) VALUES (12, 12, '2024-12-06', '2024-12-13', '123frw', 11, 'processing');
INSERT INTO temp.orders (id, id_authenticated_user, orderdate, arrivaldate, shippedaddress, totalprice, orderstatus) VALUES (14, 12, '2024-12-06', '2024-12-13', 'vfd', 44, 'processing');


--
-- TOC entry 4262 (class 0 OID 1904001)
-- Dependencies: 523
-- Data for Name: password_resets; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.password_resets (email, token, created_at) VALUES ('felixmiranda16@gmail.com', '9G6YF6', '2024-12-13 17:31:20');


--
-- TOC entry 4259 (class 0 OID 1837284)
-- Dependencies: 520
-- Data for Name: payment_info; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (1, 28, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (2, 30, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (4, 26, 'Rua dr Porto', NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (6, 32, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (7, 33, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (9, 35, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (10, 36, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (11, 37, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (12, 38, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (13, 39, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (14, 40, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (15, 41, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (16, 42, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (8, 34, NULL, NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (17, 43, 'jadsf', NULL, NULL);
INSERT INTO temp.payment_info (id, id_authenticated_user, shippedaddress, nif, cardnumber) VALUES (18, 44, NULL, NULL, NULL);


--
-- TOC entry 4233 (class 0 OID 1637583)
-- Dependencies: 456
-- Data for Name: product; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (15, 3, 1, 'Realm of Shadows', 'A battle between light and dark.', 17.99, 45, 'images/image15.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (20, 4, 9, 'Second Chances', 'When love gets another chance.', 11.99, 70, 'images/image20.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (21, 5, 9, 'Parallel Lives', 'A story of choices and consequences.', 18.99, 45, 'images/image21.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (22, 5, 4, 'Hidden Truths', 'What secrets does the protagonist hide?', 16.99, 30, 'images/image22.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (23, 5, 5, 'Echoes of the Past', 'When history repeats itself.', 14.99, 50, 'images/image23.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (25, 5, 2, 'The Clockmaker’s Secret', 'Time is both a friend and a foe.', 20.99, 25, 'images/image25.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (26, 6, 7, 'The Art of War', 'Ancient strategies for modern life.', 22.99, 30, 'images/image26.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (27, 6, 7, 'Mind Over Matter', 'Mastering your inner strength.', 24.99, 25, 'images/image27.png');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (28, 6, 6, 'Unlocking Creativity', 'A guide to innovative thinking.', 19.99, 40, 'images/image28.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (29, 6, 5, 'The Power of Habit', 'How habits shape our lives.', 21.99, 35, 'images/image29.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (30, 6, 4, 'The Road Less Traveled', 'A personal journey to success.', 23.99, 20, 'images/image30.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (31, 7, 2, 'Adventures in Toyland', 'A fun journey through imagination.', 9.99, 100, 'images/image31.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (32, 7, 9, 'Bedtime Stories', 'Perfect tales to end the day.', 8.99, 90, 'images/image32.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (33, 7, 1, 'The Brave Little Hero', 'Courage comes in small packages.', 10.99, 80, 'images/image33.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (34, 7, 1, 'Fairy Tale Magic', 'Classic fairy tales retold.', 7.99, 110, 'images/image34.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (35, 7, 6, 'Animal Friends', 'Stories about friendship and animals.', 6.99, 120, 'images/image35.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (36, 8, 7, 'The Rising Star', 'A teen’s journey to fame.', 12.99, 60, 'images/image36.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (37, 8, 8, 'Chasing Dreams', 'Following your passion.', 14.99, 50, 'images/image37.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (3, 1, 3, 'Whispers in the Dark', 'What hides in the shadows?', 10.99, 29, 'images/image3.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (1, 1, 1, 'The Haunted Manor', 'A chilling story of a haunted house.', 13.99, 18, 'images/image1.png');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (4, 1, 4, 'Ghostly Encounters', 'True stories of paranormal activity.', 14.99, 14, 'images/image4.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (10, 2, 10, 'Programming Basics', 'Learn to code with Python.', 18.99, 24, 'images/image10.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (14, 3, 8, 'The Wizard’s Apprentice', 'A journey of learning and power.', 20.99, 29, 'images/image14.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (7, 2, 7, 'The Science of Learning', 'Discover how the brain learns.', 25.99, 29, 'images/image7.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (5, 1, 5, 'Terror on Elm Street', 'A neighborhood haunted by fear.', 1.98, 15, 'images/image5.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (11, 3, 2, 'Dragon Rise', 'The tale of a dragon return.', 16.99, 49, 'images/image11.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (9, 2, 9, 'Mastering Physics', 'A comprehensive guide to physics.', 29.99, 19, 'images/image9.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (18, 4, 1, 'Forbidden Desire', 'A tale of impossible love.', 13.99, 39, 'images/image18.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (13, 3, 7, 'Magic Unleashed', 'When ordinary people find magic.', 4.99, 35, 'images/image13.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (8, 2, 8, 'History Unveiled', 'Understand the past in new ways.', 22.99, 33, 'images/image8.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (16, 4, 3, 'A Love to Remember', 'A timeless story of romance.', 12.99, 59, 'images/image16.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (17, 4, 2, 'Hearts United', 'Love stories to warm your soul.', 14.99, 54, 'images/image17.png');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (19, 4, 8, 'The Proposal', 'A journey to a happy ending.', 15.99, 49, 'images/image19.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (38, 8, 4, 'The Summer We Changed', 'A life-changing summer.', 13.99, 70, 'images/image38.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (39, 8, 4, 'Secrets in High School', 'Drama and mystery in the hallways.', 15.99, 40, 'images/image39.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (40, 8, 3, 'A World Apart', 'Navigating life’s challenges.', 11.99, 80, 'images/image40.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (41, 9, 5, 'The Last Clue', 'Can you solve the mystery?', 14.99, 50, 'images/image41.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (42, 9, 5, 'Murder on the Coast', 'A seaside town with dark secrets.', 18.99, 35, 'images/image42.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (43, 9, 2, 'The Vanishing Act', 'What happened to the missing person?', 16.99, 45, 'images/image43.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (44, 9, 8, 'Shadows of Deception', 'When nothing is as it seems.', 17.99, 40, 'images/image44.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (45, 9, 7, 'The Silent Witness', 'The only clue is a silent witness.', 19.99, 30, 'images/image45.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (46, 10, 1, 'The Innovator', 'The life of a tech visionary.', 22.99, 25, 'images/image46.png');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (47, 10, 10, 'A Life in Music', 'The story of a musical legend.', 24.99, 15, 'images/image47.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (48, 10, 10, 'Courage Under Fire', 'A tale of resilience.', 20.99, 20, 'images/image48.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (49, 10, 10, 'Leading the Way', 'The journey of an inspiring leader.', 23.99, 10, 'images/image49.png');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (50, 10, 5, 'A Journey to Greatness', 'How one person changed the world.', 21.99, 15, 'images/image50.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (24, 5, 3, 'The Mysterious Stranger', 'A mysterious visitor changes everything.', 17.99, 35, 'images/image24.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (2, 1, 2, 'Nightmares Unleashed', 'Terrifying tales of the unknown.', 11.99, 24, 'images/image2.jpg');
INSERT INTO temp.product (id, id_category, id_author, title, description, price, stock, image) VALUES (6, 2, 6, 'Math Made Easy', 'Learn math with simple techniques.', 19.99, 32, 'images/image6.jpg');


--
-- TOC entry 4223 (class 0 OID 1250185)
-- Dependencies: 446
-- Data for Name: productOnCartPriceChange; Type: TABLE DATA; Schema: temp; Owner: temp
--



--
-- TOC entry 4255 (class 0 OID 1664014)
-- Dependencies: 478
-- Data for Name: productOnCartPriceChangeNotification; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp."productOnCartPriceChangeNotification" (id, id_shopping_cart, id_notification) VALUES (1, 15, 4);
INSERT INTO temp."productOnCartPriceChangeNotification" (id, id_shopping_cart, id_notification) VALUES (2, 15, 5);
INSERT INTO temp."productOnCartPriceChangeNotification" (id, id_shopping_cart, id_notification) VALUES (3, 31, 12);
INSERT INTO temp."productOnCartPriceChangeNotification" (id, id_shopping_cart, id_notification) VALUES (4, 29, 13);
INSERT INTO temp."productOnCartPriceChangeNotification" (id, id_shopping_cart, id_notification) VALUES (5, 31, 14);
INSERT INTO temp."productOnCartPriceChangeNotification" (id, id_shopping_cart, id_notification) VALUES (6, 29, 15);
INSERT INTO temp."productOnCartPriceChangeNotification" (id, id_shopping_cart, id_notification) VALUES (7, 29, 16);


--
-- TOC entry 4249 (class 0 OID 1637771)
-- Dependencies: 472
-- Data for Name: productWishlistAvailableNotification; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp."productWishlistAvailableNotification" (id, id_wishlist, id_notification) VALUES (1, 1, 1);


--
-- TOC entry 4239 (class 0 OID 1637657)
-- Dependencies: 462
-- Data for Name: review_author; Type: TABLE DATA; Schema: temp; Owner: temp
--



--
-- TOC entry 4237 (class 0 OID 1637637)
-- Dependencies: 460
-- Data for Name: review_product; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.review_product (id, id_product, id_authenticated_user, date, comment, rating) VALUES (13, 1, 11, '2024-12-10', 'Great', 5);
INSERT INTO temp.review_product (id, id_product, id_authenticated_user, date, comment, rating) VALUES (19, 5, 8, '2024-12-06', 'This is an awesome horror movie!', 5);
INSERT INTO temp.review_product (id, id_product, id_authenticated_user, date, comment, rating) VALUES (20, 6, 8, '2024-12-06', 'Awesome book to learn math', 5);
INSERT INTO temp.review_product (id, id_product, id_authenticated_user, date, comment, rating) VALUES (22, 8, 26, '2024-12-07', 'Not very good history book', 1);
INSERT INTO temp.review_product (id, id_product, id_authenticated_user, date, comment, rating) VALUES (23, 7, 26, '2024-12-08', 'Cool science book', 4);
INSERT INTO temp.review_product (id, id_product, id_authenticated_user, date, comment, rating) VALUES (24, 6, 26, '2024-12-08', 'Excelent book to learn !!!
Amazing !', 5);
INSERT INTO temp.review_product (id, id_product, id_authenticated_user, date, comment, rating) VALUES (26, 18, 26, '2024-12-11', 'Not a very good book', 1);


--
-- TOC entry 4241 (class 0 OID 1637677)
-- Dependencies: 464
-- Data for Name: shoppingCart; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (3, 3);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (6, 8);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (15, 25);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (19, 26);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (20, 33);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (21, 34);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (25, 35);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (26, 38);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (27, 39);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (28, 40);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (29, 41);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (30, 36);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (31, 42);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (32, 24);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (33, 43);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (34, 23);
INSERT INTO temp."shoppingCart" (id, id_authenticated_user) VALUES (35, 44);


--
-- TOC entry 4253 (class 0 OID 1663997)
-- Dependencies: 476
-- Data for Name: shoppingCartProduct; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (14, 28, 7);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (15, 28, 8);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (16, 28, 6);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (17, 28, 7);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (18, 28, 33);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (19, 28, 31);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (20, 28, 2);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (21, 28, 48);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (22, 28, 23);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (23, 28, 6);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (24, 28, 6);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (32, 30, 9);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (100, 31, 7);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (101, 31, 8);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (102, 31, 9);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (103, 31, 11);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (108, 3, 8);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (110, 34, 8);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (126, 29, 13);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (127, 29, 15);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (128, 29, 16);
INSERT INTO temp."shoppingCartProduct" (id, id_shopping_cart, id_product) VALUES (132, 29, 15);


--
-- TOC entry 4225 (class 0 OID 1637531)
-- Dependencies: 448
-- Data for Name: users; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (1, 'johndoe', 'hashed_password_here', 'johndoe@example.com', 'John Doe', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (4, 'felixmiranda2', '$2y$10$ImTwO6sQj1e/YhSli3KfQOaJvX4UEIz1o2.SkkyAms1974pkfcb5u', 'felixmiranda2@gmail.com', NULL, NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (21, 'felixmiranda10', '$2y$10$dFxS0SNvWPWN3fNzWJzs2OOoey8mVe0ZZj3891Nb6iSBCa2ixA58W', 'felixmiranda10@gmail.com', 'Felix Miranda 10', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (22, 'felixmiranda11', '$2y$10$WSCAMey/lxwlkNQjsDLoe.UVNlWK0XaeorjIP4NtXJsuvE154rUBi', 'felixmiranda11@gmail.com', 'Felix Miranda 11', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (8, 'Test User', '$2y$10$lhLq8.0pmEz5zQ.kXmasleBLTYHfSnbb9FLN5gpslsY47SXacwnza', 'jose@example.com', 'Mock User', '1733095613.jpg');
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (23, 'felixmiranda12', '$2y$10$sr78tsNdkUVz.byXHg3tP.ihNfZKtE75x6s3.wAhsSNsgIHEy3z0O', 'felixmiranda12@gmail.com', 'Felix Miranda 12', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (24, 'admin', '$2y$10$jfUuMFo3n2Ako6QGl5rf4O4DHrM9UeYV/.nNd0hOfXnvDQXXNZfGm', 'admin@admin.com', 'Admin', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (5, 'aaaaa', '$2y$10$Ju48s0cDPowS/vzDFSHzDemJ5ry78WG.KQhqfAbXSD34Hbn9SwERy', 'email@email.com', NULL, NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (6, 'aaaaaaaa', '$2y$10$QvRm.FATIGqSj8L50Cpmv.u.Dh7vg6PU0nnk.cyuEjIMzmWsNFk/K', 'joaf@joaf.com', NULL, NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (25, 'newuser', 'password123', 'newuser@example.com', NULL, NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (7, 'rui', '$2y$10$zV44128EcgTh6/da9q5ptufB/Rn9AaBQ0p1JGBuSoCPacfBgejWlO', 'rui@rui.com', NULL, NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (28, 'testuser', 'password123', 'testuser@example.com', 'Test User', 'avatar_url');
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (30, 'testuser2', 'password123', 'testuser2@example.com', 'Test User', 'avatar_url');
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (26, 'rodolfo31', '$2y$10$qMqENX1oHrnvTAo6PEfxseftmwSs1WKTY5X.9lt/fhVEM4WxCk0M2', 'rodolfo@gmail.com', 'António Rodolfo de Almeida Seara Ferreira', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (32, 'felixmiranda13', '$2y$10$CsEWvibkyKpaizEZGgtvYOFHYFI5Lx3lYG0fTrSR8InRnkylHKJ3u', 'felixmiranda13@gmail.com', 'Felix Miranda 13', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (33, 'felixmiranda14', '$2y$10$BrziT5JwOO/l83zEvO94l.zBvw/YGseXzJld5TbFMZqPGMeIX3lO2', 'felixmiranda14@gmail.com', 'Felix Miranda 14', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (34, 'felixmiranda15', '$2y$10$Xn.tZGbU3962Fja9xn75cOqkAB0OYdJ6NB6gz2yusHaff4B6KRdSS', 'felixmiranda15@gmail.com', 'Felix Miranda 15', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (35, 'testing', '$2y$10$s5mP7pt4u8JJn5Cr/Yq0AOWKVMFsJ8VrwNxaW30wet04Jg5FEJl06', 'testing@testing.com', 'testing', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (36, 'aaaaaaaaaaaaaaaaa', '$2y$10$krRenDkeZAgre29D3GYLR.k.EX05h.rLuvSGtsXffYhug5wEcRmgK', 'aaaaaaaaaa@aaaaaaaa.com', 'aaaaaaaaaaaaaa', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (37, 'aaaaaaaaaaaaaaaa', '$2y$10$.dRCNzqsuo0CCXnRIUpFDeJVmQQ7pMUrADVvyE27mEgl69ZZwfQ1m', 'a@a.com', 'aaaaaaaaaaaaaa', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (11, 'user1', 'password1', 'user1@example.com', 'User One', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (12, 'user2', 'password2', 'user2@example.com', 'User Two', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (13, 'admin_user', 'adminpassword', 'admin@example.com', 'Administrator User', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (14, 'felixmiranda3', '$2y$10$q23Rm1ZKWjenpKwYOa4ouOo5f2kcyekNCWSR5XbpKBk2In4HwZJP.', 'felixmiranda3@gmail.com', NULL, NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (15, 'felixmiranda4', '$2y$10$LkwLchL53S5fvrWHQAODbekBNyXdYzCsb4YxGJTT3xSLJoh1gHudO', 'felixmiranda4@gmail.com', NULL, NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (16, 'felixmiranda5', '$2y$10$23Y/gwXAw5AlyF1Nc85Tgeyxg6orSGsCke32BklI2Yf6zIGKVQcAO', 'felixmiranda5@gmail.com', 'Felix Miranda 5', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (17, 'felixmiranda6', '$2y$10$oEeL22iXNmJGs2EPNE.2UODCJedxJEIoWxYOLs8yAS.mXHdI6rdyG', 'felixmiranda6@gmail.com', 'Felix Miranda 6', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (18, 'felixmiranda7', '$2y$10$n0nYFRIGUBLeFHhVnra1neKl6auahlh.7hzW9XAmYw.k/6CWedZKW', 'felixmiranda7@gmail.com', 'Felix Miranda 7', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (19, 'felixmiranda8', '$2y$10$MGYWAcD/HKpAi8ghgffGN.cYrkzR/JTBiLO07XWIcdFKB0BFr5kaW', 'felixmiranda8@gmail.com', 'Felix Miranda 8', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (20, 'felixmiranda9', '$2y$10$Gj/phECfwtURDeLbtjdKgOF5EU8EV9zxlRFeh8/IgW7a8BYAPygWG', 'felixmiranda9@gmail.com', 'Felix Miranda 9', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (38, 'aa', '$2y$10$yzIMhXAhBVlfFNXONOYiuuzTKs577M.bwGEDFtwI2PFXh9QWvreOu', 'aa@aacom', 'aa', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (39, 'aaa', '$2y$10$mEbi.51U/b.mlb2o4oUExOQu2ZJY8qs8kMP7s3VIPwphhHzTpFdku', 'aaa@aaa.com', 'aaa', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (40, 'aaaa', '$2y$10$Sb2AALbYNgT.GW7r9QPvCe9TfVU9saifw4XGUjpxP5imz59lmtS/S', 'aaaa@aaaa.com', 'aaaa', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (41, 'aaaaaa', '$2y$10$aRRdXustk84yTKDUXQpG6eBRnToZ0fJWIBoGhzWv7aiNiLK/fbghO', 'aaaaaa@aaaaaa.com', 'aaaaaa', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (42, 'bbbbbb', '$2y$10$y9gtCPqkxxfZ4ozJzuS8E.dXaB6pR7rUPdUT7Ny737pj2VQdiEXM6', 'bbbbbb@bbbbbb.com', 'bbbbbb', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (44, 'felixmiranda16', '$2y$10$LZjzS3zzxiFFNyq8dXCg1e/NkaJCgF4fMKeiZlcLz4xDGu8M4z9C6', 'felixmiranda16@gmail.com', 'Felix Miranda 16', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (3, 'felixmiranda1', '$2y$10$XPtUl.d2irjoKGDQTX5.eOAFJqF0T4.5wh5mf7cUnjV15B5pAvyQi', 'felixmiranda1@gmail.com', 'teste', NULL);
INSERT INTO temp.users (id, username, password, email, fullname, avatar) VALUES (43, 'test', '$2y$10$8bcl4VduJCqY9svqzv.TU.lzJHrnaJiWRyfDjH8unat5jEVc9tlAW', 'temp@gmail.com', 'qwerty', '1734182441.jpg');


--
-- TOC entry 4235 (class 0 OID 1637604)
-- Dependencies: 458
-- Data for Name: wishlist; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (1, 11);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (2, 8);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (3, 25);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (4, 28);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (5, 30);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (7, 26);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (8, 32);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (9, 33);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (10, 34);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (11, 35);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (12, 36);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (13, 37);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (14, 38);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (15, 39);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (16, 40);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (17, 41);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (18, 42);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (19, 43);
INSERT INTO temp.wishlist (id, id_authenticated_user) VALUES (20, 44);


--
-- TOC entry 4257 (class 0 OID 1837214)
-- Dependencies: 518
-- Data for Name: wishlist_product; Type: TABLE DATA; Schema: temp; Owner: temp
--

INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (3, 3, 5);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (7, 1, 6);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (10, 2, 7);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (12, 1, 7);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (14, 1, 8);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (15, 2, 8);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (16, 3, 8);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (18, 1, 9);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (19, 2, 9);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (23, 17, 13);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (24, 17, 19);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (25, 17, 21);
INSERT INTO temp.wishlist_product (id, id_wishlist, id_product) VALUES (26, 17, 26);


--
-- TOC entry 4289 (class 0 OID 0)
-- Dependencies: 452
-- Name: author_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.author_id_seq', 20, true);


--
-- TOC entry 4290 (class 0 OID 0)
-- Dependencies: 450
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.category_id_seq', 14, true);


--
-- TOC entry 4291 (class 0 OID 0)
-- Dependencies: 473
-- Name: changeOrderStatusNotification_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp."changeOrderStatusNotification_id_seq"', 2, true);


--
-- TOC entry 4292 (class 0 OID 0)
-- Dependencies: 469
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.notification_id_seq', 17, true);


--
-- TOC entry 4293 (class 0 OID 0)
-- Dependencies: 521
-- Name: orderPlacedNotification_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp."orderPlacedNotification_id_seq"', 4, true);


--
-- TOC entry 4294 (class 0 OID 0)
-- Dependencies: 467
-- Name: orderProduct_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp."orderProduct_id_seq"', 27, true);


--
-- TOC entry 4295 (class 0 OID 0)
-- Dependencies: 465
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.order_id_seq', 17, true);


--
-- TOC entry 4296 (class 0 OID 0)
-- Dependencies: 519
-- Name: payment_info_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.payment_info_id_seq', 18, true);


--
-- TOC entry 4297 (class 0 OID 0)
-- Dependencies: 477
-- Name: productOnCartPriceChangeNotification_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp."productOnCartPriceChangeNotification_id_seq"', 7, true);


--
-- TOC entry 4298 (class 0 OID 0)
-- Dependencies: 445
-- Name: productOnCartPriceChange_id_notification_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp."productOnCartPriceChange_id_notification_seq"', 1, false);


--
-- TOC entry 4299 (class 0 OID 0)
-- Dependencies: 444
-- Name: productOnCartPriceChange_id_order_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp."productOnCartPriceChange_id_order_seq"', 1, false);


--
-- TOC entry 4300 (class 0 OID 0)
-- Dependencies: 443
-- Name: productOnCartPriceChange_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp."productOnCartPriceChange_id_seq"', 1, false);


--
-- TOC entry 4301 (class 0 OID 0)
-- Dependencies: 471
-- Name: productWishlistAvailableNotification_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp."productWishlistAvailableNotification_id_seq"', 1, true);


--
-- TOC entry 4302 (class 0 OID 0)
-- Dependencies: 455
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.product_id_seq', 74, true);


--
-- TOC entry 4303 (class 0 OID 0)
-- Dependencies: 461
-- Name: review_author_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.review_author_id_seq', 1, false);


--
-- TOC entry 4304 (class 0 OID 0)
-- Dependencies: 459
-- Name: review_product_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.review_product_id_seq', 26, true);


--
-- TOC entry 4305 (class 0 OID 0)
-- Dependencies: 475
-- Name: shoppingCartProduct_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp."shoppingCartProduct_id_seq"', 132, true);


--
-- TOC entry 4306 (class 0 OID 0)
-- Dependencies: 463
-- Name: shoppingCart_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp."shoppingCart_id_seq"', 35, true);


--
-- TOC entry 4307 (class 0 OID 0)
-- Dependencies: 447
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.users_id_seq', 44, true);


--
-- TOC entry 4308 (class 0 OID 0)
-- Dependencies: 457
-- Name: wishlist_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.wishlist_id_seq', 20, true);


--
-- TOC entry 4309 (class 0 OID 0)
-- Dependencies: 517
-- Name: wishlist_product_id_seq; Type: SEQUENCE SET; Schema: temp; Owner: temp
--

SELECT pg_catalog.setval('temp.wishlist_product_id_seq', 41, true);


--
-- TOC entry 3985 (class 2606 OID 1637547)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);


--
-- TOC entry 3993 (class 2606 OID 1637576)
-- Name: authenticated_user authenticated_user_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.authenticated_user
    ADD CONSTRAINT authenticated_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3991 (class 2606 OID 1637571)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (id);


--
-- TOC entry 3987 (class 2606 OID 1637561)
-- Name: category category_categoryname_key; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.category
    ADD CONSTRAINT category_categoryname_key UNIQUE (categoryname);


--
-- TOC entry 3989 (class 2606 OID 1637559)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 4018 (class 2606 OID 1637793)
-- Name: changeOrderStatusNotification changeOrderStatusNotification_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."changeOrderStatusNotification"
    ADD CONSTRAINT "changeOrderStatusNotification_pkey" PRIMARY KEY (id);


--
-- TOC entry 4014 (class 2606 OID 1637747)
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- TOC entry 4034 (class 2606 OID 1883616)
-- Name: orderPlacedNotification orderPlacedNotification_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."orderPlacedNotification"
    ADD CONSTRAINT "orderPlacedNotification_pkey" PRIMARY KEY (id);


--
-- TOC entry 4012 (class 2606 OID 1637730)
-- Name: order_product orderProduct_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.order_product
    ADD CONSTRAINT "orderProduct_pkey" PRIMARY KEY (id);


--
-- TOC entry 4010 (class 2606 OID 1637718)
-- Name: orders order_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.orders
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- TOC entry 4036 (class 2606 OID 1904006)
-- Name: password_resets password_resets_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (email);


--
-- TOC entry 4026 (class 2606 OID 1837295)
-- Name: payment_info payment_info_cardnumber_key; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.payment_info
    ADD CONSTRAINT payment_info_cardnumber_key UNIQUE (cardnumber);


--
-- TOC entry 4028 (class 2606 OID 1837291)
-- Name: payment_info payment_info_id_authenticated_user_key; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.payment_info
    ADD CONSTRAINT payment_info_id_authenticated_user_key UNIQUE (id_authenticated_user);


--
-- TOC entry 4030 (class 2606 OID 1837293)
-- Name: payment_info payment_info_nif_key; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.payment_info
    ADD CONSTRAINT payment_info_nif_key UNIQUE (nif);


--
-- TOC entry 4032 (class 2606 OID 1837289)
-- Name: payment_info payment_info_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.payment_info
    ADD CONSTRAINT payment_info_pkey PRIMARY KEY (id);


--
-- TOC entry 4022 (class 2606 OID 1664019)
-- Name: productOnCartPriceChangeNotification productOnCartPriceChangeNotification_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productOnCartPriceChangeNotification"
    ADD CONSTRAINT "productOnCartPriceChangeNotification_pkey" PRIMARY KEY (id);


--
-- TOC entry 3977 (class 2606 OID 1250192)
-- Name: productOnCartPriceChange productOnCartPriceChange_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productOnCartPriceChange"
    ADD CONSTRAINT "productOnCartPriceChange_pkey" PRIMARY KEY (id);


--
-- TOC entry 4016 (class 2606 OID 1637776)
-- Name: productWishlistAvailableNotification productWishlistAvailableNotification_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productWishlistAvailableNotification"
    ADD CONSTRAINT "productWishlistAvailableNotification_pkey" PRIMARY KEY (id);


--
-- TOC entry 3996 (class 2606 OID 1637592)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 4004 (class 2606 OID 1637665)
-- Name: review_author review_author_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.review_author
    ADD CONSTRAINT review_author_pkey PRIMARY KEY (id);


--
-- TOC entry 4002 (class 2606 OID 1637645)
-- Name: review_product review_product_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.review_product
    ADD CONSTRAINT review_product_pkey PRIMARY KEY (id);


--
-- TOC entry 4020 (class 2606 OID 1664002)
-- Name: shoppingCartProduct shoppingCartProduct_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."shoppingCartProduct"
    ADD CONSTRAINT "shoppingCartProduct_pkey" PRIMARY KEY (id);


--
-- TOC entry 4006 (class 2606 OID 1637684)
-- Name: shoppingCart shoppingCart_id_authenticated_user_key; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."shoppingCart"
    ADD CONSTRAINT "shoppingCart_id_authenticated_user_key" UNIQUE (id_authenticated_user);


--
-- TOC entry 4008 (class 2606 OID 1637682)
-- Name: shoppingCart shoppingCart_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."shoppingCart"
    ADD CONSTRAINT "shoppingCart_pkey" PRIMARY KEY (id);


--
-- TOC entry 3979 (class 2606 OID 1637542)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3981 (class 2606 OID 1637538)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3983 (class 2606 OID 1637540)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 3998 (class 2606 OID 1637611)
-- Name: wishlist wishlist_id_authenticated_user_key; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.wishlist
    ADD CONSTRAINT wishlist_id_authenticated_user_key UNIQUE (id_authenticated_user);


--
-- TOC entry 4000 (class 2606 OID 1637609)
-- Name: wishlist wishlist_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.wishlist
    ADD CONSTRAINT wishlist_pkey PRIMARY KEY (id);


--
-- TOC entry 4024 (class 2606 OID 1837219)
-- Name: wishlist_product wishlist_product_pkey; Type: CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.wishlist_product
    ADD CONSTRAINT wishlist_product_pkey PRIMARY KEY (id);


--
-- TOC entry 3994 (class 1259 OID 1709647)
-- Name: idx_product_search_vector; Type: INDEX; Schema: temp; Owner: temp
--

CREATE INDEX idx_product_search_vector ON temp.product USING gin (search_vector);


--
-- TOC entry 4068 (class 2620 OID 1830012)
-- Name: review_product check_product_purchase; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER check_product_purchase BEFORE INSERT ON temp.review_product FOR EACH ROW EXECUTE FUNCTION temp.check_product_purchase();


--
-- TOC entry 4074 (class 2620 OID 1837207)
-- Name: shoppingCartProduct check_product_stock_in_cart_trigger; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER check_product_stock_in_cart_trigger BEFORE INSERT ON temp."shoppingCartProduct" FOR EACH ROW EXECUTE FUNCTION temp.check_product_stock_in_cart();


--
-- TOC entry 4064 (class 2620 OID 1837282)
-- Name: authenticated_user create_payment_info_after_user_registration; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER create_payment_info_after_user_registration AFTER INSERT ON temp.authenticated_user FOR EACH ROW EXECUTE FUNCTION temp.create_payment_info_after_user_registration();


--
-- TOC entry 4065 (class 2620 OID 1837203)
-- Name: authenticated_user create_wishlist_for_new_user_trigger; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER create_wishlist_for_new_user_trigger AFTER INSERT ON temp.authenticated_user FOR EACH ROW EXECUTE FUNCTION temp.create_wishlist_for_new_user();


--
-- TOC entry 4069 (class 2620 OID 1785956)
-- Name: review_product limit_one_review_per_product; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER limit_one_review_per_product BEFORE INSERT ON temp.review_product FOR EACH ROW EXECUTE FUNCTION temp.limit_one_review_per_product();


--
-- TOC entry 4070 (class 2620 OID 1883575)
-- Name: orders order_placed_notification_trigger; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER order_placed_notification_trigger AFTER INSERT ON temp.orders FOR EACH ROW EXECUTE FUNCTION temp.order_placed_notification();


--
-- TOC entry 4071 (class 2620 OID 1837333)
-- Name: orders order_status_update_trigger; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER order_status_update_trigger AFTER UPDATE ON temp.orders FOR EACH ROW EXECUTE FUNCTION temp.notify_order_status_change();


--
-- TOC entry 4075 (class 2620 OID 1837245)
-- Name: wishlist_product prevent_duplicate_wishlist_items; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER prevent_duplicate_wishlist_items BEFORE INSERT ON temp.wishlist_product FOR EACH ROW EXECUTE FUNCTION temp.prevent_duplicate_wishlist_items();


--
-- TOC entry 4066 (class 2620 OID 1837329)
-- Name: product product_price_update_trigger; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER product_price_update_trigger AFTER UPDATE ON temp.product FOR EACH ROW EXECUTE FUNCTION temp.notify_cart_product_price_change();


--
-- TOC entry 4067 (class 2620 OID 1837316)
-- Name: product product_stock_update_trigger; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER product_stock_update_trigger AFTER UPDATE ON temp.product FOR EACH ROW EXECUTE FUNCTION temp.notify_wishlist_product_available();


--
-- TOC entry 4072 (class 2620 OID 1878958)
-- Name: order_product reduce_stock_after_order; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER reduce_stock_after_order AFTER INSERT ON temp.order_product FOR EACH ROW EXECUTE FUNCTION temp.reduce_stock_after_order();


--
-- TOC entry 4073 (class 2620 OID 1878970)
-- Name: order_product remove_from_wishlist_after_order; Type: TRIGGER; Schema: temp; Owner: temp
--

CREATE TRIGGER remove_from_wishlist_after_order AFTER INSERT ON temp.order_product FOR EACH ROW EXECUTE FUNCTION temp.remove_from_wishlist_after_order();


--
-- TOC entry 4037 (class 2606 OID 1637548)
-- Name: admin admin_id_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.admin
    ADD CONSTRAINT admin_id_fkey FOREIGN KEY (id) REFERENCES temp.users(id) ON DELETE CASCADE;


--
-- TOC entry 4038 (class 2606 OID 1637577)
-- Name: authenticated_user authenticated_user_id_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.authenticated_user
    ADD CONSTRAINT authenticated_user_id_fkey FOREIGN KEY (id) REFERENCES temp.users(id) ON DELETE CASCADE;


--
-- TOC entry 4053 (class 2606 OID 1637799)
-- Name: changeOrderStatusNotification changeOrderStatusNotification_id_notification_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."changeOrderStatusNotification"
    ADD CONSTRAINT "changeOrderStatusNotification_id_notification_fkey" FOREIGN KEY (id_notification) REFERENCES temp.notification(id) ON DELETE CASCADE;


--
-- TOC entry 4054 (class 2606 OID 1637794)
-- Name: changeOrderStatusNotification changeOrderStatusNotification_id_order_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."changeOrderStatusNotification"
    ADD CONSTRAINT "changeOrderStatusNotification_id_order_fkey" FOREIGN KEY (id_order) REFERENCES temp.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4050 (class 2606 OID 1637748)
-- Name: notification notification_id_authenticated_user_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.notification
    ADD CONSTRAINT notification_id_authenticated_user_fkey FOREIGN KEY (id_authenticated_user) REFERENCES temp.authenticated_user(id) ON DELETE CASCADE;


--
-- TOC entry 4062 (class 2606 OID 1883617)
-- Name: orderPlacedNotification orderPlacedNotification_id_notification_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."orderPlacedNotification"
    ADD CONSTRAINT "orderPlacedNotification_id_notification_fkey" FOREIGN KEY (id_notification) REFERENCES temp.notification(id) ON DELETE CASCADE;


--
-- TOC entry 4063 (class 2606 OID 1883622)
-- Name: orderPlacedNotification orderPlacedNotification_id_order_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."orderPlacedNotification"
    ADD CONSTRAINT "orderPlacedNotification_id_order_fkey" FOREIGN KEY (id_order) REFERENCES temp.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4048 (class 2606 OID 1637731)
-- Name: order_product orderProduct_id_order_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.order_product
    ADD CONSTRAINT "orderProduct_id_order_fkey" FOREIGN KEY (id_order) REFERENCES temp.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4049 (class 2606 OID 1637736)
-- Name: order_product orderProduct_id_product_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.order_product
    ADD CONSTRAINT "orderProduct_id_product_fkey" FOREIGN KEY (id_product) REFERENCES temp.product(id) ON DELETE CASCADE;


--
-- TOC entry 4047 (class 2606 OID 1637719)
-- Name: orders order_id_authenticated_user_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.orders
    ADD CONSTRAINT order_id_authenticated_user_fkey FOREIGN KEY (id_authenticated_user) REFERENCES temp.authenticated_user(id) ON DELETE CASCADE;


--
-- TOC entry 4061 (class 2606 OID 1837296)
-- Name: payment_info payment_info_id_authenticated_user_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.payment_info
    ADD CONSTRAINT payment_info_id_authenticated_user_fkey FOREIGN KEY (id_authenticated_user) REFERENCES temp.authenticated_user(id) ON DELETE CASCADE;


--
-- TOC entry 4057 (class 2606 OID 1664025)
-- Name: productOnCartPriceChangeNotification productOnCartPriceChangeNotification_id_notification_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productOnCartPriceChangeNotification"
    ADD CONSTRAINT "productOnCartPriceChangeNotification_id_notification_fkey" FOREIGN KEY (id_notification) REFERENCES temp.notification(id) ON DELETE CASCADE;


--
-- TOC entry 4058 (class 2606 OID 1664020)
-- Name: productOnCartPriceChangeNotification productOnCartPriceChangeNotification_id_shopping_cart_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productOnCartPriceChangeNotification"
    ADD CONSTRAINT "productOnCartPriceChangeNotification_id_shopping_cart_fkey" FOREIGN KEY (id_shopping_cart) REFERENCES temp."shoppingCart"(id) ON DELETE CASCADE;


--
-- TOC entry 4051 (class 2606 OID 1637782)
-- Name: productWishlistAvailableNotification productWishlistAvailableNotification_id_notification_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productWishlistAvailableNotification"
    ADD CONSTRAINT "productWishlistAvailableNotification_id_notification_fkey" FOREIGN KEY (id_notification) REFERENCES temp.notification(id) ON DELETE CASCADE;


--
-- TOC entry 4052 (class 2606 OID 1637777)
-- Name: productWishlistAvailableNotification productWishlistAvailableNotification_id_wishlist_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."productWishlistAvailableNotification"
    ADD CONSTRAINT "productWishlistAvailableNotification_id_wishlist_fkey" FOREIGN KEY (id_wishlist) REFERENCES temp.wishlist(id) ON DELETE CASCADE;


--
-- TOC entry 4039 (class 2606 OID 1637598)
-- Name: product product_id_author_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.product
    ADD CONSTRAINT product_id_author_fkey FOREIGN KEY (id_author) REFERENCES temp.author(id) ON DELETE CASCADE;


--
-- TOC entry 4040 (class 2606 OID 1637593)
-- Name: product product_id_category_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.product
    ADD CONSTRAINT product_id_category_fkey FOREIGN KEY (id_category) REFERENCES temp.category(id) ON DELETE CASCADE;


--
-- TOC entry 4044 (class 2606 OID 1637671)
-- Name: review_author review_author_id_authenticated_user_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.review_author
    ADD CONSTRAINT review_author_id_authenticated_user_fkey FOREIGN KEY (id_authenticated_user) REFERENCES temp.authenticated_user(id) ON DELETE CASCADE;


--
-- TOC entry 4045 (class 2606 OID 1637666)
-- Name: review_author review_author_id_author_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.review_author
    ADD CONSTRAINT review_author_id_author_fkey FOREIGN KEY (id_author) REFERENCES temp.author(id) ON DELETE CASCADE;


--
-- TOC entry 4042 (class 2606 OID 1637651)
-- Name: review_product review_product_id_authenticated_user_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.review_product
    ADD CONSTRAINT review_product_id_authenticated_user_fkey FOREIGN KEY (id_authenticated_user) REFERENCES temp.authenticated_user(id) ON DELETE CASCADE;


--
-- TOC entry 4043 (class 2606 OID 1637646)
-- Name: review_product review_product_id_product_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.review_product
    ADD CONSTRAINT review_product_id_product_fkey FOREIGN KEY (id_product) REFERENCES temp.product(id) ON DELETE CASCADE;


--
-- TOC entry 4055 (class 2606 OID 1664008)
-- Name: shoppingCartProduct shoppingCartProduct_id_product_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."shoppingCartProduct"
    ADD CONSTRAINT "shoppingCartProduct_id_product_fkey" FOREIGN KEY (id_product) REFERENCES temp.product(id) ON DELETE CASCADE;


--
-- TOC entry 4056 (class 2606 OID 1664003)
-- Name: shoppingCartProduct shoppingCartProduct_id_shopping_cart_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."shoppingCartProduct"
    ADD CONSTRAINT "shoppingCartProduct_id_shopping_cart_fkey" FOREIGN KEY (id_shopping_cart) REFERENCES temp."shoppingCart"(id) ON DELETE CASCADE;


--
-- TOC entry 4046 (class 2606 OID 1637685)
-- Name: shoppingCart shoppingCart_id_authenticated_user_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp."shoppingCart"
    ADD CONSTRAINT "shoppingCart_id_authenticated_user_fkey" FOREIGN KEY (id_authenticated_user) REFERENCES temp.authenticated_user(id) ON DELETE CASCADE;


--
-- TOC entry 4041 (class 2606 OID 1637612)
-- Name: wishlist wishlist_id_authenticated_user_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.wishlist
    ADD CONSTRAINT wishlist_id_authenticated_user_fkey FOREIGN KEY (id_authenticated_user) REFERENCES temp.authenticated_user(id) ON DELETE CASCADE;


--
-- TOC entry 4059 (class 2606 OID 1837225)
-- Name: wishlist_product wishlist_product_id_product_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.wishlist_product
    ADD CONSTRAINT wishlist_product_id_product_fkey FOREIGN KEY (id_product) REFERENCES temp.product(id) ON DELETE CASCADE;


--
-- TOC entry 4060 (class 2606 OID 1837220)
-- Name: wishlist_product wishlist_product_id_wishlist_fkey; Type: FK CONSTRAINT; Schema: temp; Owner: temp
--

ALTER TABLE ONLY temp.wishlist_product
    ADD CONSTRAINT wishlist_product_id_wishlist_fkey FOREIGN KEY (id_wishlist) REFERENCES temp.wishlist(id) ON DELETE CASCADE;


-- Completed on 2024-12-14 17:52:12 UTC

--
-- PostgreSQL database dump complete
--

