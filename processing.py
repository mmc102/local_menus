import json
import os

# Load the JSON file
file_path = os.path.join(os.getcwd(), "raw_data.json")


# Function to generate SQL INSERT statements
def generate_insert_statement(table_name, data):
    # Remove `recid` from the data
    if "recid" in data:
        del data["recid"]

    # Escape single quotes in string values
    def escape(value):
        if isinstance(value, str):
            return value.replace("'", "''")
        return value

    # Separate columns and values
    columns = []
    values = []
    for key, value in data.items():
        columns.append(key)
        if isinstance(value, dict):  # Convert dictionaries to JSON strings
            values.append(f"'{json.dumps(value).replace('\"', '\"')}'::jsonb")
        elif isinstance(value, str):  # Escape strings
            values.append(f"'{escape(value)}'")
        elif value is None:  # NULL values
            values.append("NULL")
        else:  # Numeric values
            values.append(str(value))

    columns_clause = ", ".join(columns)
    values_clause = ", ".join(values)
    return f"INSERT INTO {table_name} ({columns_clause}) VALUES ({values_clause});"


# Main script
def main():
    # Load the JSON data from the file
    try:
        with open(file_path, "r") as file:
            raw_data = json.load(file)
    except FileNotFoundError:
        print(f"Error: File {file_path} not found.")
        return
    except json.JSONDecodeError as e:
        print(f"Error: Failed to parse JSON. {e}")
        return

    # Extract documents
    docs = raw_data.get("docs", {}).get("docs", [])
    if not docs:
        print("Error: No documents found in the JSON structure.")
        return

    # Generate SQL statements
    table_name = "restaurants"
    sql_statements = []
    for doc in docs:
        try:
            sql_statements.append(generate_insert_statement(table_name, doc))
        except ValueError as e:
            print(f"Skipping entry due to error: {e}")

    # Output SQL statements
    if sql_statements:
        with open("insert_statements.sql", "w") as output_file:
            output_file.write("\n".join(sql_statements))
        print(f"SQL statements written to insert_statements.sql")
    else:
        print("No valid SQL statements generated.")


if __name__ == "__main__":
    main()
