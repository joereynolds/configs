" nnoremap ]] /^#\{1,5}\s*[a-z]<cr>:nohls<cr>
" nnoremap [[ 
let s:headers = '^#\{1,5}\s*[a-z]'

execute 'nnoremap <buffer> <silent> [[ ?' . s:headers . '?<CR>:nohls<CR>'
execute 'nnoremap <buffer> <silent> ]] /' . s:headers . '/<CR>:nohls<CR>'

setlocal textwidth=80
setlocal spell

