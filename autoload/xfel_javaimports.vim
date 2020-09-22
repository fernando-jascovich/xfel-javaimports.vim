function! s:init()
  let s:cache = {}
endfunction

function! s:save()
  let l:fname = "/home/xfel/Desktop/xfel-javaimports-cache.json"
  call writefile([json_encode(s:cache)], l:fname)
endfunction

function! s:read(override)
  let l:clazz = expand('<cword>')
  if a:override || !has_key(s:cache, l:clazz)
    let l:clazz = input('Class: ', l:clazz)
    let l:pkg = input('Package: ')
    let s:cache[l:clazz] = l:pkg . '.' . l:clazz
    call s:save()
  end
  return get(s:cache, l:clazz)
endfunction

function! s:insert(import)
  let l:currentpos = getpos('.')
  call cursor(0, 0)
  let l:pkgline = search('package')
  let l:import = l:pkgline + 1, 'import ' . a:import
  call append(l:import)
  call cursor(l:currentpos[1] + 1, l:currentpos[2])
endfunction


