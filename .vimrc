scriptencoding utf-8
set encoding=utf-8

"dein.vim の設定
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落とす
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイルを用意
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

" 未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" =================

function! s:SetCustomColorScheme()
  " iTerm2のpresetsにJellybeansをセットした時のカスタマイズ
  highlight LineNr ctermfg=red guifg=red
  highlight Statement ctermfg=yellow guifg=yellow
  " highlight Comment ctermfg=blue guifg=blue
  " highlight vimComment ctermfg=blue guifg=blue
endfunction

" 常時使いたい設定
function! s:SetCommonSettings()
  call s:SetCustomColorScheme()
  set nocompatible
  syntax on
  filetype on
  filetype plugin indent on

  set ruler
  set number
  set nf=alpha
  set autoindent
  set expandtab
  set nobackup
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set history=50
  " ステータスバーの設定
  set laststatus=2

  " 行列のハイライト設定
  set cursorline
  highlight CursorLine ctermbg=Black
  set cursorcolumn
  highlight CursorColumn ctermbg=Black

  " ファイル保存時に行末スペースを削除
  autocmd BufWritePre * :%s/\s\+$//e

  " ファイルを開く際の文字コード設定
  if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=ucs-bom,utf-8,latin1
  endif
endfunction

call s:SetCommonSettings()
