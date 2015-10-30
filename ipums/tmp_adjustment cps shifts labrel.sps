STRING LR_SHIFTLYD (f4).
EXECUTE.
COMPUTE LR_SHIFTLYD = concat(string(CLASSWLY,f2),string(CLASSWKR,f2)).
EXECUTE. 
IF  (CLASSWKR = 0) LR_SHIFTLYD=concat(string(CLASSWLY,f2),"0",string(CLASSWKR,f1)).
EXECUTE. 

IF  (CLASSWLY = 0) LR_SHIFTLYD=concat("0",string(CLASSWLY,f1),string(CLASSWKR,f2)).
EXECUTE. 

IF  (CLASSWLY = 0 & CLASSWKR = 0) LR_SHIFTLYD=concat("0",string(CLASSWLY,f1),"0",string(CLASSWKR,f1)
    ).
EXECUTE. 

/* LR_SHIFTLYD kan hierna worden gewijzigd in een Numeric value */
