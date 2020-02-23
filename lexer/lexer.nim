import ../token/token
import ../utils/utils

type
  Lexer* = ref object
    input: string       # input all source.
    position: int       # current position
    readPosition: int   # next read position
    ch: byte            # current looking chara
  
# forward declaration
proc readPosition*(lex: Lexer): int {.inline.} 
proc readChar*(lex: Lexer): void {.inline.}
proc newLexer*(input: string): Lexer
proc skipWhitespace*(lex: Lexer): void
proc readIdentifiter*(lex: Lexer): string
proc readNumber*(lex: Lexer): string
proc readString*(lex: Lexer): string

# define setter
proc input*(lex: Lexer): string {.inline.} =
  return lex.input

proc position*(lex: Lexer): int {.inline.} =
  return lex.position

proc readPosition*(lex: Lexer): int {.inline.} =
  return lex.readPosition

proc ch*(lex: Lexer): byte {.inline.} =
  return lex.ch

# define new
proc newLexer*(input: string): Lexer =
  let lex = Lexer(input: input, position: 0, readPosition: 0, ch: 0.byte)
  lex.readChar()
  return lex

proc readChar*(lex: Lexer): void {.inline.} =
  if lex.readPosition >= lex.input.len():
    lex.ch = 0
  else:
    lex.ch = lex.input[lex.readPosition].byte
  
  lex.position = lex.readPosition
  lex.readPosition += 1

proc readNumber*(lex: Lexer): string =
  let position = lex.position
  while utils.is_digit(lex.ch):
    lex.readChar

  # instead of a <= x <= b, use a .. b
  return lex.input[position..( lex.position - 1)]

proc readIdentifiter*(lex: Lexer): string =
  let position = lex.position
  while utils.is_letter(lex.ch):
    lex.readChar

  # instead of a <= x <= b, use a .. b
  return lex.input[position..( lex.position - 1)]

proc readString*(lex: Lexer): string =
  # move to string from double quotation
  # ["]ab" → "[a]b"
  let position = lex.position + 1

  while true:
    lex.readChar
    if utils.is_str_end(lex.ch):
      break

  # instead of a <= x <= b, use a .. b
  return lex.input[position..( lex.position - 1)]

proc peekChar*(lex: Lexer): byte {.inline.} =
  if lex.readPosition >= lex.input.len():
    return 0
  else:
    return lex.input[lex.readPosition].byte

proc skipWhitespace*(lex: Lexer): void =
  while utils.is_space(lex.ch.char):
    lex.readChar()  