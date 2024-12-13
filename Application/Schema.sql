CREATE FUNCTION set_updated_at_to_now() RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language plpgsql;
CREATE TABLE restaurants (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    primary_category JSONB,
    title TEXT NOT NULL,
    address1 TEXT,
    url TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    primary_image_url TEXT,
    quality_score DOUBLE PRECISION,
    weburl TEXT DEFAULT '' NOT NULL,
    yelp TEXT,
    listingudfs_object TEXT DEFAULT NULL,
    taid TEXT DEFAULT NULL,
    subcatname TEXT NOT NULL,
    catname TEXT NOT NULL
);
CREATE INDEX restaurants_created_at_index ON restaurants (created_at);
CREATE TRIGGER update_restaurants_updated_at BEFORE UPDATE ON restaurants FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE TABLE click_throughs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    restaurant_id UUID NOT NULL
);
CREATE INDEX click_throughs_created_at_index ON click_throughs (created_at);
CREATE TRIGGER update_click_throughs_updated_at BEFORE UPDATE ON click_throughs FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX click_throughs_restaurant_id_index ON click_throughs (restaurant_id);
ALTER TABLE click_throughs ADD CONSTRAINT click_throughs_ref_restaurant_id FOREIGN KEY (restaurant_id) REFERENCES restaurants (id) ON DELETE NO ACTION;
