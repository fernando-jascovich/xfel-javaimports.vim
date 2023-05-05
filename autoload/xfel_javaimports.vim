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

    if len(l:clazz) > 0 && len(l:pkg) > 0
      let s:cache[l:clazz] = l:pkg . '.' . l:clazz
      call s:save()
    else
      return ""
    end
  end
  return get(s:cache, l:clazz)
endfunction

function! s:importline(import)
  let l:import = 'import ' . a:import
  if &ft == "java"
    let l:import = l:import . ';'
  endif
  return l:import
endfunction

function! xfel_javaimports#commonft()
  let l:commonfts = ["java", "kotlin"]
  return index(l:commonfts, &ft) > -1
endfunction

function! s:already_imported(importline)
  return search(a:importline . '$', 'n')
endfunction

function! xfel_javaimports#insert(import)
  if len(a:import) < 1
    echom 'Nothing to import'
    return
  end

  let l:import = s:importline(a:import)
  if s:already_imported(l:import)
    echom 'Already imported: ' . a:import
    return
  endif

  let l:currentpos = getpos('.')
  call cursor(0, 0)

  let l:importtext = l:import
  let l:importline = search('^import', 'n')
  if l:importline < 1
    let l:importline = 1
    let l:importtext = ['', l:import]
  endif

  call append(l:importline, l:importtext)
  call cursor(l:importline, + 2)
  execute "norm! vip:sort\<cr>"
  call cursor(l:currentpos[1] + 1, l:currentpos[2])
endfunction



