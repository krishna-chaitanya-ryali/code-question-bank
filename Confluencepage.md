import re

input_file = "update_user_tab.sql"      # your input file
output_file = "update_user_tab_fixed.sql"  # corrected file

def escape_quotes_in_sql_line(line):
    # This regex finds anything inside single quotes
    def replacer(match):
        content = match.group(1)
        # Escape single quotes inside the string content
        content = content.replace("'", "''")
        return f"'{content}'"
    
    # Replace all text inside quotes safely
    return re.sub(r"'(.*?)'", replacer, line)

with open(input_file, "r", encoding="utf-8") as fin, \
     open(output_file, "w", encoding="utf-8") as fout:
    
    for line in fin:
        fixed_line = escape_quotes_in_sql_line(line)
        fout.write(fixed_line)
