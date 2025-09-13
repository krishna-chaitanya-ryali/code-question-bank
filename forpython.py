@app.route("/get_security_access_report", methods=["POST"])
def get_security_access_report():
    try:
        vInfo = request.get_json()
        report_type = vInfo['reportStatus']
        rmmId = vInfo.get('rmmId')

        # Generate unique file name
        vDate = datetime.now().strftime("%d_%m_%Y_%H%M%S")
        file_name = f"security_report_{vDate}.xlsx"

        # Run Excel generation in background thread
        threading.Thread(target=download_excel_report,
                         args=(356, [rmmId], file_name, report_type)).start()

        # Return filename immediately
        return jsonify({"status": "processing", "f_name": file_name})
    except Exception as e:
        return jsonify({"status": "error", "msg": str(e)})


@app.route("/check_excel/<filename>", methods=["GET"])
def check_excel(filename):
    file_path = os.path.join(FOLDER_EXCEL, filename)
    if os.path.exists(file_path):
        return jsonify({"ready": True, "filename": filename})
    else:
        return jsonify({"ready": False})


@app.route("/download_excel/<filename>", methods=["GET"])
def download_excel(filename):
    file_path = os.path.join(FOLDER_EXCEL, filename)
    return send_file(file_path, as_attachment=True)


$.ajax({
    url: "/get_security_access_report",
    data: JSON.stringify({ def: def, reportStatus: reportType, rmmId: rmmId }),
    type: "POST",
    contentType: "application/json; charset=utf-8",
    success: function (response) {
        if (response.status === "error") {
            rapMsgBox_msg("Error in starting Security Access Report: " + response.msg);
        } else {
            var fn = response.f_name;
            rapMsgBox_msg("Report generation started. Preparing file...");

            // Start polling every 5 sec to check if file is ready
            pollForFile(fn);
        }
    },
    error: function (error) {
        rapMsgBox_msg("Error while requesting Security Access Report", error);
    }
});




function pollForFile(fn) {
    var checkInterval = setInterval(function () {
        $.ajax({
            url: "/check_excel/" + fn,
            method: "GET",
            success: function (resp) {
                if (resp.ready) {
                    clearInterval(checkInterval);

                    // File ready → trigger download
                    downloadFile(fn);
                }
            },
            error: function () {
                clearInterval(checkInterval);
                rapMsgBox_msg("Error while checking report status.");
            }
        });
    }, 5000); // check every 5 sec
}




function downloadFile(fn) {
    $.ajax({
        url: "/download_excel/" + fn,
        method: "GET",
        xhrFields: { responseType: 'blob' },
        success: function (data) {
            var a = document.createElement('a');
            var url = window.URL.createObjectURL(data);
            a.href = url;
            a.download = fn;
            document.body.appendChild(a);
            a.click();
            a.remove();
            window.URL.revokeObjectURL(url);

            rapMsgBox_msg("Successfully downloaded Security Access Report!");
        },
        error: function (error) {
            rapMsgBox_msg("Error in downloading Security Access Report", error);
        }
    });
}
