function! LogsAnalyzeCreateMatchGroup()
   syntax match LevelDebug /level=debug/ 
   syntax match LevelError /level=error/ 
   syntax match LevelWarning /level=warning/
   syntax match LevelInfo /level=info/

   syntax match ModelPattern /Device\(\.[A-Za-z0-9_]*\)\+/
   syntax match IpAddressWithPort /\(\d\{1,3}\.\)\{3}\d\{1,3}\(\d\{0,5}\)\(:\d\{1,5}\)\?/
   syntax match GetRequestTimePattern /GET : processing at time \d\{4}-\d\{2}-\d\{2}T\d\{2}:\d\{2}:\d\{2}Z/
   syntax match GetRequestTimePattern /GET_RESP sending at time \d\{4}-\d\{2}-\d\{2}T\d\{2}:\d\{2}:\d\{2}Z/

   syntax match ObuspaErrorFalse /err_code: 0/
   syntax match ObuspaErrorMsgFalse /err_msg: ""/

   syntax match ObuspaErrorTrue /err_code: [1-9][0-9]*/
   syntax match ObuspaErrorMsgTrue /err_msg: ""\zs[^"]\+/
endfunction
