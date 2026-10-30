
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    sku VARCHAR(30) UNIQUE NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INTEGER NOT NULL DEFAULT 0
        CHECK (stock_quantity >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO products (name, sku, price, stock_quantity)
VALUES
    ('Wireless Mouse', 'TECH-MOUSE-001', 24.99, 10),
    ('Mechanical Keyboard', 'TECH-KEYBOARD-001', 79.99, 5),
    ('USB-C Cable', 'TECH-CABLE-001', 9.99, 20)
ON CONFLICT (sku) DO NOTHING;

CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO customers (first_name, last_name, email)
VALUES
    ('Sarah', 'Johnson', 'sarah.johnson@example.com'),
    ('James', 'Wilson', 'james.wilson@example.com'),
    ('Emily', 'Brown', 'emily.brown@example.com')
ON CONFLICT (email) DO NOTHING;

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL
        REFERENCES customers(id),
    order_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'confirmed', 'cancelled')),
    total_amount NUMERIC(10, 2) NOT NULL DEFAULT 0
        CHECK (total_amount >= 0)
);

CREATE TABLE IF NOT EXISTS order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL
        REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL
        REFERENCES products(id),
    quantity INTEGER NOT NULL
        CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL
        CHECK (unit_price >= 0),
    UNIQUE (order_id, product_id)
);
