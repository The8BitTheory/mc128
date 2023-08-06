#RetroDevStudio.MetaData.BASIC:7169,BASIC V7.0 VDC
0 GOSUB 60000:GRAPHIC5:FAST:REM I1,VL,FW

1 PRINT"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
2 PRINT"1234567890!$%&/()="

# BASIC END
5 BE=(PEEK(4624)+PEEK(4625)*256)
6 C(0)=2:C(1)=4:C(2)=8:C(3)=6
7 DIM CL(39,1)

10 PRINT "BASIC START AT "(PEEK(45)+PEEK(46)*256)
12 PRINT "BASIC END AT   "BE

15 DEF FN HB(ZZ)=INT(ZZ/256):DEF FN LB(ZZ)=ZZ-INT(ZZ/256)*256

20 PRINT "INSERT DATADISK"
22 GETKEY I$

# VARIABLE END
23 VE=2048
24 PRINT "VARIABLE END AT "VE

# LIMIT BASIC VARIABLES TO $0800/2048
25 POKE 57,FN LB(VE):POKE 58,FN HB(VE)

# SR=START-ADDRESS OF BINARY IN RAM
# EA=END-ADDRESS OF BINARY IN RAM
# FW=FLAG WORD
30 SR=VE+8:FW=DEC("FE")
32 PRINT "START ADDRESS AT "SR

34 DIM N$(4)
35 N$(0)="TITLEPIC.ROV"
36 N$(1)="ENDPIC.ROV"
37 N$(2)="MENUPIC.ROV"
38 N$(3)="ROOMPIC.ROV"
39 N$(4)="SOFTPIC.ROV"

40 N=3

50 PRINT "LOADING MCD...";:BLOAD "MCD",B0:PRINT "DONE"

90 PRINT "LOADING "N$(N)"...";
91 BLOAD (N$(N)),B1,P(SR)

# READ LAST BYTE WRITTEN FROM ZEROPAGE
92 EA=PEEK(DEC("AE"))+PEEK(DEC("AF"))*256 
# COMPRESSED SIZE (INPUT SIZE)=END ADDRESS - START ADDRESS
93 CS=EA-SR

94 PRINT "DONE."
95 PRINT "END ADDRESS="EA CHR$(13)"FILESIZE="CS

96 BANK 1

# FL=FINAL LENGTH OF UNCOMPRESSED FILE
98 FL=PEEK(SR)+PEEK(SR+1)*256
99 PRINT "FINAL LENGTH="FL"BYTES"


####################
# DECOMPRESS IMAGE #
####################
# I1: CURRENT READ BYTE
# I2: CURRENT WRITE BYTE
# WE: WRITE END
100 US=EA+1:WE=US+FL:SR=SR+8
101 PRINT "READING FROM "SR" TO "EA
102 PRINT "WRITING FROM "US" TO "WE
103 I1=SR:I2=US:I4=0

# INPUT START
# OUTPUT START
# FINAL LENGTH

105 LB=FN LB(SR):HB=FN HB(SR):POKE VE+1,LB:POKE VE+2,HB
106 LB=FN LB(US):HB=FN HB(US):POKE VE+3,LB:POKE VE+4,HB
107 LB=FN LB(FL):HB=FN HB(FL):POKE VE+5,LB:POKE VE+6,HB

114 PRINT "SWITCH TO BANK 15": BANK 15
115 S=TI:SYS DEC("1300"):S=TI-S:
116 PRINT "BACK TO BANK 15":BANK15

122 PRINT "DURATION IN JIFFIES:"S

125 PRINT I1,I2

130 BSAVE (N$(N)+".1"),B1,P(US) TO P(US+FL)

140 N=N+1:IF N<=4 THEN 90
150 END

# DEAL WITH RLE FLAG WORD
# FC=FLAG COUNT
# FV=FLAG VALUE
# I3=COUNTER VARIABLE
200 FC=PEEK(I1):FV=PEEK(I1+1)
202 FOR I3=1 TO FC
204  POKE I2,FV:I2=I2+1
206 NEXT

208 I1=I1+2
210 RETURN



#######################
# FUNCTIONS AND STUFF #
#######################
60000 :REM FUNCTIONS AND STUFF

60010 B0=1:B1=2:B2=4:B3=8:B4=16:B5=32:B6=64:B7=128

60011 DEF FN B0(Z)=ABS((PEEK(Z) AND B0) > 0)
60012 DEF FN B1(Z)=ABS((PEEK(Z) AND B1) > 0)
60013 DEF FN B2(Z)=ABS((PEEK(Z) AND B2) > 0)
60014 DEF FN B3(Z)=ABS((PEEK(Z) AND B3) > 0)

60015 DEF FN B4(Z)=ABS((PEEK(Z) AND B4) > 0)
60016 DEF FN B5(Z)=ABS((PEEK(Z) AND B5) > 0)
60017 DEF FN B6(Z)=ABS((PEEK(Z) AND B6) > 0)
60018 DEF FN B7(Z)=ABS((PEEK(Z) AND B7) > 0)

60019 RETURN