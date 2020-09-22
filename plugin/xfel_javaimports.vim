if exists("g:loaded_xfel_javaimports_plugin")
  finish
endif
let g:loaded_xfel_javaimports_plugin = 1

function! xfel_javaimports#import(override)
  if !exists('s:cache')
    call xfel_javaimports#init()
  end

  let l:result = xfel_javaimports#read(a:override)
  call xfel_javaimports#insert(l:result)
endfunction

command! XFELJI call xfel_javaimports#import(0)
command! XFELJIO call xfel_javaimports#import(1)

