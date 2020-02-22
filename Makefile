all:
	nim compile token/token.nim
	nim compile lexer/lexer.nim
	nim compile token/minitest.nim
	nim compile lexer/minitest.nim
	nim compile test_utils/test_utils.nim

compile: 
	nim compile --run token/token.nim
	nim compile --run lexer/lexer.nim

compile_test:
	nim compile --run token/minitest.nim
	nim compile --run lexer/minitest.nim

compile_lexer:
	nim compile --run token/minitest.nim
	nim compile --run lexer/minitest.nim

test:
	./token/minitest
	./lexer/minitest

test_token:
	./token/minitest

test_lexter:
	./lexer/minitest