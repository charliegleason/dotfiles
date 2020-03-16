
syn clear

" Reserved keywords
syn keyword     FaustReserved           process with case
                                      \ import component library environment declare
                                      \ int float singleprecision doubleprecision quadprecision
                                      \ letrec class effect inputs outputs

" Primitives
" reference: https://github.com/grame-cncm/fausteditorweb/blob/master/src/monaco-faust/FaustLang.ts
syn keyword     FaustPrimitives         mem prefix int float
                                      \ rdtable rwtable select2 select3 ffunction fconstant fvariable 
                                      \ button checkbox vslider hslider nentry
                                      \ vgroup hgroup tgroup
                                      \ vbargraph hbargraph attach
                                      \ acos asin atan atan2 cos sin tan
                                      \ exp log log10 pow sqrt
                                      \ abs min max fmod remainder floor ceil rint
                                      \ seq par sum prod
                                      \ _

" Operators
" Mathematical
syn match       FaustOperator	"+"
syn match       FaustOperator	"-"
syn match       FaustOperator   "*"
syn match       FaustOperator   "/"
syn match       FaustOperator	"%"
" Comparison
syn match       FaustOperator	"<"
syn match       FaustOperator	">"
syn match       FaustOperator	">="
syn match       FaustOperator	"<="
syn match       FaustOperator	"!"
syn match       FaustOperator	"!="
syn match       FaustOperator	"=="
" Bitwise
syn match       FaustOperator   "&"
syn match       FaustOperator   "\^"
syn match       FaustOperator   "|"
syn match       FaustOperator   "<<"
syn match       FaustOperator   ">>"
syn match       FaustOperator   "\<xor\>"
" Delay
syn match       FaustOperator   "'"
syn match       FaustOperator   "@"

" Prefix operators
" Mathematical
syn match       FaustPrefixOperator	"+\ze("
syn match       FaustPrefixOperator	"-\ze("
syn match       FaustPrefixOperator     "*\ze("
syn match       FaustPrefixOperator     "/\ze("
syn match       FaustPrefixOperator	"%\ze("
" Comparison
syn match       FaustPrefixOperator     "<\ze("
syn match       FaustPrefixOperator     ">\ze("
syn match       FaustPrefixOperator     ">=\ze("
syn match       FaustPrefixOperator     "<=\ze("
syn match       FaustPrefixOperator     "!\ze("
syn match       FaustPrefixOperator     "!=\ze("
syn match       FaustPrefixOperator     "==\ze("
" Bitwise
syn match       FaustPrefixOperator     "&\ze("
syn match       FaustPrefixOperator     "\^\ze("
syn match       FaustPrefixOperator     "|\ze("
syn match       FaustPrefixOperator     "<<\ze("
syn match       FaustPrefixOperator     ">>\ze("
syn match       FaustPrefixOperator     "\<xor\>\ze("
" Delay
syn match       FaustPrefixOperator     "'\ze("
syn match       FaustPrefixOperator     "@\ze("

" Function composition
syn match       FaustCompositionOperator        ":"
syn match       FaustCompositionOperator        "<:"
syn match       FaustCompositionOperator        ":>"
syn match       FaustCompositionOperator        "\~"
syn match       FaustCompositionOperator        ","

" Parentheses
syn match       FaustParen   "("
syn match       FaustParen   ")"

" Function definitions
syn match       FaustFunctionDefinition         "^\s*\i\+\ze(.*)"

" Numbers
syn match       FaustNumber             "\<\d\+\.\=\d*\(e\(-\|+\)\=\d\+\)\="
syn match       FaustConstant           "\(ma\.\)*\(SR\|BS\|PI\|INFINITY\|MIN\|EPSILON\)\|\(pl\.\)*SR"

" Comments
syn match       FaustComment	"\/\/.*$"                       contains=FaustTodo
syn region      FaustComment	start="/\*"     end="\*/"       keepend extend contains=FaustTodo
syn match       FaustTodo       "TODO\|XXX"                     contained

" String
syn region      FaustString	start=+"+       skip=+\\\\\|\\"+        end=+"+         contains=FaustMetadata
syn region      FaustMetadata   start="\["      end="\]"        contained

" Color definition
hi link         FaustReserved                   Keyword
hi link         FaustPrimitives                 Identifier
hi link         FaustComment                    Comment
hi link         FaustTodo                       Todo
hi link         FaustString                     String
hi link         FaustMetadata                   SpecialChar
hi link         FaustNumber                     Number
hi link         FaustConstant                   Type
hi link         FaustOperator                   Special
hi link         FaustPrefixOperator             Identifier
hi link         FaustCompositionOperator        Special
hi link         FaustFunctionDefinition         Function
hi link         FaustParen                      Special

" The name of the syntax
let b:current_syntax = 'faust'
