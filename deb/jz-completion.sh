#!/bin/bash
#
#  Copyright (C) 2013 bjarneh
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# -----------------------------------------------------------------------
#
#  Bash command completion file for jz
# 
#  Add this file somewhere where it gets sourced.
#  If you have sudo power it can be dropped into
#  /etc/bash_completion.d/. If not it can be sourced
#  by one of your startup scripts (.bashrc .profile ...)
#

_jz(){

    local cur prev preprev options special
    local implicit_all g_all proc_all

    # do not start with a '-'
    special="help
             clean
             doc
             test"

    # will include javac/javadoc options also
    options="-author
             -bootclasspath
             -bottom
             -breakiterator
             -charset
             -classpath
             -clean
             -dep
             -deprecation
             -doc
             -docencoding
             -docfilessubdirs
             -doclet
             -docletpath
             -doctitle
             -dryrun
             -dst
             -encoding
             -endorseddirs
             -exclude
             -extdirs
             -footer
             -full
             -g
             -g:lines
             -g:none
             -g:source
             -g:vars
             -header
             -help
             -htm
             -implicit:class
             -implicit:none
             -javahome
             -lib
             -link
             -linksource
             -list
             -locale
             -main
             -manifest
             -name
             -nocomment
             -nodeprecated
             -nodeprecatedlist
             -nohelp
             -noindex
             -nolink
             -nonavbar
             -nosince
             -notimestamp
             -notree
             -nowarn
             -obj
             -output
             -overview
             -pack
             -package
             -private
             -processor
             -processorpath
             -proc:none
             -proc:only
             -protected
             -public
             -quiet
             -res
             -s
             -serialwarn
             -source
             -sourcepath
             -sourcetab
             -splitindex
             -src
             -strip
             -stylesheetfile
             -subpackages
             -taglet
             -tagletpath
             -target
             -test
             -top
             -use
             -verbose
             -version
             -Werror
             -windowtitle
             -Xdocrootparent
             -zlib"

    implicit_all="class none"
    g_all="none lines vars source"
    proc_all="none only"

    COMPREPLY=()

    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cur="${COMP_WORDS[COMP_CWORD]}"

    # special case COMP_WORDS treats -a: as two words [-a, :]
    if [[ "${cur}" == ":" ]]; then
        case "${prev}" in
        '-g')
             COMPREPLY=($(compgen -o nospace -W "${g_all}" -- ""))
        ;;
        '-implicit')
             COMPREPLY=($(compgen -o nospace -W "${implicit_all}" -- ""))
        ;;
        '-proc')
             COMPREPLY=($(compgen -o nospace -W "${proc_all}" -- ""))
        ;;
        esac

        if [ "${#COMPREPLY[@]}" -gt 1 ]; then
            return 0
        fi
    fi

    # special case continued
    if [[ "${prev}" == ":" ]]; then
        if [ "${#COMP_WORDS[@]}" -gt 3 ]; then
            preprev="${COMP_WORDS[COMP_CWORD-2]}"
            case "${preprev}" in
            '-g')
                 COMPREPLY=($(compgen -W "${g_all}" -- "${cur}"))
            ;;
            '-implicit')
                 COMPREPLY=($(compgen -W "${implicit_all}" -- "${cur}"))
            ;;
            '-proc')
                 COMPREPLY=($(compgen -W "${proc_all}" -- "${cur}"))
            ;;
            esac
            return 0
        fi
    fi

    if [[ "${cur}" == -* ]]; then
        COMPREPLY=( $(compgen -W "${options}" -- "${cur}") )
        return 0
    fi

    case "${cur}" in
        c* | t* | h* | d*)
          COMPREPLY=( $(compgen -W "${special}" -- "${cur}") )
          if [ "${#COMPREPLY[@]}" -gt 1 ]; then
              return 0
          fi
        ;;
    esac

    return 1
}

## directories only -d was a bit to strict
## using -o nospace requires extra fiddle
complete -o default -F _jz jz
