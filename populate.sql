
INSERT INTO "users" (username, password, email, fullName)
VALUES (
        'user1',
        'password1',
        'user1@example.com',
        'User One'
    ),
    (
        'user2',
        'password2',
        'user2@example.com',
        'User Two'
    ),
    (
        'admin1',
        'adminpassword',
        'admin@example.com',
        'Admin User'
    );
INSERT INTO "admin" (id)
VALUES (3);
INSERT INTO "authenticated_user" (id)
VALUES (1),
    (2);
INSERT INTO "category" (categoryName)
VALUES ('Horror'),
    ('Comics'),
    ('Educational');
INSERT INTO "author" (name, biography, rating)
VALUES ('Author One', 'Biography of Author One', 4),
    ('Author Two', 'Biography of Author Two', 5);
INSERT INTO "product" (
        id_category,
        id_author,
        title,
        description,
        price,
        stock,
        image
    )
VALUES (
        1,
        1,
        'Book Title 1',
        'Description of Book 1',
        19.99,
        100,
        NULL
    ),
    (
        2,
        2,
        'Book Title 2',
        'Description of Electronics Item 1',
        299.99,
        50,
        NULL
    ),
    (
        3,
        1,
        'Book Title 3',
        'Description of Clothing Item 1',
        39.99,
        200,
        NULL
    );
