function! s:CheckAndAddTagFile(path)
     if stridx(a:path, '/') == (strlen(a:path) - 1)
         let l:tags = a:path . 'tags'
     else
         let l:tags = a:path . '/tags'
     endif
 
     if stridx(&tags, l:tags) != -1
         echo l:tags "already added"
         return
     endif
 
     if !filereadable(l:tags)
         echo l:tags "not readable"
         return
     endif
 
     let &tags =  len(&tags) == 0 ? l:tags : &tags . ',' . l:tags
     echo l:tags "added"
 
     unlet! l:tags
 endfunction
 
 function! s:StrEndWith(str, pattern)
     if strridx(a:str, a:pattern) == strlen(a:str) - strlen(a:pattern)
         return 1
     else
         return 0
     endif
 endfunction
 
 function! s:SplitPath(path)
     let l:start = 0
     let l:list = []
 
     while 1 == 1
         let l:idx = stridx(a:path, '/', l:start)
         let l:start = l:idx + 1
 
         if l:idx == -1
             break
         endif
 
         let l:part = a:path[0:(l:idx > 0 ? l:idx - 1 : l:idx)]
         call add(l:list, l:part)
     endwhile
 
     if !s:StrEndWith(a:path, '/')
         call add(l:list, a:path)
     endif
 
     return l:list
 endfunction
 
 function! Tags()
     let l:cwd = tr(expand('%:p:h'), '\', '/')
 
     let l:pathes = s:SplitPath(l:cwd)
 
     for p in l:pathes
         call s:CheckAndAddTagFile(p)
     endfor
 
 endfunction
 
 " call AddTagsInCwdPath()
