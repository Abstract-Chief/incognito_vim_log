" Function to enable custom highlighting
function! EnableCustomHighlights()
    highlight LevelDebug ctermfg=LightBlue guifg=#87afaf
    highlight LevelError ctermfg=LightRed guifg=#ff5f5f
    highlight LevelWarning ctermfg=Yellow guifg=#d7af5f
    highlight LevelInfo ctermfg=LightGreen guifg=#87af87

    highlight ObuspaMessageNotify ctermfg=LightGreen guifg=#87af87
    highlight ObuspaMessageGet ctermfg=LightGreen guifg=#d7af5f
    highlight ObuspaMessageGetResp ctermfg=LightGreen guifg=#ab8029
    highlight ObuspaMessageOperate ctermfg=LightGreen guifg=#038c07
    highlight ObuspaMessageOperateResp ctermfg=LightGreen guifg=#015903

    highlight CwmpProxyTime ctermfg=Gray guifg=#808080
    highlight CwmpProxyFile ctermfg=Gray guifg=#808080
    highlight MsgPattern ctermfg=Gray guifg=#87af87

    highlight ModelPattern ctermfg=LightBlue guifg=#339733
    highlight IPAddressWithPort ctermfg=Brown guifg=#af5f3f
    highlight GetRequestTimePattern ctermfg=Yellow guifg=#ffff00

    highlight ObuspaErrorFalse ctermfg=LightBlue guifg=#99FF99
    highlight ObuspaErrorTrue ctermfg=LightBlue guifg=#ff5f5f
    highlight ObuspaErrorMsgFalse ctermfg=LightBlue guifg=#99FF99
    highlight ObuspaErrorMsgTrue ctermfg=LightBlue guifg=#ff5f5f
endfunction
function! EnableCustomHighlightsBase()
highlight LevelDebug ctermfg=Cyan guifg=Cyan
    highlight LevelError ctermfg=Red guifg=Red
    highlight LevelWarning ctermfg=Yellow guifg=Yellow
    highlight LevelInfo ctermfg=Green guifg=Green

    highlight ObuspaMessageNotify ctermfg=Cyan guifg=Cyan
    highlight ObuspaMessageGet ctermfg=Yellow guifg=Yellow
    highlight ObuspaMessageGetResp ctermfg=Blue guifg=Blue
    highlight ObuspaMessageOperate ctermfg=Green guifg=Green
    highlight ObuspaMessageOperateResp ctermfg=Blue guifg=Blue

    highlight CwmpProxyTime ctermfg=Gray guifg=Gray
    highlight CwmpProxyFile ctermfg=Gray guifg=Gray
    highlight MsgPattern ctermfg=Green guifg=Green

    highlight ModelPattern ctermfg=Cyan guifg=Cyan
    highlight IPAddressWithPort ctermfg=Magenta guifg=Magenta
    highlight GetRequestTimePattern ctermfg=Yellow guifg=Yellow

    highlight ObuspaErrorFalse ctermfg=Blue guifg=Blue
    highlight ObuspaErrorTrue ctermfg=Red guifg=Red
    highlight ObuspaErrorMsgFalse ctermfg=Blue guifg=Blue
    highlight ObuspaErrorMsgTrue ctermfg=Red guifg=Red
endfunction

" Function to disable custom highlighting
function! DisableCustomHighlights()
    highlight clear LevelDebug
    highlight clear LevelError
    highlight clear LevelWarning
    highlight clear LevelInfo

    highlight clear ObuspaMessageNotify
    highlight clear ObuspaMessageGet
    highlight clear ObuspaMessageGetResp
    highlight clear ObuspaMessageOperate
    highlight clear ObuspaMessageOperateResp

    highlight clear CwmpProxyTime
    highlight clear CwmpProxyFile
    highlight clear MsgPattern

    highlight clear ModelPattern
    highlight clear IPAddressWithPort
    highlight clear GetRequestTimePattern

    highlight clear ObuspaErrorFalse
    highlight clear ObuspaErrorTrue
    highlight clear ObuspaErrorMsgFalse
    highlight clear ObuspaErrorMsgTrue
endfunction

" Command to toggle the highlight mode
command! EnableHighlights call EnableCustomHighlights()
command! DisableHighlights call DisableCustomHighlights()

