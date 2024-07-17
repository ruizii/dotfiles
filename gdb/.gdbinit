source ~/.gef-2024.06.py
alias stacksize = gef config context.nb_lines_stack
alias hidesrc = gef config context.layout "legend regs code stack -args -source threads -trace extra memory"
alias hideasm = gef config context.layout "legend regs -code source stack -args threads -trace extra memory"
alias showall = gef config context.layout "legend regs code source stack args threads trace extra memory"
