fetch("/download_excel/" + fn, { credentials: 'same-origin' })
  .then(resp => {
    if (!resp.ok) throw new Error("Network response was not ok: " + resp.status);
    // optional: log headers for debugging
    console.log('Content-Length:', resp.headers.get('Content-Length'));
    return resp.blob();
  })
  .then(blob => {
    const blobUrl = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = blobUrl;
    a.download = fn;
    document.body.appendChild(a);
    a.click();
    a.remove();
    window.URL.revokeObjectURL(blobUrl);
    rapMsgBox_msg("Successfully downloaded Security Access Report!");
  })
  .catch(err => {
    console.error(err);
    rapMsgBox_msg("Error in downloading Security Access Report: " + err.message);
  });
