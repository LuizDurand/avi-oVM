#include <stdio.h>
#include <stdlib.h>

int yyparse(void* scanner);
int yylex_init_extra(void* user_defined, void** scanner);
int yylex_destroy(void* scanner);
void yyset_in(FILE* in_str, void* scanner);

typedef struct {
  int col;
} yyg_extra_t;

int main(int argc, char** argv) {
  void* scanner = NULL;
  yyg_extra_t extra = { .col = 1 };

  if (yylex_init_extra(&extra, &scanner)) {
    fprintf(stderr, "Falha ao inicializar scanner.\n");
    return 1;
  }

  if (argc > 1) {
    FILE* f = fopen(argv[1], "r");
    if (!f) {
      perror("Erro ao abrir arquivo");
      yylex_destroy(scanner);
      return 1;
    }
    yyset_in(f, scanner);
  } else {
    yyset_in(stdin, scanner);
  }

  int rc = yyparse(scanner);
  if (rc == 0) {
    printf("OK: análise léxica e sintática concluída sem erros.\n");
  } else {
    printf("Falhou: ver mensagens acima.\n");
  }

  yylex_destroy(scanner);
  return rc;
}
