" syntax highlighting for tidal/haskell
"
" Very minor modifications from syntax file of
" https://github.com/neovimhaskell/haskell-vim
"
" Heavily modified version of the haskell syntax
" highlighter to support haskell.
"
" author: raichoo (raichoo@googlemail.com)

if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

if get(g:, 'haskell_backpack', 0)
  syn keyword haskellBackpackStructure unit signature
  syn keyword haskellBackpackDependency dependency
endif

syn spell notoplevel
syn match haskellRecordField contained containedin=haskellBlock
  \ "[_a-z][a-zA-Z0-9_']*\(,\s*[_a-z][a-zA-Z0-9_']*\)*\_s\+::\_s"
  \ contains=
  \ haskellIdentifier,
  \ haskellOperators,
  \ haskellSeparator,
  \ haskellParens
syn match haskellTypeSig
  \ "^\s*\(where\s\+\|let\s\+\|default\s\+\)\?[_a-z][a-zA-Z0-9_']*#\?\(,\s*[_a-z][a-zA-Z0-9_']*#\?\)*\_s\+::\_s"
  \ contains=
  \ haskellWhere,
  \ haskellLet,
  \ haskellDefault,
  \ haskellIdentifier,
  \ haskellOperators,
  \ haskellSeparator,
  \ haskellParens
syn keyword haskellWhere where
syn keyword haskellLet let
syn match HaskellDerive "\<deriving\>\(\s\+\<\(anyclass\|instance\|newtype\|stock\)\>\)\?"
syn keyword haskellDeclKeyword module class instance newtype in
syn match haskellDecl "\<\(type\|data\)\>\s\+\(\<family\>\)\?"
syn keyword haskellDefault default
syn keyword haskellImportKeywords import qualified safe as hiding contained
syn keyword haskellForeignKeywords foreign export import ccall safe unsafe interruptible capi prim contained
syn region haskellForeignImport start="\<foreign\>" end="\_s\+::\s" keepend
  \ contains=
  \ haskellString,
  \ haskellOperators,
  \ haskellForeignKeywords,
  \ haskellIdentifier
syn match haskellImport "^\s*\<import\>\s\+\(\<safe\>\s\+\)\?\(\<qualified\>\s\+\)\?.\+\(\s\+\<as\>\s\+.\+\)\?\(\s\+\<hiding\>\)\?"
  \ contains=
  \ haskellParens,
  \ haskellOperators,
  \ haskellImportKeywords,
  \ haskellType,
  \ haskellLineComment,
  \ haskellBlockComment,
  \ haskellString,
  \ haskellPragma
syn keyword haskellKeyword do case of
if get(g:, 'haskell_enable_static_pointers', 0)
  syn keyword haskellStatic static
endif
syn keyword haskellConditional if then else

syn match haskellNumber "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>\|\<0[bB][10]\+\>"
syn match haskellFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"

syn match haskellSeparator  "[,;]"
syn region haskellParens matchgroup=haskellDelimiter start="(" end=")" contains=TOP,haskellTypeSig,@Spell
syn region haskellBrackets matchgroup=haskellDelimiter start="\[" end="]" contains=TOP,haskellTypeSig,@Spell
syn region haskellBlock matchgroup=haskellDelimiter start="{" end="}" contains=TOP,@Spell
syn keyword haskellInfix infix infixl infixr
syn keyword haskellBottom undefined error
syn match haskellOperators "[-!#$%&\*\+/<=>\?@\\^|~:.]\+\|\<_\>"
syn match haskellQuote "\<'\+" contained
syn match haskellQuotedType "[A-Z][a-zA-Z0-9_']*\>" contained
syn region haskellQuoted start="\<'\+" end="\>"
  \ contains=
  \ haskellType,
  \ haskellQuote,
  \ haskellQuotedType,
  \ haskellSeparator,
  \ haskellParens,
  \ haskellOperators,
  \ haskellIdentifier
syn match haskellLineComment "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$"
  \ contains=
  \ haskellTodo,
  \ @Spell
syn match haskellBacktick "`[A-Za-z_][A-Za-z0-9_\.']*#\?`"
syn region haskellString start=+"+ skip=+\\\\\|\\"+ end=+"+
  \ contains=@Spell


syn match haskellIdentifier "[_a-z][a-zA-z0-9_']*" contained
syn match haskellChar "\<'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'\>"
syn match haskellType "\<[A-Z][a-zA-Z0-9_']*\>"
syn region haskellBlockComment start="{-" end="-}"
  \ contains=
  \ haskellBlockComment,
  \ haskellTodo,
  \ @Spell
syn region haskellPragma start="{-#" end="#-}"
syn region haskellLiquid start="{-@" end="@-}"
"syn match haskellPreProc "^#.*$"
syn keyword haskellTodo TODO FIXME contained
" Treat a shebang line at the start of the file as a comment
syn match haskellShebang "\%^#!.*$"
if !get(g:, 'haskell_disable_TH', 0)
    syn match haskellQuasiQuoted "." containedin=haskellQuasiQuote contained
    syn region haskellQuasiQuote matchgroup=haskellTH start="\[[_a-zA-Z][a-zA-z0-9._']*|" end="|\]"
    syn region haskellTHBlock matchgroup=haskellTH start="\[\(d\|t\|p\)\?|" end="|]" contains=TOP
    syn region haskellTHDoubleBlock matchgroup=haskellTH start="\[||" end="||]" contains=TOP
endif
if get(g:, 'haskell_enable_typeroles', 0)
  syn keyword haskellTypeRoles phantom representational nominal contained
  syn region haskellTypeRoleBlock matchgroup=haskellTypeRoles start="type\s\+role" end="$" keepend
    \ contains=
    \ haskellType,
    \ haskellTypeRoles
endif
if get(g:, 'haskell_enable_quantification', 0)
  syn keyword haskellForall forall
endif
if get(g:, 'haskell_enable_recursivedo', 0)
  syn keyword haskellRecursiveDo mdo rec
endif
if get(g:, 'haskell_enable_arrowsyntax', 0)
  syn keyword haskellArrowSyntax proc
endif
if get(g:, 'haskell_enable_pattern_synonyms', 0)
  syn keyword haskellPatternKeyword pattern
endif

" Tidal-specific highlighting
"syn region tidalString start=,s\(ound\)\=\s*\zs", skip=,\\\\\|\\", end=,",
syn region tidalString start=,", skip=,\\\\\|\\", end=,",
  \ contains=tidalNumber,tidalSeparator,tidalDelimiter,tidalOperator
"syn keyword tidalRest ~ contained
"syn match tidalRest "[~]" contained
syn match tidalSeparator "[,]" contained
syn match tidalDelimiter "[\[\](){}<>]" contained
syn match tidalOperator "[\*/:\.%!]" contained
syn match tidalNumber "\<\d\+\>" contained
" syn match tidalConnection "^\s*d\d\+"

highlight link haskellBottom Macro
highlight link haskellTH Boolean
highlight link haskellIdentifier Identifier
highlight link haskellForeignKeywords Structure
highlight link haskellKeyword Keyword
highlight link haskellDefault Keyword
highlight link haskellConditional Conditional
highlight link haskellNumber Number
highlight link haskellFloat Float
highlight link haskellSeparator Delimiter
highlight link haskellDelimiter Delimiter
highlight link haskellInfix Keyword
highlight link haskellOperators Keyword
highlight link haskellQuote Operator
highlight link haskellShebang Comment
highlight link haskellLineComment Comment
highlight link haskellBlockComment Comment
highlight link haskellPragma SpecialComment
highlight link haskellLiquid SpecialComment
highlight link haskellString String
highlight link haskellChar String
highlight link haskellBacktick Operator
highlight link haskellQuasiQuoted String
highlight link haskellTodo Todo
highlight link haskellPreProc PreProc
highlight link haskellAssocType Type
highlight link haskellQuotedType Type
highlight link haskellType Type
highlight link haskellImportKeywords Include
if get(g:, 'haskell_classic_highlighting', 0)
  highlight link haskellDeclKeyword Keyword
  highlight link HaskellDerive Keyword
  highlight link haskellDecl Keyword
  highlight link haskellWhere Keyword
  highlight link haskellLet Keyword
else
  highlight link haskellDeclKeyword Structure
  highlight link HaskellDerive Structure
  highlight link haskellDecl Structure
  highlight link haskellWhere Structure
  highlight link haskellLet Structure
endif

if get(g:, 'haskell_enable_quantification', 0)
  highlight link haskellForall Operator
endif
if get(g:, 'haskell_enable_recursivedo', 0)
  highlight link haskellRecursiveDo Keyword
endif
if get(g:, 'haskell_enable_arrowsyntax', 0)
  highlight link haskellArrowSyntax Keyword
endif
if get(g:, 'haskell_enable_static_pointers', 0)
  highlight link haskellStatic Keyword
endif
if get(g:, 'haskell_classic_highlighting', 0)
  if get(g:, 'haskell_enable_pattern_synonyms', 0)
    highlight link haskellPatternKeyword Keyword
  endif
  if get(g:, 'haskell_enable_typeroles', 0)
    highlight link haskellTypeRoles Keyword
  endif
else
  if get(g:, 'haskell_enable_pattern_synonyms', 0)
    highlight link haskellPatternKeyword Structure
  endif
  if get(g:, 'haskell_enable_typeroles', 0)
    highlight link haskellTypeRoles Structure
  endif
endif

if get(g:, 'haskell_backpack', 0)
  highlight link haskellBackpackStructure Structure
  highlight link haskellBackpackDependency Include
endif

highlight link tidalString String
" highlight link tidalRest String
highlight link tidalDelimiter Special
highlight link tidalSeparator Special
highlight link tidalOperator Special
highlight link tidalNumber Number
" highlight link tidalConnection Identifier

let b:current_syntax = "tidal"
