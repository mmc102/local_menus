CREATE TABLE menu_clicks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    restaurant_id UUID NOT NULL
);
CREATE INDEX menu_clicks_restaurant_id_index ON menu_clicks (restaurant_id);
ALTER TABLE menu_clicks ADD CONSTRAINT menu_clicks_ref_restaurant_id FOREIGN KEY (restaurant_id) REFERENCES restaurants (id) ON DELETE NO ACTION;
