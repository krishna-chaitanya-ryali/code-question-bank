def download_excel_report(query_no, parameters, file_name, flag):
    try:
        file_location = os.path.join(FOLDER_EXCEL, file_name)
        xls_loc = os.path.join(FOLDER_XLS, file_name)

        # Get data
        if flag == 0:
            get_report_data = sql_getdata(query_no, parameters)
        else:
            get_report_data = sql_getdata_sap(query_no, parameters)

        data = pd.DataFrame.from_dict(get_report_data)

        # Rename columns
        data.rename(columns={
            "USER_NAME": "USER NAME",
            "EMP_ID": "EMP ID",
            "USER_ROLE_NAME": "USER ROLE",
            "RMW_DISPLAY_NAME": "RMW NAME",
            "RISK_HEADER": "RISK TYPE",
            "METRICS_DISPLAY": "METRICS NAME"
        }, inplace=True)

        # Write Excel with context manager (ensures flush & close)
        with pd.ExcelWriter(file_location, engine="xlsxwriter") as writer:
            data.to_excel(writer, index=False, sheet_name="Sheet1")

            workbook = writer.book
            worksheet = writer.sheets["Sheet1"]
            max_width = 75

            for idx, col in enumerate(data):
                series = data[col]
                max_len = max(series.astype(str).map(len).max(), len(str(col)))
                column_width = min(max_len, max_width) + 1
                worksheet.set_column(idx, idx, column_width)

                if col == "METRICS NAME" and max_len > max_width:
                    for row in range(len(data)):
                        cell_value = str(data.iloc[row, idx])
                        if len(cell_value) > max_width:
                            cell_format = workbook.add_format({"text_wrap": True})
                            worksheet.write(row + 1, idx, cell_value, cell_format)
                            worksheet.set_row(row + 1, None, cell_format)

        # Prepare response
        result = {
            "status": "Success",
            "file_loc": file_location,
            "f_name": file_name,
            "xls_loc": xls_loc
        }

        print(f"✅ File generated successfully: {result}")
        return jsonify(result)

    except Exception as e:
        log_error.error("Error | Access Report | download_excel_report | " + str(e))
        return "Error"
