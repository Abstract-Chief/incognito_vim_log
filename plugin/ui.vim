let g:MessagesPanelMessages = []
let g:MessagesPanelFlags = ['m','t']
let g:MessagesPanelLastSearch="null"
let g:MessagesPanelBufferID=0
let g:MessagesPanelID=0
let g:MessagesPanelPatterContinue=[]

function! MessagePanelGetLineId(line)
   let l:line=a:line-3
   let l:cur=0
   for l:msg in g:MessagesPanelMessages[0]
      if MessagePanelPatternCheck(l:msg[0])
         continue
      endif
      if l:line == l:cur
         return l:msg[0]
      endif
      let l:cur=l:cur+1
   endfor
   return "null"
endfunction
function! MessagePanelGetMsgId(line)
   let l:data=split(a:line, ' ')
   if len(l:data) < 2
      return "null"
   endif
   return l:data[0]
endfunction
function! MessagesPanelCreateBuffer()
   botright vsplit
   enew
   let l:size=3
   let l:sizes=[12, 20]
   if index(g:MessagesPanelFlags, 'i') != -1  "msg_type
      let l:size=g:MessagesPanelMessages[1]+3
   endif
   if index(g:MessagesPanelFlags, 'm') != -1  "msg_type
      let l:size=l:size+l:sizes[0]+1
   endif
   if index(g:MessagesPanelFlags, 'd') != -1  "msg_type
      let l:size=l:size+g:MessagesPanelMessages[2]+1
   endif
   if index(g:MessagesPanelFlags, 't') != -1  "msg_type
      let l:size=l:size+l:sizes[1]+1
   endif
   execute "vertical resize ". l:size
endfunction
function! MessagePanelSetText(find_id)
   call setline(1, ['Obuspa Messages','Guide: ?','----------------'])
   let l:ids=g:MessagesPanelMessages[0]
   let l:max_id_size=g:MessagesPanelMessages[1]
   let l:max_data_size=g:MessagesPanelMessages[2]
   let l:lines = []
   let l:sizes=[l:max_id_size, 12, 11,l:max_data_size]
   if g:MessagesPanelFlags==[]
      return 0
   endif
   for id in l:ids
      if MessagePanelPatternCheck(id[0])
         continue
      endif
      if a:find_id != "null" && id[0] != a:find_id 
         continue
      endif
      let l:info=[]
      if index(g:MessagesPanelFlags, 'i') != -1  "msg_type
         call add(l:info, [id[0],l:sizes[0]])
      endif
      if index(g:MessagesPanelFlags, 'm') != -1  "msg_type
         call add(l:info, [id[1],l:sizes[1]])
      endif
      if index(g:MessagesPanelFlags, 't') != -1  "msg_type
         call add(l:info, [id[2],l:sizes[2]])
      endif
      if index(g:MessagesPanelFlags, 'd') != -1  "data
         if id[3] != {}
            call add(l:info, [id[3]["first_param"],l:sizes[3]])
         endif
      endif
      let str="none"
      let l:count=len(l:info)
      if l:count == 4
         let l:str=printf('%-'.l:info[0][1].'s %-'.l:info[1][1].'s %-'.l:info[2][1].'s %-'.l:info[3][1].'s', l:info[0][0],l:info[1][0],l:info[2][0],l:info[3][0])
      elseif l:count == 3
         let l:str=printf('%-'.l:info[0][1].'s %-'.l:info[1][1].'s %-'.l:info[2][1].'s', l:info[0][0],l:info[1][0],l:info[2][0])
      elseif l:count == 2
         let l:str=printf('%-'.l:info[0][1].'s %-'.l:info[1][1].'s', l:info[0][0],l:info[1][0])
      else
         let l:str=printf('%-'.l:info[0][1].'s', l:info[0][0])
      endif
      call add(l:lines, l:str)
   endfor
   if line('$')>3
      execute '3,$d'
   endif
   call setline(3, l:lines)
endfunction
function! PanelClearPattern()
   let g:MessagesPanelPatterContinue=[]
endfunction
function! PanelAddPattern(pattern)
   let g:MessagesPanelLastPlugLines=[]
   call add(g:MessagesPanelPatterContinue, a:pattern)
   call MessagePanelSetText("null")
endfunction
function! MessagePanelPatternCheck(id)
   for l:pattern in g:MessagesPanelPatterContinue
      if matchstr(a:id, l:pattern) != ""
         return 1
      endif
   endfor
   return 0
endfunction
function! MessagePanelSetCursor(id)
   if a:id != "null"
      let l:found = search(a:id)
   endif
endfunction

function! MessagePanelHandleSearchFullNoStep()
   let l:id=MessagePanelGetLineId(line('.'))
   let l:my_id=win_getid()
   call MessagePanelHandleSearchFull()
   call win_gotoid(l:my_id)
   call MessagePanelSetCursor(l:id)
endfunction

function! MessagePanelHandleRefreshFull()
   call MessagePanelHandleRefresh()
   call win_gotoid(g:MessagesPanelBufferID)
   normal! zR
endfunction
function! MessagePanelHandleSearchFull()
   let l:id=MessagePanelHandleSearch()
   if l:id != ""
      call win_gotoid(g:MessagesPanelBufferID)
      call FindMessages(l:id)
   endif
endfunction

function! MessagePanelHandleRefresh()
   let l:id=MessagePanelGetLineId(line('.'))
   call MessagePanelSetText("null")
   call MessagePanelSetCursor(l:id)
endfunction
function! MessagePanelHandleSearch()
   if g:MessagesPanelLastSearch == "null"
      let l:msg_id=MessagePanelGetLineId(line('.'))
      call MessagePanelSetText(l:msg_id)
      return l:msg_id
   endif
   return ""
endfunction

function! MessagePanelHelp()
   echo "*  S - Search message and transition to the file"
   echo "*  R - Refresh message and transition to the file"
   echo "*  ENTER - Search message only in file"
   echo "*  qs - Search message"
   echo "*  r - Refresh message"
   echo "*  Q - Quit"
   echo "*  ? - Help"
endfunction
let g:MessagesPanelLastPlugLines=[]
function! MessagePanelHandleMove()
   if g:MessagesPanelLastPlugLines != []
      for line in g:MessagesPanelLastPlugLines
         call setline(line, getline(line)[2:])
      endfor
   endif
   let l:id=MessagePanelGetLineId(line('.'))
   if l:id == "null"
      return
   endif
   let l:lines=[]
   let l:i=0
   for l:msg in g:MessagesPanelMessages[0]
      if MessagePanelPatternCheck(l:msg[0])
         continue
      endif
      if l:msg[0] == l:id
         call add(l:lines, l:i+3)
      endif
      let l:i=l:i+1
   endfor
   let g:MessagesPanelLastPlugLines=l:lines
   echo l:lines
   if l:lines == []
      return
   endif
   for line in l:lines
      call setline(line,"+ ".getline(line))
   endfor
endfunction
function! MessagePanelHandleDown()
   call cursor(line('.')+1,1)
   call MessagePanelHandleMove()
endfunction
function! MessagePanelHandleUp()
   call cursor(line('.')-1,1)
   call MessagePanelHandleMove()
endfunction
function! MessagesPanelSetSettings()
   setlocal buftype=nofile
   setlocal bufhidden=hide
   setlocal noswapfile
   setlocal nonumber

   set cursorline
   hi CursorLine   cterm=NONE ctermbg=DarkGrey ctermfg=White guibg=Gray guifg=White
   setlocal cursorline
   autocmd BufEnter <buffer> setlocal cursorline
   autocmd BufLeave <buffer> setlocal nocursorline

   if index(g:MessagesPanelFlags, 'uc') != -1  "msg_type
      call EnableCustomHighlights()
   else
      call EnableCustomHighlightsBase()
   endif

   call matchadd('ObuspaMessageNotify', '.*NOTIFY.*', 10, 331)
   call matchadd('ObuspaMessageGet', '.*GET.*', 10, 332)
   call matchadd('ObuspaMessageGetResp', '.*GET_RESP.*', 10, 333)
   call matchadd('ObuspaMessageOperate', '.*OPERATE.*', 10, 334)
   call matchadd('ObuspaMessageOpetareResp', '.*OPERATE_RESP.*', 10, 335)

   nnoremap <buffer> <CR> :call HandleEnterKey()<CR>
   nnoremap <buffer> S  :call MessagePanelHandleSearchFull()<CR>
   nnoremap <buffer> R  :call MessagePanelHandleRefreshFull()<CR>
   nnoremap <buffer> qs :call MessagePanelHandleSearch()<CR>
   nnoremap <buffer> r  :call MessagePanelHandleRefresh()<CR>
   nnoremap <buffer> s  :call MessagePanelHandleSearchFullNoStep()<CR>
   nnoremap <buffer> Q  :q<CR>
   nnoremap <buffer> ?  :call MessagePanelHelp()<CR>
   nnoremap <buffer> <DOWN> :call MessagePanelHandleDown()<CR>
   nnoremap <buffer> <UP> :call MessagePanelHandleUp()<CR>
endfunction
function! HandleEnterKey()
   let l:id=g:MessagePanelGetLineId(line('.'))
   echo l:id
   let l:my_id=win_getid()
   if l:id != ""
      call win_gotoid(g:MessagesPanelBufferID)
      call FindMessages(l:id)
      call cursor(1,1)
      call search(l:id)
      call win_gotoid(l:my_id)
   endif
endfunction

function! MessagesPanelOpen(flags)
   if g:MessagesPanelID != 0
      echo "Messages panel is already open"
      return 0
   endif
   let g:MessagesPanelMessages=ParseAllMessages()
   let g:MessagesPanelBufferID=win_getid()
   let g:MessagesPanelFlags=split(a:flags." ", ' ')
   let l:id = GetMessageIdFromCursor()
   call MessagesPanelCreateBuffer()
   call MessagesPanelSetSettings()
   call MessagePanelSetText("null")
   call MessagePanelSetCursor(l:id)
   let g:MessagesPanelID=win_getid()
endfunction
function! MessagePanelClose()
   if g:MessagesPanelID != 0
      call win_execute(g:MessagesPanelID,"exit")
      let g:MessagesPanelID=0
   else 
      echo "Messages panel is already closed"
   endif
endfunction
function! MessagePanelHandle(flags)
   if g:MessagesPanelID == 0
      call MessagesPanelOpen(a:flags)
   else
      call MessagePanelClose()
   endif
endfunction
