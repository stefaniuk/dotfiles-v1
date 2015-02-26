" Modified by Daniel Stefaniuk <daniel.stefaniuk@gmail.com>

" check
if exists("guifontpp_loaded") || !exists("&guifont")
    finish
endif
let guifontpp_loaded = 1

" set local variables
let s:guifontpp_step = 1
let s:guifontpp_smaller_font_map = "-"
let s:guifontpp_larger_font_map = "+"
let s:guifontpp_restore_font_map = "="

" get global variables
if exists("g:guifontpp_step")
    let s:guifontpp_step = g:guifontpp_step
endif
if exists("g:guifontpp_smaller_font_map")
    let s:guifontpp_smaller_font_map = g:guifontpp_smaller_font_map
endif
if exists("g:guifontpp_larger_font_map")
    let s:guifontpp_larger_font_map = g:guifontpp_larger_font_map
endif
if exists("g:guifontpp_restore_font_map")
    let s:guifontpp_restore_font_map = g:guifontpp_restore_font_map
endif

" regular expressions
let s:decimalpat = '[1-9][0-9]*'
let s:fontpat_linux = '^\(\w*\)\(\s*\)\(' . s:decimalpat . '\)'
let s:fontpat_windows = '\(:h\)\(' . s:decimalpat . '\)\(:\|,\|$\)'

fun! s:GetFontSize()
    if has("unix")
        let sizealmost = matchstr(&guifont, s:fontpat_linux)
        let size = matchstr(sizealmost, s:decimalpat . '$')
    elseif has("win32")
        let sizealmost = matchstr(&guifont, s:fontpat_windows)
        let size = matchstr(sizealmost, s:decimalpat)
    else
        echoerr "This works only with Unix or Win32 version of Vim"
        return
    endif
    if size == ""
        echoerr "Cannot match your 'guifont' to a known pattern"
    endif
    if !exists("s:originalFontSize")
        let s:originalFontSize = size
    endif
    return size
endfun

fun! s:SetFontSize(size)
    if has("unix")
        let guifont = substitute(&guifont, s:fontpat_linux,
            \ '\1 ' . a:size, "")
    elseif has("win32")
        let guifont = substitute(&guifont, s:fontpat_windows, 
            \ '\1' . a:size . '\3', "")
    endif
    let &guifont = guifont
endfun

fun! s:SetLargerFont()
    let size = s:GetFontSize()
    if size
        call s:SetFontSize(size + s:guifontpp_step)
    endif
endfun

fun! s:SetSmallerFont()
    let size = s:GetFontSize()
    if size && size > 1
        call s:SetFontSize(size - s:guifontpp_step)
    endif
endfun

fun! s:SetOriginalFont()
    if s:originalFontSize
        call s:SetFontSize(s:originalFontSize)
    else
        echoerr "Original font size is unknown"
    endif
endfun

let s:ms = "map <silent> "
exe s:ms . s:guifontpp_smaller_font_map  . " :call <SID>SetSmallerFont()<CR>"
exe s:ms . s:guifontpp_larger_font_map   . " :call <SID>SetLargerFont()<CR>"
exe s:ms . s:guifontpp_restore_font_map . " :call <SID>SetOriginalFont()<CR>"
