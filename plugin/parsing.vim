 
function! ParseAllMessages()
   let l:messages = FindOccurrences('msg_id: "[^"]*"', 1, 'down',0)
   let l:result = []
   let l:max_id_size=0
   for l:msg in l:messages
       let l:msg_id = matchstr(getline(l:msg), '"\zs[^"]\+"')[0:-2]
       let l:msg_type = split(getline(l:msg+1), ': ')[1]
       let l:msg_id_size = strlen(l:msg_id)
       if l:msg_id_size > l:max_id_size
          let l:max_id_size = l:msg_id_size
       endif
       if l:msg_type == "GET"
          let l:time_str = FindOccurrences('processing at time', l:msg, 'down',1)
          let l:time=getline(l:time_str)[25:45]
       elseif l:msg_type == "GET_RESP"
          let l:time_str = FindOccurrences('sending at time', l:msg, 'up',1)
          let l:time=getline(l:time_str)[25:44]
       elseif l:msg_type == "NOTIFY"
          let l:time_str = FindOccurrences('sending at time', l:msg, 'up',1)
          let l:time=getline(l:time_str)[23:42]
       endif
       let l:data={}
       call add(l:result, [l:msg_id , l:msg_type ,  l:time,l:data])
   endfor
   return [l:result, l:max_id_size]
endfunction
function! FindOccurrences(pattern, start_line, direction,flag)
    let l:occurrences = []
    let l:total_lines = line('$')
    let l:start = a:start_line
    let l:end = (a:direction == 'up') ? 1 : l:total_lines
    if a:direction == 'up'
        let step = -1
    else
        let l:start = a:start_line
        let l:end = l:total_lines
        let step = 1
    endif
    for i in range(l:start, l:end, l:step)
        let l:line_text = getline(i)
        if l:line_text =~ a:pattern
            if a:flag == 1
               return i
            endif
            call add(l:occurrences, i)
        endif
    endfor
    if len(l:occurrences) > 0
       return l:occurrences
    else
        if a:flag == 1
            return 0
         endif
        return []
    endif
 endfunction
function! FindMessagesBorders(msg_pos)
   let l:up=FindOccurrences('version:', a:msg_pos, 'up',1)
   let l:down=FindOccurrences('processing at time', a:msg_pos, 'down',1)
   let l:down_resp = FindOccurrences('LogCallback:', a:msg_pos, 'down',1)
   if l:down == 0
      let l:down = l:down_resp
   endif
   if l:down_resp < l:down
      let l:down = l:down_resp
   endif
   return [l:up, l:down]
endfunction
function! FindMessages(msg_id)
   let l:messages = FindOccurrences(a:msg_id, 1, 'down',0)
   let l:last_line=0
   let l:len=len(l:messages)
   let l:i=0
   execute "edit!"
   for l:msg in l:messages
       let l:message_border = FindMessagesBorders(l:msg)
       if l:message_border[0] == 0 && l:message_border[1] == 0
          break
       endif
       call CreateFold(l:last_line,l:message_border[0]-2)
       let l:last_line=l:message_border[1]+2
       if l:i == l:len-1
          call CreateFold(l:last_line,line('$'))
       endif
       let l:i=l:i+1
   endfor
endfunction
function! GetMessageIdFromCursor()
   let l:line = getline('.')
   let l:msg_id =matchstr(l:line, 'msg_id: "[^"]*"')
   if l:msg_id==""
      return "null"
   endif
   let l:extracted = matchstr(l:msg_id, '"\zs[^"]\+"')
   return l:extracted[:-2]
endfunction
function! FindMessagesFromCursor()
   let l:msg_id=GetMessageIdFromCursor()
   if l:msg_id == "null"
      return
   endif
   call FindMessages(l:msg_id)
endfunction
