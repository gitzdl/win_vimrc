
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



"是否兼容VI，compatible为兼容，nocompatible为不完全兼容
"去掉有关vi一致性模式，避免以前版本的一些bug和局限
"如果设置为compatible，则tab将不会变成空格
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


"导入配置文件
"查看$VIMRUNTIME命令为 :echo $VIMRUNTIME
source $VIMRUNTIME/vimrc_example.vim

"设置鼠标运行模式为WINDOWS模式
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



"设置终端颜色
set t_Co=256

"解决菜单乱码
set termencoding=zh_CN
set encoding=utf-8
"fileencodings需要注意顺序，前面的字符集应该比后面的字符集大
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gbk,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8

"菜单使用的语言
set langmenu=zh_CN.utf-8

"删除所有菜单，以便重新定义
source $VIMRUNTIME/delmenu.vim

"导入默认菜单
source $VIMRUNTIME/menu.vim

"开始编辑命令行时使用IM
set imcmdline

"解决consle输出的提示信息乱码
language messages zh_CN.utf-8



" 自动关闭补全窗口
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" set completeopt=menuone,menu,longest
"插入模式补全使用的选项
set completeopt=longest,menu

"语法高亮
syntax on
"自动缩进
set autoindent

"设置在哪些模式下使用鼠标功能，mouse=a 表示所有模式
set mouse=a
"设置 Backspace 和 Delete 的灵活程度，backspace=2 则没有任何限制
set backspace=2

"是否自动换行
set wrap
"正确地处理中文字符的折行和拼接
set formatoptions+=mM
"设置超过100字符自动换行
set textwidth=100

"智能对齐方式
set smartindent
"一个tab是4个字符
set tabstop=4
"按一次tab前进4个字符
set softtabstop=4
"用空格代替tab
set expandtab
"设置自动缩进
set ai!
"缩进的字符个数
set cindent shiftwidth=4
"set autoindent shiftwidth=4

"设置折叠
"设置折叠列数
set foldcolumn=4
"光标遇到折叠，折叠就打开
"set foldopen=all
"移开折叠时自动关闭折叠
"set foldclose=all
"zf zo zc zd zr zm zR zM zn zi zN
"依缩进折叠
"   manual  手工定义折叠
"   indent  更多的缩进表示更高级别的折叠
"   expr    用表达式来定义折叠
"   syntax  用语法高亮来定义折叠
"   diff    对没有更改的文本进行折叠
"   marker  对文中的标志折叠
set foldmethod=syntax
"启动时不要自动折叠代码
set foldlevel=100

"显示行号
set number

"打开光标的行列位置显示功能
set ruler

"如何处理有多种宽度的 Unicode 字符,设置显示中文引号
set ambiwidth=double

"行高亮
"set cursorline
"列高亮，与函数列表有冲突
"set cursorcolumn

"设置命令行的高度
set cmdheight=2

"高亮搜索的关键字
set hlsearch

"搜索忽略大小写
set ignorecase

"设置命令历史行数
set history=100

"启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI

"关闭终端响铃
set noerrorbells
set vb t_vb=
"不要闪烁
set novisualbell


"设置VIM状态栏
set laststatus=2 "显示状态栏(默认值为1, 无法显示状态栏)
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

"状态行颜色
"highlight StatusLine guifg=SlateBlue guibg=Yellow
"highlight StatusLineNC guifg=Gray guibg=White

"增强模式中的命令行自动完成菜单补全操作
set wildmenu

"缺省不产生备份文件
set nobackup
"在输入括号时光标会短暂地跳到与之相匹配的括号处，不影响输入
set showmatch

"设定文件浏览器目录为当前目录
set bsdir=buffer
"自动重新加载外部修改内容
set autoread

"允许在有未保存的修改时切换缓冲区
set hidden

"选中一段文字并全文搜索这段文字
vmap <silent> ,/ y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vmap <silent> ,? y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

"进入当前编辑的文件的目录
autocmd BufEnter * exec "cd %:p:h"

"保存文件的格式顺序
set fileformats=unix,dos

"配色（更多的配色见colors目录和http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/index-c.html）
colorscheme desert
set background=dark

"置粘贴模式，这样粘贴过来的程序代码就不会错位了。设置后SuperTab无效;
set paste

"记录上次关闭的文件及状态
set viminfo='10,\"100,:20,%,n~/._viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


"F2设置关闭搜索高亮
nmap <F2> :nohl<CR>

"给n映射一个快捷键，习惯上喜欢用F3
nmap <F3> :cn<CR>
"给N映射一个快捷键，习惯上喜欢用F3

nmap <S-F3> :cp<CR>

"F4映射为切换头文件
nmap <F4> :A<CR>
"Shift-F4映射为水平分割并切换头文件
nmap <S-F4> :AV<CR>
"Ctrl-F4映射为新建头文件并切换
nmap <C-F4> :AT<CR>

"<F5>刷新Buffer
nmap <F5>   :e<CR>

"F6单独切换打开nerd_tree（nerd_tree插件）
let g:NERDChristmasTree = 1              "色彩显示
let g:NERDTreeShowHidden = 1             "显示隐藏文件
let g:NERDTreeWinPos = 'left'            "窗口显示位置
let g:NERDTreeHighlightCursorline = 0    "高亮当前行
nmap <F6>  :NERDTreeToggle<CR>

"F7单独切换打开taglist（taglist插件）
let g:Tlist_Sort_Type = 'name'          "以名称顺序排序，默认以位置顺序(order)
let g:Tlist_Show_One_File = 1           "不同时显示多个文件的tag，只显示当前文件的
let g:Tlist_Exit_OnlyWindow = 1         "如果taglist窗口是最后一个窗口，则退出vim
lef g:Tlist_File_Fold_Auto_Close = 1    "当光标不在编辑文件里面的时候全部折叠
let g:Tlist_Use_Right_Window = 1        "在右侧窗口中显示taglist窗口
"let g:Tlist_Enable_Fold_Column = 1      "显示折叠边栏
let g:Tlist_Winwidth = 20                "设置taglist窗口宽度
"let g:Tlist_Inc_Winwidth = 0
"let g:Tlist_WinHeight = 5
let g:Tlist_GainFocus_On_ToggleOpen = 1 "TlistToggle打开taglist窗口时，如果希望输入焦点在taglist窗口中
nmap <F7>  :Tlist<CR>

"F9 WinManager
"-- WinManager setting --
"设置我们要管理的插件
let g:winManagerWindowLayout='FileExplorer,BufExplorer|TagList'
"如果所有编辑文件都关闭了，退出vim
let g:persistentBehaviour=0
"进入VIM自动打开winmanager
"let g:AutoOpenWinManager = 1
nmap <F9>  :WMToggle<CR>



"F10查看打开的文件列表（bufexplorer插件）
let g:bufExplorerDefaultHelp = 1
let g:bufExplorerDetailedHelp = 0
nmap <F10> :BufExplorer <CR>


"F12生成/更新tags文件
set tags=tags;

"自动切换当前目录为当前文件所在的目录
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

	"Ctrl + F12删除tags文件
function! DeleteTagsFile()
	"Linux下的删除方法
	"silent !rm tags
	silent !rm *.un*
	endfunction
	nmap <C-F12> :call DeleteTagsFile()<CR>
	"退出VIM之前删除tags文件
au VimLeavePre * call DeleteTagsFile()

"VimIM配置
let g:vimim_cloud = 'baidu,qq,google,sogou'
"let g:vimim_map = 'tab_as_gi'
"let g:vimim_mode = 'dynamic'
"let g:vimim_mycloud = 0
"let g:vimim_punctuation = 2
"let g:vimim_shuangpin = 0
"let g:vimim_toggle = 'pinyin,google,sogou'

"
"设置括号自动补全
"inoremap ( ()<Esc>i
"inoremap [ []<Esc>i
"inoremap { {<CR>}<Esc>O
"inoremap ' ''<Esc>i



"设置超过100行提示线
set colorcolumn=100


"YCM配置项
let g:ycm_key_list_select_completion = ['<c-tab>', '<Down>']  "重映射选择键
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
let g:ycm_confirm_extra_conf = 0                            "去掉使用外部配置确认提示
let g:ycm_complete_in_comments = 0                          "注释中不使用补全
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.c = ['.','->']
inoremap <leader>; <C-x><C-o>
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>ji :YcmCompleter GoToInclude<CR>
set noundofile
