# mc128
A Commodore Basic v7 Microcompiler

Based on the Basic Microcompiler by Vic Cortes, published in RUN 07/86.
Sourcecode for the C64 Version taken from https://github.com/EgonOlsen71/microcompiler

English video with some more information: https://youtu.be/Lr4Gfa-eXL0?si=Uo7CfAEQlq35l1Bd

Deutsches Video mit weiteren Informationen: https://youtu.be/i-afD_I1U60?si=KTCV1v689Jt9GXBC

## Source

`mc128.txt` is the source of `mc128.prg` as a [petcat](https://vice-emu.sourceforge.io/vice_15.html) listing (VICE).

Rebuild the program with:

```
petcat -w70 -l 1c01 -o mc128.prg -- mc128.txt
```

Note: write `st and 191` with spaces, otherwise petcat tokenizes `stand` as `s`+`TAN`+`d`.
