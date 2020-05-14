" Copyright 2007 Alex Norman
" This file is part of SCVIM.
"
" SCVIM is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" SCVIM is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with SCVIM.  If not, see <http://www.gnu.org/licenses/>.
"
" Vim syntax file
" Language:	supercollider
" Maintainer: Stephen Lumenta <stephen.lumenta@gmail.com>
" Version:	0.2
" Modified:	2012-03-31
"
" Maintainer: David Granström <info@davidgranstrom.com>
" Version:	0.3
" Modified:	2018-01-06
"
"
" Maintainer: Charlie Gleason <cgleasoniv@gmaill.com>
" Version:	0.4
" Modified:	2020-05-03

if exists("b:current_syntax")
  finish
endif

syn clear

" Errors (list from Error SC help page)
syn keyword scError             Error DeprecatedError MethodError DoesNotUnderstandError BinaryOpFailureError
                              \ ImmutableError MustBeBooleanError NotYetImplementedError OutOfContextReturnError
                              \ PrimitiveFailedError ShouldNotImplementError SubclassResponsibilityError
                              \ DirtPartTimeError

" Keywords
syn keyword scControl           case begin do forBy loop if while else try break rescue return
syn keyword scReserved          super this thisFunction thisMethod thisThread yield var classvar const arg

" Global variable
syn match scGlobalVar           "\~\l\i*"

" Symbols
syn region scSymbol             start=+'+ skip=+\\\\\|\\'+ end=+'+
" syn match scSymbol              "\v(\w|\\)@<!\'.{-}(\\)@<!\'"
syn match scSymbol              "\v\$@<!\\\i\i*"
syn match scSymbol              "\\\\"
syn match scSymbol              "\l\i*\ze:"

" Strings
syn region scString             start=+"+ skip=+\\\\\|\\"+ end=+"+      contains=scEscapedChar
syn match scEscapedChar         +\\"\|\\t\|\\n\|\\l\|\\r\|\\\\\(%\)\=+  contained
syn match scChar	        "\$\\\?."

" Built-in values
syn keyword scBuiltIn           true false nil
" Other (special) syntax elements (e.g. partial application)
syn keyword scSpecial           _

" TODO: simplify number regexes, if possible
" syn match scFloat               "\<\d\+\.\d+\(e\(-\|+\)\=\d\+\)\="
" syn match scInteger             "[^.]\<\zs\d\+"


syn match scArrayExpansion      "\.\."

" Binary operator adverbs
syn match scBinaryOpAdverb      "[+-\*/=&|<>?@^]\{1,2}[^.]\.\zs\(s\|f\|t\|x\|\d\+\)"

" Hexadecimal integer
syn match scNumber              "\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[xX]\x\+\%(_\x\+\)*\>"                              display
" Decimal integer
syn match scNumber              "\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0[dD]\)\=\%(0\|[1-9]\d*\%(_\d\+\)*\)\>"           display
" Octal integer
syn match scNumber              "\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[oO]\=\o\+\%(_\o\+\)*\>"                            display
" Binary integer
syn match scNumber              "\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[bB][01]\+\%(_[01]\+\)*\>"                          display
" Decimal floating point number
syn match scNumber	        "\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\.\d\+\%(_\d\+\)*\>"      display
syn match scNumber	        "\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\%(\.\d\+\%(_\d\+\)*\)\=\%([eE][-+]\=\d\+\%(_\d\+\)*\)\>"	display
" Match (2)pi as a number
syn match scNumber              "\<2\=pi\>"
syn keyword scNumber            inf


" Class name
syn match scClass               "\<\u\i\+"
" Class method definition
" syn match scClassMethodDef      "^\s*\*\zs\l\i*\ze\s*{"
" Method definition
" syn match scMethodDef           "^\s*\zs\l\i*\ze\s*{"
" Operator method definition
" syn match scMethodDef           "^\s*\zs[+-\*/=&|<>?@]\{1,3}\ze\s*{\_.*};"
"
" Block operator syntax and method definition
syn match scMethodBlock          "\<\l\i*\ze\s*{"


" Class method call (receiver notation)
syn match scMethodReceiver      "[^.]\=\.\zs\l\i\+\ze"

" Class method call (binary operator notation)
"syn match scMethodBinaryOp      "\([^(]\s*\|[^,]\s+\)\zs\l\i*\ze:"

" Function/method keyword argument (such as 'doneAction:')
" syn match scKeywordArg          "\((\_s*\|,\_s\+\)\zs\l\i*\ze:"


" Comments
syn keyword scTodo              TODO FIXME XXX TBD NOTE contained
syn match   scComment           "\/\/.*"                contains=@Spell,scTodo
syn region  scComment	        start="/\*"  end="\*/"  contains=@Spell,scTodo


" Keywords
hi def link scReserved          Keyword
hi def link scControl           Keyword
hi def link scError             Exception
hi def link scGlobalVar         String
hi def link scBuiltIn           Special
" Special syntax elements (e.g. nil, partial application)
hi def link scSpecial           Special

" Classes, methods, and functions
hi def link scClass             Identifier
hi def link scClassDef          Identifier
hi def link scClassMethodDef    Function
hi def link scMethodDef         Function
hi def link scFunctionDef       Function
hi def link scMethodBlock       Function
hi def link scMethodReceiver    Function
hi def link scMethodBinaryOp    Function
hi def link scFunction          Function
hi def link scBinaryOpAdverb    Function

" Symbols
hi def link scKeywordArg        String
hi def link scSymbol            String

" Strings
hi def link scString            Label
hi def link scChar              Label
hi def link scEscapedChar       SpecialChar

" Numbers
hi def link scNumber            Number

" Comments
hi def link scComment           Comment
hi def link scTodo	        Todo


let b:current_syntax = "supercollider"
