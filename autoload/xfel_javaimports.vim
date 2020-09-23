let s:fname = $HOME . "/.cache/nvim/xfel-javaimports/cache.json"

function! xfel_javaimports#init()
  try
    let s:cache = json_decode(readfile(s:fname))
  catch
    let s:cache = {}
  endtry
endfunction

function! s:save()
  if !filewritable(s:fname)
    call mkdir(fnamemodify(s:fname, ":p:h"), "p")
  end

  call writefile([json_encode(s:cache)], s:fname)
endfunction

function! xfel_javaimports#read(override)
  let l:clazz = expand('<cword>')
  if a:override || !has_key(s:cache, l:clazz)
    let l:clazz = input('Class: ', l:clazz)
    let l:pkg = input('Package: ')
    let s:cache[l:clazz] = l:pkg . '.' . l:clazz
    call s:save()
  end
  return get(s:cache, l:clazz)
endfunction

function! s:importline(import)
  let l:import = 'import ' . a:import
  if ft == "java"
    let l:import = l:import . ';'
  endif
  return l:import
endfunction

function! xfel_javaimports#commonft()
  let l:commonfts = ["java", "kotlin"]
  return index(l:commonfts, &ft) > -1
endfunction

function! xfel_javaimports#insert(import)
  let l:currentpos = getpos('.')
  call cursor(0, 0)
  let l:pkgline = search('package')
  let l:import = s:importline(import)
  call append(l:pkgline + 1, l:import)
  call cursor(l:currentpos[1] + 1, l:currentpos[2])
endfunction


