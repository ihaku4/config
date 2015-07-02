if !hasmapto('<Plug>CRun')
  map <buffer> <unique> <space> <Plug>CRun
  noremap <buffer> <unique> <Plug>CRun :cd %:p:h<CR>:w\|:!gcc %&&./a.out<cr>
endif

if !hasmapto('<Plug>CDbg')
  map <buffer> <unique> \d <Plug>CDbg
  noremap <buffer> <unique> <Plug>CDbg :cd %:p:h<CR>:w\|:!gcc % -g&&gdb -tui ./a.out<cr>
endif
"nmap \p :cd %:p:h<CR>:w\|:!gcc %&&./a.out<cr>
"nmap \\p :cd %:p:h<CR>:w\|:!gcc %&&./a.out 
""objdump
"nmap \\od :cd %:p:h<CR>:w\|:!gcc % -g && objdump -dS a.out
""readelf -a
"nmap \\re :cd %:p:h<CR>:w\|:!kcc % -g && readelf -a a.out
""hexdump -C
"nmap \\hd :cd %:p:h<CR>:w\|:!gcc % -g && hexdump -C a.out
""gcc -E % | grep typename
""nmap 
""
""end every cmd with <CR>, or you'll have to type enter by hand.
""and then : is required after every |
"nmap \m :w\|!gcc %:p<CR>\|:split %:p.log<cr>\|:%!%:p:h/a.out<cr>\|:w<cr>
"nmap \, :w\|!gcc %:p<CR>\|:split %:p.log<cr>\|:%!%:p:h/a.out
