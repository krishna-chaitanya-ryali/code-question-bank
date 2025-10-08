import re

input_file = "update_user_tab.sql"          # your original file
output_file = "update_user_tab_fixed.sql"   # output file

# This pattern safely matches:
# LINEMANAGER_NAME='any value (possibly with apostrophes)'
pattern = re.compile(r"(LINEMANAGER_NAME\s*=\s*')([^']*?(?:''[^']*?)*?)'")

count_fixed = 0

def escape_apostrophes(match):
    global count_fixed
    name_value = match.group(2)
    # Escape single apostrophes that aren't already doubled
    fixed_name = name_value.replace("''", "§§")  # temporary marker for existing escaped quotes
    fixed_name = fixed_name.replace("'", "''")   # escape new single quotes
    fixed_name = fixed_name.replace("§§", "''")  # restore existing doubles
    if fixed_name != name_value:
        count_fixed += 1
    return match.group(1) + fixed_name + "'"

with open(input_file, "r", encoding="utf-8") as fin, \
     open(output_file, "w", encoding="utf-8") as fout:

    for line in fin:
        if "LINEMANAGER_NAME" in line.upper():
            line = pattern.sub(escape_apostrophes, line)
        fout.write(line)

print(f"✅ Done! Escaped apostrophes in {count_fixed} line(s).")
print(f"👉 Output file created: {output_file}")
