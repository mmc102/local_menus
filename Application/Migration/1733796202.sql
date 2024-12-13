CREATE TYPE meals AS ENUM ('lunch', 'dinner', 'breakfast');
CREATE TABLE restaurant (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);
CREATE TABLE menu_items (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    menu_id UUID NOT NULL,
    name TEXT NOT NULL,
    price REAL NOT NULL,
    description TEXT DEFAULT null
);
CREATE TABLE menu (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    restaurant_id UUID NOT NULL,
    meal meals NOT NULL
);
CREATE INDEX menu_restaurant_id_index ON menu (restaurant_id);
CREATE INDEX menu_items_menu_id_index ON menu_items (menu_id);
ALTER TABLE menu_items ADD CONSTRAINT menu_items_ref_menu_id FOREIGN KEY (menu_id) REFERENCES menu (id) ON DELETE NO ACTION;
ALTER TABLE menu ADD CONSTRAINT menu_ref_restaurant_id FOREIGN KEY (restaurant_id) REFERENCES restaurant (id) ON DELETE NO ACTION;
