def generate_excel_file(query_no, parameters, file_name, flag):
    try:
        file_location = os.path.join(FOLDER_EXCEL, file_name)

        if flag == 0:
            get_report_data = sql_getdata(query_no, parameters)
        else:
            get_report_data = sql_getdata_sap(query_no, parameters)

        data = pd.DataFrame.from_dict(get_report_data, orient='columns')
        data.rename(columns={
            'USER_NAME': 'USER NAME',
            'EMP_ID': 'EMP ID',
            'USER_ROLE_NAME': 'USER ROLE',
            'RMM_DISPLAY_NAME': 'RMM NAME',
            'RISK_HEADER': 'RISK TYPE',
            'METRICS_DISP': 'METRICS NAME'
        }, inplace=True)

        with pd.ExcelWriter(file_location, engine="xlsxwriter") as writer:
            data.to_excel(writer, index=False, sheet_name="Sheet1")
            worksheet = writer.sheets["Sheet1"]
            workbook = writer.book

            max_width = 75
            for idx, col in enumerate(data):
                series = data[col]
                max_len = max(len(str(x)) for x in series)
                col_width = min(max_len, max_width) + 1
                worksheet.set_column(idx, idx, col_width)

        log_debug.debug(f"File generated: {file_location}")

    except Exception as e:
        log_error.error("Error | generate_excel_file | " + str(e))



@views.route('/get_security_access_report', methods=["POST"])
def get_security_access_report():
    try:
        vInfo = reqs.get_json()
        report_type = vInfo['reportStatus']
        vDate = datetime.datetime.now().strftime("%d_%m_%Y%H%M%S")

        if report_type == 0:
            file_name = f"Generic_security_report_{vDate}.xlsx"
            query_no, parameters = 355, []
        else:
            rmm_id_lst = [int(st) for st in vInfo['rmmId']]
            file_name = f"Individual_security_report_{vDate}.xlsx"
            query_no, parameters = 356, rmm_id_lst

        # Start background thread
        threading.Thread(
            target=generate_excel_file,
            args=(query_no, parameters, file_name, report_type),
            daemon=True
        ).start()

        return jsonify({"status": "processing", "f_name": file_name})

    except Exception as e:
        log_error.error("Error | get_security_access_report | " + str(e))
        return jsonify({"status": "error", "msg": str(e)})







@views.route('/check_excel/<filename>', methods=["GET"])
def check_excel(filename):
    file_path = os.path.join(FOLDER_EXCEL, filename)
    return jsonify({"ready": os.path.exists(file_path), "filename": filename})





@views.route('/download_excel_report/<filename>', methods=["GET"])
def download_excel_report_route(filename):   # renamed to avoid clash
    try:
        file_path = os.path.join(FOLDER_EXCEL, filename)
        return send_file(
            file_path,
            as_attachment=True,
            download_name=filename,
            mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        )
    except Exception as e:
        log_error.error('Error | download_excel_report | ' + str(e))
        return "Error"




        
