"--------------------------------------------------------------------------

set    cb           =autoselect                             " clipboard
set    et                                                   " expandtab
set  noic                                                   " ignorecase
"set    list                                                 " list
set    pvh          =5                                      " previewheight
set    nu                                                   " number
set  nosft                                                  " showfulltag
set  noru                                                   " ruler
set    scr          =5                                      " scroll
set    sr                                                   " shiftround
set    stl          =[%6LTL]%6lL\ %6cC\ %3p%%\ %1*%3nB%m%0*\ %t%=%a\ %1*%W%H%R%0*   " statusline
set    sw           =4                                      " shiftwidth
"set    title                                                " title
"set    titlestring  =[%{v:servername}]\ %F                  " titlestring
set    ts           =4                                      " tabstop
"set    wak          =no                                     " winaltkeys
set  nowrap                                                 " wrap



"--------------------------------------------------------------------------

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
nnoremap <Esc><Esc> :noh<CR>
nnoremap x "_x
colorscheme desert
