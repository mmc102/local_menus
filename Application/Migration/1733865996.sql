Update restaurants set weburl = 'google.com' where weburl is null;
ALTER TABLE restaurants ALTER COLUMN weburl SET NOT NULL;
