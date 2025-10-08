import re

input_file = "update_user_tab.sql"          # your input file
output_file = "update_user_tab_fixed.sql"   # fixed file

# Match LINEMANAGER_NAME = 'anything_here'
pattern = re.compile(r"(LINEMANAGER_NAME\s*=\s*')([^']*)'")

count_fixed = 0

with open(input_file, "r", encoding="utf-8") as fin, \
     open(output_file, "w", encoding="utf-8") as fout:
    
    for line in fin:
        if "LINEMANAGER_NAME" in line:
            def escape_apostrophes(match):
                global count_fixed
                name = match.group(2)
                fixed = name.replace("'", "''")
                if name != fixed:
                    count_fixed += 1
                return match.group(1) + fixed + "'"
            
            # Apply fix
            line = pattern.sub(escape_apostrophes, line)
        
        fout.write(line)

print(f"✅ Done! Escaped apostrophes in {count_fixed} line(s).")
print(f"👉 Output file: {output_file}")
