import re

input_file = "update_user_tab.sql"
output_file = "update_user_tab_fixed.sql"

# Pattern to match LINEMANAGER_NAME='any content'
pattern = re.compile(r"(LINEMANAGER_NAME=')([^']*)'")

count_fixed = 0

def fix_name(match):
    global count_fixed
    name = match.group(2)
    # Replace single apostrophes with double apostrophes
    fixed_name = name.replace("'", "''")
    if fixed_name != name:
        count_fixed += 1
    return match.group(1) + fixed_name + "'"

with open(input_file, "r", encoding="utf-8") as fin, \
     open(output_file, "w", encoding="utf-8") as fout:
    
    for line in fin:
        if "LINEMANAGER_NAME=" in line.upper():
            line = pattern.sub(fix_name, line)
        fout.write(line)

print(f"✅ Done! Escaped apostrophes in {count_fixed} line(s).")
print(f"👉 Output file: {output_file}")


fixed_name = name.replace("'", "")  # instead of .replace("'", "''")
