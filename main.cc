#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

#include "main.h"
#include "global.h"
#include "trace.h"
#include "command.h"
#include "builtin.h"
#include "plumber.h"

#ifndef OS_X
#include "lib/tty.h"
#endif

SimpleCommand   *SimpleCommand::current;
CompoundCommand *CompoundCommand::current;

int
yyparse(void);

void
signal(int n) {
  switch (n) {
    case SIGINT:
    case SIGCHLD: {
      int status;
      int pid = wait(&status);
      if (pid != -1) { kill(getpid(), n); }
    } break;
  }
}

void
prompt(void) {
  if (isatty(0)) { printf(LGREEN("%s> "), SH_NAME); }
  fflush(stdout);
}

int
main(int argc, char **argv) {

  sigset(SIGINT,  signal);
  sigset(SIGCHLD, signal);

  if (isatty(0)) {
    // Print enabled debug levels
    DBG_ERR_N(DGRAY("DEBUG FLAGS : "));
    DBG_ERR_N(LRED("ERROR"));
    DBG_ERR_N(" ");
    DBG_WARN_N(YELLOW("WARNING"));
    DBG_WARN_N(" ");
    DBG_INFO_N(LBLUE("INFO"));
    DBG_INFO_N(" ");
    DBG_VERBOSE_N(DGRAY("VERBOSE"));
    DBG_ERR_N("\n\n");
  }

  Plumber::init();
  BuiltIn::init();

  CompoundCommand::current = new CompoundCommand();
  prompt();
  yyparse();
  return 0;
}
