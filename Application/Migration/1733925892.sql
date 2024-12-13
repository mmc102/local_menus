
-- Add the new columns to the restaurants table
ALTER TABLE restaurants 
ADD COLUMN catname VARCHAR(255),
ADD COLUMN subcatname VARCHAR(255);

-- Populate the new columns with data extracted from the JSON column
UPDATE restaurants
SET 
    catname = (primary_category->>'catname'),
    subcatname = (primary_category->>'subcatname');
