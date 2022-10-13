My sh*t programming languagem written in lua
CASMBBXD (Clone assembly but bad XD)

This language inspired by brainfuck and assembly, is able to manipulate 256 memory cells, generating characters based
on 255 chars range.
I don't have plans to continue updating this project, when all commands is totally coded and functional I will not
commit more to this project, but made it open source <3
This is not a serious project, is just a simple test and challenge for me.


-=[ commands ]=-

captions :
    [.] - To do
    [X] - Done
    [-] - parcially Done
    [*] - redoning


[X] pop[+] <qnt>                        - increment a value from memory cell
[X] pop[-] <qnt>                        - decrement a value from memory cell
[X] jmp <qnt>                           - jump to memory cell
[X] inp <mcell>                         - wait for input and write data to that memory cell ()
[X] out <mcell>                         - print to screen a value
[X] outS <mcell>                        - print to screen a value
[X] osb <mcell>                         - print string matched and saved on string bank
[X] mth <val1;val2;val3...>             - join all values i a single string and save to string bank
[.] cmp[<val1>:<val2>]=<instruction>    - compares two memory values, if equals execute one instruction
[.] cmp[<val1>!<val2>]=<instruction>    - compares two memory values, if not equals execute one instruction
[.] psh[<mcell>] <mcell>                - saves a value from other memory cell
[.] frr <mcell>                         - return a cell to default value (zero)
[.] sfrr <mcell>                        - release a string from string bank


---------------------------------------------------------------------------

Check tests folder to see examples of this language XD