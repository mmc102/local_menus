CREATE TABLE click_throughs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    restaurant_id UUID NOT NULL
);
CREATE INDEX click_throughs_created_at_index ON click_throughs (created_at);
CREATE TRIGGER update_click_throughs_updated_at BEFORE UPDATE ON click_throughs FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX click_throughs_restaurant_id_index ON click_throughs (restaurant_id);
ALTER TABLE click_throughs ADD CONSTRAINT click_throughs_ref_restaurant_id FOREIGN KEY (restaurant_id) REFERENCES restaurants (id) ON DELETE NO ACTION;
