"将键盘上的F4功能键映射为添加作者信息的快捷键
map <F4> ms:call TitleSmart()<cr>'s
function AddTitle()
        call append(0,"#Author     : pengshukai")
        call append(1,"#Email  : pengshukai@xx.com")
        call append(2,"#Date: ".strftime("%Y-%m-%d"))
        call append(3,"#Filename: ".expand("%:t"))
        call append(4,"#Description    : ")
        call append(5,"")
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf

"更新最近修改时间和文件名
function UpdateTitle()
        normal m'
        execute '/# *Date:/s@:.*$@\=strftime(": %Y-%m-%d")@'
        normal "
        normal mk
        execute '/# *Filename:/s@:.*$@\=": ".expand("%:t")@'
        execute "noh"
        normal 'k
        echohl WarningMsg | echo "Successful in updating the copy right."| echohl None
endfunction

"判断前10行代码里面，是否有Date这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleSmart()
        let n=1
        while n < 10
                let line = getline(n)
                if line =~'^\#\s*\S*Date:\S*.*$'
                        call UpdateTitle()
                        return
                endif
                let n = n + 1
        endwhile
        call AddTitle()
endfunction

"行号
set nu
"自动缩进
set autoindent
"语法高亮
syn on
"80加红线
au BufRead,BufNewFile *.c,*.cpp,*.lua,*.py match Error /\%80v.\%81v./
"与VI不兼容
set nocompatible
"退格键能删除的内容
set backspace=indent,eol,start
"TAB 空格数
set ts=4
"TAB 展开成为空格
set et
"设置平移宽度
set sw=4

"Bundle 设置
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
" My bundles here:
Bundle 'Valloric/YouCompleteMe'
filetype plugin indent on

"离开插入模式时关闭预览框
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"自动补全模式的提示信息种类
set completeopt=menu 

"搜索高亮
set hlsearch

