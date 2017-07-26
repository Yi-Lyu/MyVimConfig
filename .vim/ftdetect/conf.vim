" Formatting and syntax highlighting of Configure format
" by lauchingjun@baidu.com / liuqingjun@baidu.com
function! ConfLastGroupLine(lineno)
    let cur_line = a:lineno
    while cur_line > 0
        if match(getline(cur_line),"^[ \t]*\[\.*") >= 0
            return cur_line
        endif
        let cur_line = cur_line - 1
    endwhile
    return -1
endfunction
function! ConfGetIndent(lineno)
    if match(getline(a:lineno),"^[ \t]*\[\.*") < 0
        let last_group_line = ConfLastGroupLine(a:lineno)
        if last_group_line == -1
            return -1
        else
            return strlen(substitute(getline(last_group_line),"[^.]","","g"))*&sw + &sw
        endif
    else
        return strlen(substitute(getline(a:lineno),"[^.]","","g"))*&sw
    endif
endfunction
au BufRead,BufNewFile *.conf  set indentexpr=ConfGetIndent(v:lnum)
au BufRead,BufNewFile *.conf  set indentkeys=[,],.,0{,0},:,0#,!^F,o,O,e,<Backspace>
au BufRead,BufNewFile *.conf  set ft=

au BufRead,BufNewFile *.conf  syn match group1 /#.*/
au BufRead,BufNewFile *.conf  syn match group3 /^\s*[^\[#][a-zA-Z0-9_]*/
au BufRead,BufNewFile *.conf  syn match group2 /^\s*\[[.@a-zA-Z0-9_]*\]/

au BufRead,BufNewFile *.conf  hi link group1 Comment
au BufRead,BufNewFile *.conf  hi link group2 String
au BufRead,BufNewFile *.conf  hi link group3 Statement

au BufRead,BufNewFile *.conf  highlight Comment ctermfg=DarkBlue
au BufRead,BufNewFile *.conf  highlight String ctermfg=DarkRed
au BufRead,BufNewFile *.conf  highlight Statement ctermfg=DarkYellow
