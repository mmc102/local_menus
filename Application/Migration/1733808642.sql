DROP TYPE meals;
CREATE TABLE restaurants (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    primary_category JSONB DEFAULT null,
    title TEXT DEFAULT null,
    address1 TEXT DEFAULT null,
    url TEXT DEFAULT null,
    latitude DOUBLE PRECISION DEFAULT null,
    longitude DOUBLE PRECISION DEFAULT null,
    primary_image_url TEXT DEFAULT null,
    quality_score DOUBLE PRECISION DEFAULT null,
    weburl TEXT DEFAULT null
);
CREATE INDEX restaurants_created_at_index ON restaurants (created_at);
CREATE TRIGGER update_restaurants_updated_at BEFORE UPDATE ON restaurants FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
