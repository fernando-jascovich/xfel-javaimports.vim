if exists("g:loaded_xfel_javaimports_plugin")
  finish
endif
let g:loaded_xfel_javaimports_plugin = 1

function! s:import(override)
  if !exists('s:cache')
    call s:init()
  end

  let l:result = s:read(override)
  call s:insert(l:result)
endfunction

