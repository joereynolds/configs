"syntastic
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%#warningmsg#
set statusline+=%*o

let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"CommandT
let g:CommandTFileScanner = "git"

"vimwiki
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]

"vdebug
let g:vdebug_options = {'path_maps':
\   {
\       "/var/www" : "/home/joe/code"
\   }
\}
