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
    fullname VARCHAR(255),
    isbanned
    avatar TEXT
);
CREATE TABLE "admin" (
    id BIGINT PRIMARY KEY REFERENCES "users"(id) ON DELETE CASCADE
);
CREATE TABLE "category" (
    id BIGSERIAL PRIMARY KEY,
    categoryname VARCHAR(255) NOT NULL UNIQUE
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
    image TEXT,
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
    id_shopping_cart BIGINT REFERENCES "shoppingCart"(id) ON DELETE CASCADE NOT NULL,
    id_product BIGINT REFERENCES "product"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "orders" (
    id BIGSERIAL PRIMARY KEY,
    id_authenticated_user BIGINT REFERENCES "authenticated_user"(id) ON DELETE CASCADE NOT NULL,
    orderdate DATE NOT NULL,
    arrivaldate DATE NOT NULL,
    shippedaddress VARCHAR(255) NOT NULL,
    totalprice FLOAT NOT NULL CHECK (totalPrice >= 0),
    orderstatus VARCHAR(255) NOT NULL,
    CHECK (arrivaldate >= orderdate),
    CHECK(
        orderstatus IN (
            'processing',
            'shipped',
            'delivered',
            'in transit'
        )
    )
);
CREATE TABLE "order_product"(
    id BIGSERIAL PRIMARY KEY,
    id_order BIGINT REFERENCES "orders"(id) ON DELETE CASCADE NOT NULL,
    id_product BIGINT REFERENCES "product"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "notification" (
    id BIGSERIAL PRIMARY KEY,
    id_authenticated_user BIGINT REFERENCES "authenticated_user"(id) ON DELETE CASCADE NOT NULL,
    text VARCHAR(255) NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE "productOnCartPriceChangeNotification"(
    id BIGSERIAL PRIMARY KEY,
    id_shopping_cart BIGINT REFERENCES "shoppingCart"(id) ON DELETE CASCADE NOT NULL,
    id_notification BIGINT REFERENCES "notification"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "orderPlacedNotification"(
    id BIGSERIAL PRIMARY KEY,
    id_notification BIGINT REFERENCES "notification"(id) ON DELETE CASCADE NOT NULL,
    id_order BIGINT REFERENCES "orders"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "productWishlistAvailableNotification"(
    id BIGSERIAL PRIMARY KEY,
    id_wishlist BIGINT REFERENCES "wishlist"(id) ON DELETE CASCADE NOT NULL,
    id_notification BIGINT REFERENCES "notification"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "changeOrderStatusNotification"(
    id BIGSERIAL PRIMARY KEY,
    id_order BIGINT REFERENCES "orders"(id) ON DELETE CASCADE NOT NULL,
    id_notification BIGINT REFERENCES "notification"(id) ON DELETE CASCADE NOT NULL
);
CREATE TABLE "payment_info" (
    id BIGSERIAL PRIMARY KEY,
    id_authenticated_user BIGINT REFERENCES "authenticated_user"(id) ON DELETE CASCADE NOT NULL UNIQUE,
    shippedaddress VARCHAR(255) NOT NULL,
    nif VARCHAR(9) NOT NULL UNIQUE,
    cardnumber VARCHAR(16) NOT NULL UNIQUE
);


DROP FUNCTION IF EXISTS check_product_purchase() CASCADE;
CREATE FUNCTION check_product_purchase() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM "order_product" op
        JOIN "orders" o ON o.id = op.id_order
        WHERE o.id_authenticated_user = NEW.id_authenticated_user
          AND op.id_product = NEW.id_product
    ) THEN
        INSERT INTO "notification" (id_authenticated_user, text)
        VALUES (
            NEW.id_authenticated_user,
            'You can only review a product that you have bought'
        );
    ELSE
        RETURN NEW;
    END IF;
    RETURN NULL;
END

DROP TRIGGER IF EXISTS check_product_purchase ON "review_product";
CREATE TRIGGER check_product_purchase
BEFORE INSERT ON "review_product"
FOR EACH ROW
EXECUTE PROCEDURE check_product_purchase();


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
        -- Insert a notification when the user tries to review a product they have already reviewed
        INSERT INTO "notification" (id_authenticated_user, text)
        VALUES (
            NEW.id_authenticated_user,
            'You have already reviewed this product.'
        );
    ELSE
        RETURN NEW;
    END IF;
    RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS limit_one_review_per_product ON "review_product";
CREATE TRIGGER limit_one_review_per_product
BEFORE INSERT ON "review_product"
FOR EACH ROW
EXECUTE PROCEDURE limit_one_review_per_product();



thisoneDROP FUNCTION IF EXISTS reduce_stock_after_order() CASCADE;
CREATE FUNCTION reduce_stock_after_order() RETURNS TRIGGER AS
$BODY$
DECLARE
    product_id INT;
BEGIN
    FOR product_id IN 
        SELECT id_product
        FROM "order_product"
        WHERE id_order = NEW.id
    LOOP
        UPDATE "product"
        SET stock = stock - 1
        WHERE id = product_id;
    END LOOP;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS reduce_stock_after_order ON "order_product";
CREATE TRIGGER reduce_stock_after_order
AFTER INSERT ON "order_product"
FOR EACH ROW
EXECUTE PROCEDURE reduce_stock_after_order();


thisoneDROP FUNCTION IF EXISTS remove_from_wishlist_after_order() CASCADE;
CREATE FUNCTION remove_from_wishlist_after_order() RETURNS TRIGGER AS
$BODY$
DECLARE
    order_product RECORD;
BEGIN
    FOR order_product IN 
        SELECT id_product
        FROM "order_product"
        WHERE id_order = NEW.id
    LOOP
        DELETE FROM "wishlist_product"
        WHERE id_product = order_product.id_product
          AND id_wishlist = (
              SELECT id
              FROM "wishlist"
              WHERE id_authenticated_user = NEW.id_authenticated_user
          );
    END LOOP;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS remove_from_wishlist_after_order ON "orders";
CREATE TRIGGER remove_from_wishlist_after_order
AFTER INSERT ON "orders"
FOR EACH ROW
EXECUTE PROCEDURE remove_from_wishlist_after_order();


DROP FUNCTION IF EXISTS prevent_duplicate_wishlist_items() CASCADE;
CREATE FUNCTION prevent_duplicate_wishlist_items() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM "wishlist_product" wp
        WHERE wp.id_product = NEW.id_product
          AND wp.id_wishlist = NEW.id_wishlist
    ) THEN
        RAISE EXCEPTION 'This product is already on your wishlist';
    END IF;
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS prevent_duplicate_wishlist_items ON "wishlist_product";
CREATE TRIGGER prevent_duplicate_wishlist_items
BEFORE INSERT ON "wishlist_product"
FOR EACH ROW
EXECUTE PROCEDURE prevent_duplicate_wishlist_items();


DROP FUNCTION IF EXISTS create_wishlist_for_new_user() CASCADE;
CREATE FUNCTION create_wishlist_for_new_user() RETURNS TRIGGER AS
$BODY$
BEGIN
    INSERT INTO "wishlist" (id_authenticated_user)
    VALUES (NEW.id);

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS create_wishlist_for_new_user_trigger ON "authenticated_user";
CREATE TRIGGER create_wishlist_for_new_user_trigger
AFTER INSERT ON "authenticated_user"
FOR EACH ROW
EXECUTE PROCEDURE create_wishlist_for_new_user();


DROP FUNCTION IF EXISTS check_product_stock_in_cart() CASCADE;
CREATE FUNCTION check_product_stock_in_cart() RETURNS TRIGGER AS
$BODY$
DECLARE
    current_stock INTEGER;
    current_cart_quantity INTEGER;
BEGIN
    SELECT stock INTO current_stock
    FROM "product"
    WHERE id = NEW.id_product;

    SELECT COUNT(*) INTO current_cart_quantity
    FROM "shoppingCartProduct"
    WHERE id_shopping_cart = NEW.id_shopping_cart
      AND id_product = NEW.id_product;

    IF current_cart_quantity + 1 > current_stock THEN
        RAISE EXCEPTION 'Cannot add more of this product to the cart. Not enough stock available.';
    END IF;

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_product_stock_in_cart_trigger ON "shoppingCartProduct";
CREATE TRIGGER check_product_stock_in_cart_trigger
BEFORE INSERT ON "shoppingCartProduct"
FOR EACH ROW
EXECUTE PROCEDURE check_product_stock_in_cart();


DROP FUNCTION IF EXISTS create_payment_info_after_user_registration() CASCADE;
CREATE FUNCTION create_payment_info_after_user_registration() RETURNS TRIGGER AS
$BODY$
BEGIN
    INSERT INTO "payment_info" (id_authenticated_user, shippedaddress, nif, cardnumber)
    VALUES (NEW.id, NULL, NULL, NULL);
    
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS create_payment_info_after_user_registration ON "authenticated_user";
CREATE TRIGGER create_payment_info_after_user_registration
AFTER INSERT ON "authenticated_user"
FOR EACH ROW
EXECUTE PROCEDURE create_payment_info_after_user_registration();


DROP FUNCTION IF EXISTS notify_wishlist_product_available() CASCADE;
CREATE FUNCTION notify_wishlist_product_available() RETURNS TRIGGER AS
$BODY$
DECLARE
    wishlist_record RECORD;
    notification_id BIGINT;
BEGIN
    IF NEW.stock > 0 AND OLD.stock = 0 THEN
        FOR wishlist_record IN
            SELECT w.id_authenticated_user, wp.id_wishlist
            FROM "wishlist_product" wp
            JOIN "wishlist" w ON w.id = wp.id_wishlist
            WHERE wp.id_product = NEW.id
        LOOP
            INSERT INTO "notification" (id_authenticated_user, text)
            VALUES (wishlist_record.id_authenticated_user, 'The product ' || NEW.title || ' is now available!');

            notification_id = currval('notification_id_seq');

            INSERT INTO "productWishlistAvailableNotification" (id_wishlist, id_notification)
            VALUES (wishlist_record.id_wishlist, notification_id);
        END LOOP;
    END IF;

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS product_stock_update_trigger ON "product";
CREATE TRIGGER product_stock_update_trigger
AFTER UPDATE ON "product"
FOR EACH ROW
EXECUTE PROCEDURE notify_wishlist_product_available();


DROP FUNCTION IF EXISTS notify_cart_product_price_change() CASCADE;
CREATE FUNCTION notify_cart_product_price_change()
RETURNS TRIGGER AS $BODY$
DECLARE
    cart_record RECORD;
BEGIN
    IF NEW.price <> OLD.price THEN
        FOR cart_record IN
            SELECT DISTINCT sc.id_authenticated_user
            FROM "shoppingCartProduct" scp
            JOIN "shoppingCart" sc ON sc.id = scp.id_shopping_cart
            WHERE scp.id_product = NEW.id
        LOOP
            INSERT INTO "notification" (id_authenticated_user, text)
            VALUES (
                cart_record.id_authenticated_user,
                'The price of product ' || NEW.title || ' has changed to ' || NEW.price || '$!'
            );
        END LOOP;
    END IF;

    RETURN NULL;
END;
$BODY$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS product_price_update_trigger ON "product";
CREATE TRIGGER product_price_update_trigger
AFTER UPDATE ON "product"
FOR EACH ROW
EXECUTE PROCEDURE notify_cart_product_price_change();



DROP FUNCTION IF EXISTS notify_order_status_change() CASCADE;
CREATE FUNCTION notify_order_status_change() RETURNS TRIGGER AS
$BODY$
DECLARE
    notification_id BIGINT;
BEGIN
    IF NEW.orderstatus <> OLD.orderstatus THEN
        INSERT INTO "notification" (id_authenticated_user, text)
        VALUES (NEW.id_authenticated_user, 'Your order status has been updated to: ' || NEW.orderstatus);

        notification_id = currval('notification_id_seq');

        INSERT INTO "changeOrderStatusNotification" (id_order, id_notification)
        VALUES (NEW.id, notification_id);
    END IF;

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS order_status_update_trigger ON "orders";
CREATE TRIGGER order_status_update_trigger
AFTER UPDATE ON "orders"
FOR EACH ROW
EXECUTE PROCEDURE notify_order_status_change();