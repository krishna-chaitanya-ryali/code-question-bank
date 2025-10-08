input_file = "update_user_tab.sql"         # your existing file
output_file = "update_user_tab_fixed.sql"  # fixed file

with open(input_file, "r", encoding="utf-8") as fin, \
     open(output_file, "w", encoding="utf-8") as fout:
    
    for line in fin:
        # Only process lines that have 'linemanager_name' in them
        if "linemanager_name" in line:
            # Find the part inside line_manager_name = '...'
            try:
                start = line.index("linemanager_name = '") + len("linemanager_name = '")
                end = line.index("'", start)
                
                name_part = line[start:end]
                # Escape single apostrophes inside the name
                fixed_name = name_part.replace("'", "''")
                
                # Rebuild the line
                line = line[:start] + fixed_name + line[end:]
            except ValueError:
                # If indexes not found properly, just leave the line unchanged
                pass
        
        fout.write(line)
