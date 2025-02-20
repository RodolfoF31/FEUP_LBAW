DROP TABLE IF EXISTS "paymentInfo" CASCADE;
DROP TABLE IF EXISTS "productOnCartPriceChangeNotification" CASCADE;
DROP TABLE IF EXISTS "changeOrderStatusNotification" CASCADE;
DROP TABLE IF EXISTS "productWishlistAvailableNotification" CASCADE;
DROP TABLE IF EXISTS "paymentApprovedNotification" CASCADE;
DROP TABLE IF EXISTS "notification" CASCADE;
DROP TABLE IF EXISTS "orderProduct" CASCADE;
DROP TABLE IF EXISTS "order" CASCADE;
DROP TABLE IF EXISTS "shoppingCartProduct" CASCADE;
DROP TABLE IF EXISTS "shoppingCart" CASCADE;
DROP TABLE IF EXISTS "review_author" CASCADE;
DROP TABLE IF EXISTS "review_product" CASCADE;
DROP TABLE IF EXISTS "wishlistProduct" CASCADE;
DROP TABLE IF EXISTS "wishlist" CASCADE;
DROP TABLE IF EXISTS "product" CASCADE;
DROP TABLE IF EXISTS "authenticated_user" CASCADE;
DROP TABLE IF EXISTS "author" CASCADE;
DROP TABLE IF EXISTS "category" CASCADE;
DROP TABLE IF EXISTS "admin" CASCADE;
DROP TABLE IF EXISTS "users" CASCADE;
CREATE TABLE "users" (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    fullName VARCHAR(255)
);
CREATE TABLE "admin" (
    id BIGINT PRIMARY KEY REFERENCES "users"(id) ON DELETE CASCADE
);
CREATE TABLE "category" (
    id BIGSERIAL PRIMARY KEY,
    categoryName VARCHAR(255) NOT NULL UNIQUE
);
CREATE TABLE "author" (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    biography TEXT NOT NULL,
    rating INTEGER CHECK (
        rating >= 0
        AND rating <= 5
    )
);
CREATE TABLE "authenticated_user" (
    id BIGINT PRIMARY KEY REFERENCES "users"(id) ON DELETE CASCADE
);
CREATE TABLE "product" (
    id BIGSERIAL PRIMARY KEY,
    id_category BIGINT REFERENCES "category"(id) ON DELETE CASCADE NOT NULL,
    id_author BIGINT REFERENCES "author"(id) ON DELETE CASCADE NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price FLOAT NOT NULL CHECK (price >= 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),
    image BYTEA
);
--should have trigger to check size of wishlistProduct
CREATE TABLE "wishlist" (
    id BIGSERIAL PRIMARY KEY,
    id_authenticated_user BIGINT REFERENCES "authenticated_user"(id) ON DELETE CASCADE NOT NULL UNIQUE
);
CREATE TABLE "wishlistProduct" (
    id BIGSERIAL PRIMARY KEY,
    id_wishlist BIGINT REFERENCES "wishlist"(id) ON DELETE CASCADE NOT NULL,
    id_product BIGINT REFERENCES "product"(id) ON DELETE CASCADE NOT NULL,
    UNIQUE (id_wishlist, id_product)
);
CREATE TABLE "review_product" (
    id BIGSERIAL PRIMARY KEY,
    id_product BIGINT REFERENCES "product"(id) ON DELETE CASCADE NOT NULL,
    id_authenticated_user BIGINT REFERENCES "authenticated_user"(id) ON DELETE CASCADE NOT NULL,
    date DATE NOT NULL,
    comment TEXT NOT NULL,
    rating INTEGER CHECK (
        rating >= 1
        AND rating <= 5
    ) NOT NULL
);
CREATE TABLE "review_author" (
    id BIGSERIAL PRIMARY KEY,
    id_author BIGINT REFERENCES "author"(id) ON DELETE CASCADE NOT NULL,
    id_authenticated_user BIGINT REFERENCES "authenticated_user"(id) ON DELETE CASCADE NOT NULL,
    date DATE NOT NULL,
    comment TEXT NOT NULL,
    rating INTEGER CHECK (
        rating >= 1
        AND rating <= 5
    ) NOT NULL
);
CREATE TABLE "shoppingCart" (
    id BIGSERIAL PRIMARY KEY,
    id_authenticated_user BIGINT REFERENCES "authenticated_user"(id) ON DELETE CASCADE NOT NULL UNIQUE
);
CREATE TABLE "shoppingCartProduct" (
    id BIGSERIAL PRIMARY KEY,
    id_shoppingCart BIGINT REFERENCES "shoppingCart"(id) ON DELETE CASCADE NOT NULL,
    id_product BIGINT REFERENCES "product"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "order" (
    id BIGSERIAL PRIMARY KEY,
    id_authenticated_user BIGINT REFERENCES "authenticated_user"(id) ON DELETE CASCADE NOT NULL,
    orderDate DATE NOT NULL,
    arrivalDate DATE NOT NULL,
    shippedAddress VARCHAR(255) NOT NULL,
    totalPrice FLOAT NOT NULL CHECK (totalPrice >= 0),
    orderStatus VARCHAR(255) NOT NULL,
    CHECK (arrivalDate >= orderDate),
    CHECK(
        orderStatus IN (
            'processing',
            'shipped',
            'delivered',
            'in transit'
        )
    )
);
CREATE TABLE "orderProduct"(
    id BIGSERIAL PRIMARY KEY,
    id_order BIGINT REFERENCES "order"(id) ON DELETE CASCADE NOT NULL,
    id_product BIGINT REFERENCES "product"(id) ON DELETE CASCADE NOT NULL
    --quantity INTEGER NOT NULL CHECK (quantity >= 0)
);
CREATE TABLE "notification"(
    id BIGSERIAL PRIMARY KEY,
    id_authenticated_user BIGINT REFERENCES "authenticated_user"(id) ON DELETE CASCADE NOT NULL,
    text VARCHAR(255) NOT NULL
);
CREATE TABLE "paymentApprovedNotification"(
    id BIGSERIAL PRIMARY KEY,
    id_notification BIGINT REFERENCES "notification"(id) ON DELETE CASCADE NOT NULL,
    id_order BIGINT REFERENCES "order"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "productWishlistAvailableNotification"(
    id BIGSERIAL PRIMARY KEY,
    id_wishlist BIGINT REFERENCES "wishlist"(id) ON DELETE CASCADE NOT NULL,
    id_notification BIGINT REFERENCES "notification"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "changeOrderStatusNotification"(
    id BIGSERIAL PRIMARY KEY,
    id_order BIGINT REFERENCES "order"(id) ON DELETE CASCADE NOT NULL,
    id_notification BIGINT REFERENCES "notification"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "productOnCartPriceChangeNotification"(
    id BIGSERIAL PRIMARY KEY,
    id_shoppingCart BIGINT REFERENCES "shoppingCart"(id) ON DELETE CASCADE NOT NULL,
    id_notification BIGINT REFERENCES "notification"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "paymentInfo" (
    id BIGSERIAL PRIMARY KEY,
    id_authenticated_user BIGINT REFERENCES "authenticated_user"(id) ON DELETE CASCADE NOT NULL UNIQUE,
    shippedAddress VARCHAR(255) NOT NULL,
    nif VARCHAR(9) NOT NULL UNIQUE,
    cardNumber VARCHAR(16) NOT NULL UNIQUE
);



DROP FUNCTION IF EXISTS check_product_purchase() CASCADE;
CREATE FUNCTION check_product_purchase() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM "orderProduct" op
        JOIN "order" o ON o.id = op.id_order
        WHERE o.id_authenticated_user = NEW.id_authenticated_user
          AND op.id_product = NEW.id_product
    ) THEN
        RAISE EXCEPTION 'You can only review a product that you have bought';
    END IF;
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_product_purchase ON "review_product";
CREATE TRIGGER check_product_purchase
BEFORE INSERT ON "review_product"
FOR EACH ROW
EXECUTE PROCEDURE check_product_purchase();


DROP FUNCTION IF EXISTS limit_product_purchase() CASCADE;
CREATE FUNCTION limit_product_purchase() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (SELECT stock FROM "product" WHERE id = NEW.id_product) < NEW.quantity THEN
        RAISE EXCEPTION 'The solicited amount exceeds the product''s stock';
    END IF;
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS limit_product_purchase ON orderProduct;
CREATE TRIGGER limit_product_purchase
BEFORE INSERT ON "orderProduct"
FOR EACH ROW
EXECUTE PROCEDURE limit_product_purchase();

DROP FUNCTION IF EXISTS limit_one_review_per_product() CASCADE;
CREATE FUNCTION limit_one_review_per_product() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM "review_product"
        WHERE id_authenticated_user = NEW.id_authenticated_user
          AND id_product = NEW.id_product
    ) THEN
        RAISE EXCEPTION 'You already reviewed this product.';
    END IF;
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS limit_one_review_per_product ON review_product;
CREATE TRIGGER limit_one_review_per_product
BEFORE INSERT ON "review_product"
FOR EACH ROW
EXECUTE PROCEDURE limit_one_review_per_product();

DROP FUNCTION IF EXISTS reduce_stock_after_purchase() CASCADE;
CREATE FUNCTION reduce_stock_after_purchase() RETURNS TRIGGER AS
$BODY$
DECLARE
    order_product RECORD;
BEGIN
    FOR order_product IN 
        SELECT id_product, quantity
        FROM "orderProduct"
        WHERE id_order = NEW.id
    LOOP
        UPDATE "product"
        SET stock = stock - order_product.quantity
        WHERE id = order_product.id_product;
    END LOOP;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS reduce_stock_after_purchase ON "order";
CREATE TRIGGER reduce_stock_after_purchase
AFTER INSERT ON "order"
FOR EACH ROW
EXECUTE PROCEDURE reduce_stock_after_purchase();

DROP FUNCTION IF EXISTS remove_from_wishlist_after_purchase() CASCADE;
CREATE FUNCTION remove_from_wishlist_after_purchase() RETURNS TRIGGER AS
$BODY$
BEGIN
    DELETE FROM "wishlistProduct"
    WHERE id_product IN (
        SELECT id_product
        FROM "orderProduct"
        WHERE id_order = NEW.id
    ) AND id_wishlist = (
        SELECT id FROM "wishlist"
        WHERE id_authenticated_user = NEW.id_authenticated_user
    );

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS remove_from_wishlist_after_purchase ON "order";
CREATE TRIGGER remove_from_wishlist_after_purchase
AFTER INSERT ON "order"
FOR EACH ROW
EXECUTE PROCEDURE remove_from_wishlist_after_purchase();

DROP FUNCTION IF EXISTS prevent_duplicate_wishlist_items() CASCADE;
CREATE FUNCTION prevent_duplicate_wishlist_items() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM "wishlistProduct" wp
        JOIN "wishlist" w ON w.id = wp.id_wishlist
        WHERE w.id_authenticated_user = NEW.id_authenticated_user
          AND wp.id_product = NEW.id_product
    ) THEN
        RAISE EXCEPTION 'This product is already on your wishlist';
    END IF;
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS prevent_duplicate_wishlist_items ON "wishlistProduct";
CREATE TRIGGER prevent_duplicate_wishlist_items
BEFORE INSERT ON "wishlistProduct"
FOR EACH ROW
EXECUTE PROCEDURE prevent_duplicate_wishlist_items();
-- BEGIN Thingy-specific tables

-- Thingy-specific table
CREATE TABLE "cards" (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Thingy-specific table
CREATE TABLE "items" (
    id BIGSERIAL PRIMARY KEY,
    card_id BIGINT NOT NULL REFERENCES "cards"(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--Thingy--User
INSERT INTO users VALUES (
  DEFAULT,
  'John Doe',
  'admin@example.com',
  '$2y$10$HfzIhGCCaxqyaIdGgjARSuOKAcm1Uy82YfLuNaajn6JrjLWy9Sj/W'
); -- Password is 1234. Generated using Hash::make('1234')

--Thing Card Test
--Fix 1
ALTER TABLE "cards"
ALTER COLUMN "status"
SET DEFAULT 'pending';

-- Thingy-specific Test Data
INSERT INTO cards VALUES (DEFAULT, 'Things to do', 1);
INSERT INTO items VALUES (DEFAULT, 1, 'Buy milk');
INSERT INTO items VALUES (DEFAULT, 1, 'Walk the dog');

INSERT INTO cards VALUES (DEFAULT, 'Things not to do', 1);
INSERT INTO items VALUES (DEFAULT, 2, 'Break a leg');
INSERT INTO items VALUES (DEFAULT, 2, 'Crash the car');




-- END Thingy-specific tables
