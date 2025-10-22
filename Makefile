CC      := gcc
CFLAGS  := -Wall -Wextra -O2 -std=c11
LEX     := flex
YACC    := bison

LEX_C   := lex.yy.c
LEX_H   := lex.yy.h
YACC_C  := parser.tab.c
YACC_H  := parser.tab.h

BIN     := ccm

all: $(BIN)

$(YACC_C) $(YACC_H): parser.y
	$(YACC) -d -Wall -Wcounterexamples -o $(YACC_C) parser.y

$(LEX_C): lexer.l $(YACC_H)
	$(LEX) --header-file=$(LEX_H) -o $(LEX_C) lexer.l

$(BIN): $(YACC_C) $(LEX_C) main.c
	$(CC) $(CFLAGS) -o $(BIN) main.c $(YACC_C) $(LEX_C) -lfl

run: $(BIN)
	./$(BIN) tests/ok1.ccm

test: $(BIN)
	@echo "== OK 1 =="
	@./$(BIN) tests/ok1.ccm
	@echo "== OK 2 =="
	@./$(BIN) tests/ok2_cond.ccm
	@echo "== ERR LEX =="
	-@./$(BIN) tests/err_lex.ccm || true
	@echo "== ERR SYNTAX =="
	-@./$(BIN) tests/err_syntax.ccm || true

clean:
	rm -f $(BIN) $(LEX_C) $(LEX_H) $(YACC_C) $(YACC_H)
