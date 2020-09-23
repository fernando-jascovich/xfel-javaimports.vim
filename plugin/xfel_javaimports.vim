if exists("g:loaded_xfel_javaimports_plugin")
  finish
endif
let g:loaded_xfel_javaimports_plugin = 1

function! xfel_javaimports#import(override)
  if !xfel_javaimports#commonft()
    let l:msg = 'This is not a regular file type for this, sure wanna do this? '
    if confirm(l:msg) != 1
      return
    endif
  endif

  if !exists('s:cache')
    call xfel_javaimports#init()
  end

  let l:result = xfel_javaimports#read(a:override)
  call xfel_javaimports#insert(l:result)
endfunction

command! XFELJI call xfel_javaimports#import(0)
command! XFELJIO call xfel_javaimports#import(1)

