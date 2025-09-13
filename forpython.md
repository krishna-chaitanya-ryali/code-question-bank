$.ajax({
    url: "/download_excel/" + fn,
    method: "GET",
    xhr: function () {
        var xhr = new XMLHttpRequest();
        xhr.responseType = "blob";   // force blob
        return xhr;
    },
    success: function (data) {
        var blob = new Blob([data], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
        var url = window.URL.createObjectURL(blob);
        var a = document.createElement('a');
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
