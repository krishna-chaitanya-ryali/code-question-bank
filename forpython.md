from flask import Response

@views.route('/download_excel_report/<filename>', methods=["GET"])
def download_excel_report_route(filename):
    try:
        file_path = os.path.join(FOLDER_EXCEL, filename)

        def generate():
            with open(file_path, "rb") as f:
                while True:
                    chunk = f.read(8192)  # 8 KB at a time
                    if not chunk:
                        break
                    yield chunk

        response = Response(generate(), mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.headers["Content-Disposition"] = f"attachment; filename={filename}"
        response.headers["Content-Length"] = os.path.getsize(file_path)
        return response

    except Exception as e:
        log_error.error('Error | download_excel_report | ' + str(e))
        return "Error"
