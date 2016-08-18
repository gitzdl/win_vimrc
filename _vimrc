
set go=M
au GUIEnter * simalt ~x
"Multi-encoding setting, MUST BE IN THE BEGINNING OF .vimrc!
"
if has("multi_byte")
    " When 'fileencodings' starts with 'ucs-bom', don't do this manually
    "set bomb
    set fileencodings=ucs-bom,utf-8,chinese,taiwan,japan,korea,latin1
    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
        " Simplified Chinese, on Unix euc-cn, on MS-Windows cp936
        set encoding=chinese
        set termencoding=chinese
        if &fileencoding == ''
            set fileencoding=chinese
        endif
    elseif v:lang =~ "^zh_TW"
        " Traditional Chinese, on Unix euc-tw, on MS-Windows cp950
        set encoding=taiwan
        set termencoding=taiwan
        if &fileencoding == ''
            set fileencoding=taiwan
        endif
    elseif v:lang =~ "^ja_JP"
        " Japanese, on Unix euc-jp, on MS-Windows cp932
        set encoding=japan
        set termencoding=japan
        if &fileencoding == ''
            set fileencoding=japan
        endif
    elseif v:lang =~ "^ko"
        " Korean on Unix euc-kr, on MS-Windows cp949
        set encoding=korea
        set termencoding=korea
        if &fileencoding == ''
            set fileencoding=korea
        endif
    endif
    " Detect UTF-8 locale, and override CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
    endif
else
    echoerr 'Sorry, this version of (g)Vim was not compiled with "multi_byte"'
endif



"�Ƿ����VI��compatibleΪ���ݣ�nocompatibleΪ����ȫ����
"ȥ���й�viһ����ģʽ��������ǰ�汾��һЩbug�;���
"�������Ϊcompatible����tab�������ɿո�
set nocompatible

if &term =~ 'xterm'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <F1>=\eOP"
    execute "set <F2>=\eOQ"
    execute "set <F3>=\eOR"
    execute "set <F4>=\eOS"
    execute "set <S-F1>=\eO1;2P"
    execute "set <S-F2>=\eO1;2Q"
    execute "set <S-F3>=\eO1;2R"
    execute "set <S-F4>=\eO1;2S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif

filetype off                  " required
"set the runtime path to include Vundle and initialize
"set rtp+=C:/Users/Administrator/.vim/bundle/Vundle.vim
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
call vundle#begin('$VIM/vimfiles/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'gmarik/Vundle.vim'

Plugin 'a.vim'
Plugin 'taglist.vim'
Plugin 'winmanager'
Plugin 'bufexplorer.zip'
Plugin 'The-NERD-tree'
Plugin 'msanders/snipmate.vim'
"Plugin 'cscope.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VimIM'
Plugin 'EasyGrep'
"Plugin 'SuperTab'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"���������ļ�
"�鿴$VIMRUNTIME����Ϊ :echo $VIMRUNTIME
source $VIMRUNTIME/vimrc_example.vim

"�����������ģʽΪWINDOWSģʽ
behave mswin

set diffexpr=MyDiff()
function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            if empty(&shellxquote)
                let l:shxq_sav = ''
                set shellxquote&
            endif
            let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
    endif
endfunction



"�����ն���ɫ
set t_Co=256

"����˵�����
set termencoding=zh_CN
set encoding=utf-8
"fileencodings��Ҫע��˳��ǰ����ַ���Ӧ�ñȺ�����ַ�����
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gbk,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8

"�˵�ʹ�õ�����
set langmenu=zh_CN.utf-8

"ɾ�����в˵����Ա����¶���
source $VIMRUNTIME/delmenu.vim

"����Ĭ�ϲ˵�
source $VIMRUNTIME/menu.vim

"��ʼ�༭������ʱʹ��IM
set imcmdline

"���consle�������ʾ��Ϣ����
language messages zh_CN.utf-8



" �Զ��رղ�ȫ����
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" set completeopt=menuone,menu,longest
"����ģʽ��ȫʹ�õ�ѡ��
set completeopt=longest,menu

"�﷨����
syntax on
"�Զ�����
set autoindent

"��������Щģʽ��ʹ����깦�ܣ�mouse=a ��ʾ����ģʽ
set mouse=a
"���� Backspace �� Delete �����̶ȣ�backspace=2 ��û���κ�����
set backspace=2

"�Ƿ��Զ�����
set wrap
"��ȷ�ش��������ַ������к�ƴ��
set formatoptions+=mM
"���ó���100�ַ��Զ�����
set textwidth=100

"���ܶ��뷽ʽ
set smartindent
"һ��tab��4���ַ�
set tabstop=4
"��һ��tabǰ��4���ַ�
set softtabstop=4
"�ÿո����tab
set expandtab
"�����Զ�����
set ai!
"�������ַ�����
set cindent shiftwidth=4
"set autoindent shiftwidth=4

"�����۵�
"�����۵�����
set foldcolumn=4
"��������۵����۵��ʹ�
"set foldopen=all
"�ƿ��۵�ʱ�Զ��ر��۵�
"set foldclose=all
"zf zo zc zd zr zm zR zM zn zi zN
"�������۵�
"   manual  �ֹ������۵�
"   indent  �����������ʾ���߼�����۵�
"   expr    �ñ��ʽ�������۵�
"   syntax  ���﷨�����������۵�
"   diff    ��û�и��ĵ��ı������۵�
"   marker  �����еı�־�۵�
set foldmethod=syntax
"����ʱ��Ҫ�Զ��۵�����
set foldlevel=100

"��ʾ�к�
set number

"�򿪹�������λ����ʾ����
set ruler

"��δ����ж��ֿ�ȵ� Unicode �ַ�,������ʾ��������
set ambiwidth=double

"�и���
"set cursorline
"�и������뺯���б��г�ͻ
"set cursorcolumn

"���������еĸ߶�
set cmdheight=2

"���������Ĺؼ���
set hlsearch

"�������Դ�Сд
set ignorecase

"����������ʷ����
set history=100

"������ʱ����ʾ�Ǹ�Ԯ���������ͯ����ʾ
set shortmess=atI

"�ر��ն�����
set noerrorbells
set vb t_vb=
"��Ҫ��˸
set novisualbell


"����VIM״̬��
set laststatus=2 "��ʾ״̬��(Ĭ��ֵΪ1, �޷���ʾ״̬��)
set statusline=
set statusline+=%2*%-3.3n%0*\                       " buffer number
set statusline+=%f\                                 " file name
set statusline+=%h%1*%m%r%w%0*                      " flag
set statusline+=[
if v:version >= 600
    set statusline+=%{strlen(&ft)?&ft:'none'},      " filetype
    set statusline+=%{&fileencoding},               " encoding
endif
set statusline+=%{&fileformat}]                     " file format
set statusline+=%=                                  " right align
set statusline+=%2*0x%-8B\                          " current char
"set statusline+=0x%-8B\                             " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P               " offset
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()}                 " vim buddy
endif

"״̬����ɫ
"highlight StatusLine guifg=SlateBlue guibg=Yellow
"highlight StatusLineNC guifg=Gray guibg=White

"��ǿģʽ�е��������Զ���ɲ˵���ȫ����
set wildmenu

"ȱʡ�����������ļ�
set nobackup
"����������ʱ������ݵ�������֮��ƥ������Ŵ�����Ӱ������
set showmatch

"�趨�ļ������Ŀ¼Ϊ��ǰĿ¼
set bsdir=buffer
"�Զ����¼����ⲿ�޸�����
set autoread

"��������δ������޸�ʱ�л�������
set hidden

"ѡ��һ�����ֲ�ȫ�������������
vmap <silent> ,/ y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vmap <silent> ,? y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

"���뵱ǰ�༭���ļ���Ŀ¼
autocmd BufEnter * exec "cd %:p:h"

"�����ļ��ĸ�ʽ˳��
set fileformats=unix,dos

"��ɫ���������ɫ��colorsĿ¼��http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/index-c.html��
colorscheme desert
set background=dark

"��ճ��ģʽ������ճ�������ĳ������Ͳ����λ�ˡ����ú�SuperTab��Ч;
set paste

"��¼�ϴιرյ��ļ���״̬
set viminfo='10,\"100,:20,%,n~/._viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


"F2���ùر���������
nmap <F2> :nohl<CR>

"��nӳ��һ����ݼ���ϰ����ϲ����F3
nmap <F3> :cn<CR>
"��Nӳ��һ����ݼ���ϰ����ϲ����F3

nmap <S-F3> :cp<CR>

"F4ӳ��Ϊ�л�ͷ�ļ�
nmap <F4> :A<CR>
"Shift-F4ӳ��Ϊˮƽ�ָ�л�ͷ�ļ�
nmap <S-F4> :AV<CR>
"Ctrl-F4ӳ��Ϊ�½�ͷ�ļ����л�
nmap <C-F4> :AT<CR>

"<F5>ˢ��Buffer
nmap <F5>   :e<CR>

"F6�����л���nerd_tree��nerd_tree�����
let g:NERDChristmasTree = 1              "ɫ����ʾ
let g:NERDTreeShowHidden = 1             "��ʾ�����ļ�
let g:NERDTreeWinPos = 'left'            "������ʾλ��
let g:NERDTreeHighlightCursorline = 0    "������ǰ��
nmap <F6>  :NERDTreeToggle<CR>

"F7�����л���taglist��taglist�����
let g:Tlist_Sort_Type = 'name'          "������˳������Ĭ����λ��˳��(order)
let g:Tlist_Show_One_File = 1           "��ͬʱ��ʾ����ļ���tag��ֻ��ʾ��ǰ�ļ���
let g:Tlist_Exit_OnlyWindow = 1         "���taglist���������һ�����ڣ����˳�vim
lef g:Tlist_File_Fold_Auto_Close = 1    "����겻�ڱ༭�ļ������ʱ��ȫ���۵�
let g:Tlist_Use_Right_Window = 1        "���Ҳര������ʾtaglist����
"let g:Tlist_Enable_Fold_Column = 1      "��ʾ�۵�����
let g:Tlist_Winwidth = 20                "����taglist���ڿ��
"let g:Tlist_Inc_Winwidth = 0
"let g:Tlist_WinHeight = 5
let g:Tlist_GainFocus_On_ToggleOpen = 1 "TlistToggle��taglist����ʱ�����ϣ�����뽹����taglist������
nmap <F7>  :Tlist<CR>

"F9 WinManager
"-- WinManager setting --
"��������Ҫ����Ĳ��
let g:winManagerWindowLayout='FileExplorer,BufExplorer|TagList'
"������б༭�ļ����ر��ˣ��˳�vim
let g:persistentBehaviour=0
"����VIM�Զ���winmanager
"let g:AutoOpenWinManager = 1
nmap <F9>  :WMToggle<CR>



"F10�鿴�򿪵��ļ��б�bufexplorer�����
let g:bufExplorerDefaultHelp = 1
let g:bufExplorerDetailedHelp = 0
nmap <F10> :BufExplorer <CR>


"F12����/����tags�ļ�
set tags=tags;

"�Զ��л���ǰĿ¼Ϊ��ǰ�ļ����ڵ�Ŀ¼
set autochdir

function! UpdateTagsFile_cpp()
	!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
	endfunction
	"nmap <F12> :call UpdateTagsFile()<CR>
	nmap <F12> :call UpdateTagsFile_cpp()<CR><CR>

function! UpdateTagsFile_c()
	!ctags -R --c-kinds=+px --fields=+iaS
	endfunction
	"nmap <S-F12> :call UpdateTagsFile()<CR>
	nmap <S-F12> :call UpdateTagsFile_c()<CR><CR>

	"Ctrl + F12ɾ��tags�ļ�
function! DeleteTagsFile()
	"Linux�µ�ɾ������
	"silent !rm tags
	silent !rm *.un*
	endfunction
	nmap <C-F12> :call DeleteTagsFile()<CR>
	"�˳�VIM֮ǰɾ��tags�ļ�
au VimLeavePre * call DeleteTagsFile()

"VimIM����
let g:vimim_cloud = 'baidu,qq,google,sogou'
"let g:vimim_map = 'tab_as_gi'
"let g:vimim_mode = 'dynamic'
"let g:vimim_mycloud = 0
"let g:vimim_punctuation = 2
"let g:vimim_shuangpin = 0
"let g:vimim_toggle = 'pinyin,google,sogou'

"
"���������Զ���ȫ
"inoremap ( ()<Esc>i
"inoremap [ []<Esc>i
"inoremap { {<CR>}<Esc>O
"inoremap ' ''<Esc>i



"���ó���100����ʾ��
set colorcolumn=100


"YCM������
let g:ycm_key_list_select_completion = ['<c-tab>', '<Down>']  "��ӳ��ѡ���
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
let g:ycm_confirm_extra_conf = 0                            "ȥ��ʹ���ⲿ����ȷ����ʾ
let g:ycm_complete_in_comments = 0                          "ע���в�ʹ�ò�ȫ
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.c = ['.','->']
inoremap <leader>; <C-x><C-o>
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>ji :YcmCompleter GoToInclude<CR>
set noundofile
