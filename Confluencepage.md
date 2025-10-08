import re

input_file = "update_user_tab.sql"          # your input file
output_file = "update_user_tab_fixed.sql"   # fixed file

# Pattern for exact match like LINEMANAGER_NAME='...'
pattern = re.compile(r"(LINEMANAGER_NAME=')([^']*)'")

count_fixed = 0

with open(input_file, "r", encoding="utf-8") as fin, \
     open(output_file, "w", encoding="utf-8") as fout:

    for line in fin:
        if "LINEMANAGER_NAME=" in line:
            def escape_apostrophes(match):
                nonlocal count_fixed
                name_value = match.group(2)
                fixed_name = name_value.replace("'", "''")
                if name_value != fixed_name:
                    count_fixed += 1
                return match.group(1) + fixed_name + "'"

            line = pattern.sub(escape_apostrophes, line)

        fout.write(line)

print(f"✅ Done! Escaped apostrophes in {count_fixed} line(s).")
print(f"👉 Output file created: {output_file}")
