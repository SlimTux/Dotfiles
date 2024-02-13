--[[

Neovim init file
Maintainer: brainf+ck
Website: https://github.com/brainfucksec/neovim-lua

--]]
vim.cmd [[
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex<CR>
	let g:vimwiki_list = [{'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
 	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
  autocmd BufWritePre *.[ch] %s/\%$/\r/e " add trailing newline for ANSI C standard
  autocmd BufWritePre *neomutt* %s/^--$/-- /e " dash-dash-space signature delimiter in emails
  	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }
	autocmd BufWritePost ~/Downloads/GIT/copy/salonia/salonia-dwm/dwmblocks/config.h !cd ~/Downloads/GIT/copy/salonia/salonia-dwm/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Recompile dwm on config edit.
	autocmd BufWritePost ~/.local/src/dwm/config.h !cd ~/.local/src/dwm/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }
	autocmd BufWritePost ~/Downloads/GIT/copy/salonia/salonia-dwm/config.h !cd ~/Downloads/GIT/copy/salonia/salonia-dwm/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Recompile st on config edit.
	autocmd BufWritePost ~/.local/src/st/config.h !cd ~/.local/src/st/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Recompile dmenu on config edit.
	autocmd BufWritePost ~/.local/src/dmenu/config.h !cd ~/.local/src/dmenu/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Compile latex on config edit.
	autocmd BufWritePost ~/Documents/School/MAI/IA/draft/draft.tex !cd ~/Documents/School/MAI/IA/draft; latexmk -pdf -pvc file.tex && { killall -q dwmblocks;setsid -f dwmblocks }

" Compile latex on config edit.
	autocmd BufWritePost ~/Documents/School/ESS/IA/draft.tex && (lualatex)
]]

-- Import Lua modules
require('core/lazy')
require('core/autocmds')
require('core/keymaps')
require('core/colors')
require('core/statusline')
require('core/options')
require('lsp/lspconfig')
require('plugins/nvim-tree')
require('plugins/indent-blankline')
require('plugins/nvim-cmp')
require('plugins/nvim-treesitter')
require('plugins/alpha-nvim')
vim.cmd 'source ~/.config/nvim.backup/automation.vim'
