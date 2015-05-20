" NeoBundle が未インストールの時、プラグイン初期化に失敗した時の処理
function! s:WithoutBundles()
  " 今のところ特に無し
endfunction

" NeoBundle よるプラグインのロードと各プラグインの初期化
function! s:LoadBundles()
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'alpaca-tc/alpaca_powertabline'
  NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'scrooloose/nerdtree'

  " syntax check
  NeoBundle 'scrooloose/syntastic'
  let g:syntastic_ruby_checkers = ['rubocop']
  " endを自動挿入 for Ruby
  NeoBundle 'tpope/vim-endwise'
  " indent for ruby
  NeoBundle 'vim-ruby/vim-ruby'
  " 括弧などの補完
  NeoBundle 'Townk/vim-autoclose'

  " bundle系のキーマップ
  nnoremap <silent><C-e> :NERDTreeToggle<CR>
  " 未インストールのbundleがあればインストールする
  NeoBundleCheck
endfunction

function! s:SetCustomColorScheme()
  " iTerm2のpresetsにJellybeansをセットした時のカスタマイズ
  highlight LineNr ctermfg=red guifg=red
  highlight Statement ctermfg=yellow guifg=yellow
  " highlight Comment ctermfg=blue guifg=blue
  " highlight vimComment ctermfg=blue guifg=blue
endfunction

" 常時使いたい設定
function! s:SetCommonSettings()
  syntax on
  call s:SetCustomColorScheme()

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

" ================================
" メイン処理
function! s:InitNeoBundle()
  filetype plugin indent on
  if isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    if has('vim_starting')
      set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif
    try
      call neobundle#begin(expand('~/.vim/bundle/'))
      call s:LoadBundles()
      call neobundle#end()
    catch
      call s:WithoutBundles()
    endtry
  else
    call s:WithoutBundles()
  endif

  call s:SetCommonSettings()
endfunction

call s:InitNeoBundle()
