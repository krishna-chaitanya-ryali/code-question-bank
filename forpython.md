@app.route('/download_excel/<filename>')
def download_excel(filename):
    file_path = os.path.join(FOLDER_EXCEL, filename)
    return send_file(
        file_path,
        as_attachment=True,
        download_name=filename,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )

with pd.ExcelWriter(file_location, engine="xlsxwriter") as writer:
    data.to_excel(writer, index=False, sheet_name="Sheet1")
    workbook  = writer.book
    worksheet = writer.sheets["Sheet1"]

    # column formatting loop here...

# after 'with', file is closed & flushed safely
