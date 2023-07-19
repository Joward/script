#!/bin/sh

# exit on error
set -e

# arr=( broot ncursesw ncurses libevent tmux )
arr=( ncursesw )

for tool in "${arr[@]}"
do
    PREFIX=$HOME/local/stow/$tool

    mkdir -p $PREFIX
    cd $PREFIX/../
    stow -D $tool
    rm -rfv $PREFIX

    if [ -d "${PREFIX}" ]; then
        echo "Info :: $tool is found in $PREFIX "
    else
        case $tool in  
            libevent)  
                package=$tool-2.1.8-stable.tar.gz
                ;;  
            tmux)  
                package=$tool-3.1b.tar.gz
                ;;  
            ncurses)  
                package=$tool-6.1.tar.gz
                ;;  
            ncursesw)  
                package=ncurses-6.1.tar.gz
                ;;  
            broot)  
                package=$tool-x86_64-linux.tar.gz
                ;;  
            fzf)  
                package=$tool-0.31.0-linux_amd64.tar.gz
                ;;  
            *)  
                echo "Error :: package name is not defined for $tool"
                exit 1
                ;;  
        esac

        URL=$HOME/local/package/$package
        TMP=$HOME/local/package/tmp_$tool

        # create our directories
        mkdir -p $TMP
        cd $TMP

        # download source files for $tool, $tool, and ncurses
        cp -vr $URL $tool.tar.gz

        # extract files, configure, and compile
        mkdir -p $TMP/src/build

        if [ $tool = "broot" ]; then
            tar xvzf $tool.tar.gz -C $TMP/src --strip-components=1
            cd src/build

            echo "$tool already have precompiled binaries"

            mkdir -p $PREFIX/bin
            cp -vr ../$tool $PREFIX/bin
            chmod +x $PREFIX/bin/*
        elif [ $tool = "fzf" ]; then
            tar xvzf $tool.tar.gz -C $TMP/src --strip-components=0
            cd src/build

            echo "$tool already have precompiled binaries"

            mkdir -p $PREFIX/bin
            cp -vr ../$tool $PREFIX/bin
            chmod +x $PREFIX/bin/*
        else
            tar xvzf $tool.tar.gz -C $TMP/src --strip-components=1
            cd src/build

            case $tool in  
                libevent)  
                    ../configure --prefix=$PREFIX --disable-shared
                    make
                    ;;  
                tmux)  
                    ../configure --prefix=$PREFIX CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include"
                    CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make
                    ;;  
                ncursesw)  
                    ../configure --prefix=$PREFIX --enable-widec
                    make
                    ;;  
                *)  
                    ../configure --prefix=$PREFIX
                    make
                    ;;  
            esac

            mkdir -p $PREFIX
            make install
        fi

        if [ $tool != "ncursesw" ]; then
            cd $PREFIX/../
            stow $tool
        fi

        # cleanup
        rm -rf $TMP

        echo "$tool is now available. You can optionally add $HOME/local/bin to your PATH."
    fi
done
