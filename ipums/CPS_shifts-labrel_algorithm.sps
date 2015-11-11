* Encoding: UTF-8.
/* Toepasbaar op de jaarlijkse ASEC surveys, via cps.ipums.org. Use file "CPS Yearly 1962-2015.sav"
WEIGHT BY WTSUPP.

NUMERIC LR_SHIFTLY (f4).
IF (CLASSWKR = CLASSWLY) LR_SHIFTLY = 0.
IF (CLASSWKR ~= CLASSWLY) LR_SHIFTLY = 1.
EXECUTE.
/* Shift in laatste jaar ja (1) of nee (0).

VARIABLE LABELS LR_SHIFTLY "Shift in labour relation in preceding year?".
VALUE LABELS LR_SHIFTLY
0 "No"
1 "Yes".
EXECUTE.

IF  (CLASSWKR = 99) LR_SHIFTLY=0. 
EXECUTE.

STRING LR_SHIFTLYD (a4).
EXECUTE.
/* Dit is de gedetailleerde variant van de labrel shift.

COMPUTE LR_SHIFTLYD = concat(string(CLASSWLY,f2),string(CLASSWKR,f2)).
EXECUTE. 
IF  (CLASSWKR = 0) LR_SHIFTLYD = concat(string(CLASSWLY,f2),"0",string(CLASSWKR,f1)).
EXECUTE. 
IF  (CLASSWLY = 0) LR_SHIFTLYD = concat("0",string(CLASSWLY,f1),string(CLASSWKR,f2)).
EXECUTE. 
IF  (CLASSWLY = 0 & CLASSWKR = 0) LR_SHIFTLYD = concat("0",string(CLASSWLY,f1),"0",string(CLASSWKR,f1)).
EXECUTE. 

ALTER TYPE LR_SHIFTLYD (f4).
EXECUTE.

VARIABLE LABELS LR_SHIFTLYD "Shift in labour relation in preceding year, detailed".
ADD VALUE LABELS LR_SHIFTLYD 
10 "NIU to Self-employed"
13 "NIU to Self-employed, not incorporated"
14 "NIU to Self-employed, incorporated"
21 "NIU to Wage/salary, private"
24 "NIU to Wage/salary, government"
25 "NIU to Wage/salary, federal government employee"
26 "NIU to Wage/salary, armed forces"
27 "NIU to Wage/salary, state government employee"
28 "NIU to Wage/salary, local government employee"
29 "NIU to Unpaid family worker"
99 "NIU to Missing/Unknown"
1000 "Self-employed to NIU"
1021 "Self-employed to Wage/salary, private"
1024 "Self-employed to Wage/salary, government"
1029 "Self-employed to Unpaid family worker"
1300 "Self-employed, not incorporated to NIU"
1310 "Self-employed, not incorporated to Self-employed"
1314 "Self-employed, not incorporated to Self-employed, incorporated"
1321 "Self-employed, not incorporated to Wage/salary, private"
1324 "Self-employed, not incorporated to Wage/salary, government"
1325 "Self-employed, not incorporated to Wage/salary, federal government employee"
1326 "Self-employed, not incorporated to Wage/salary, armed forces"
1327 "Self-employed, not incorporated to Wage/salary, state government employee"
1328 "Self-employed, not incorporated to Wage/salary, local government employee"
1329 "Self-employed, not incorporated to Unpaid family worker"
1400 "Self-employed, incorporated to NIU"
1410 "Self-employed, incorporated to Self-employed"
1413 "Self-employed, incorporated to Self-employed, not incorporated"
1421 "Self-employed, incorporated to Wage/salary, private"
1424 "Self-employed, incorporated to Wage/salary, government"
1425 "Self-employed, incorporated to Wage/salary, federal government employee"
1426 "Self-employed, incorporated to Wage/salary, armed forces"
1427 "Self-employed, incorporated to Wage/salary, state government employee"
1428 "Self-employed, incorporated to Wage/salary, local government employee"
1429 "Self-employed, incorporated to Unpaid family worker"
2200 "Wage/salary, private, for profit to NIU"
2210 "Wage/salary, private, for profit to Self-employed"
2213 "Wage/salary, private, for profit to Self-employed, not incorporated"
2214 "Wage/salary, private, for profit to Self-employed, incorporated"
2224 "Wage/salary, private, for profit to Wage/salary, government"
2225 "Wage/salary, private, for profit to Wage/salary, federal government employee"
2226 "Wage/salary, private, for profit to Wage/salary, armed forces"
2227 "Wage/salary, private, for profit to Wage/salary, state government employee"
2228 "Wage/salary, private, for profit to Wage/salary, local government employee"
2229 "Wage/salary, private, for profit to Unpaid family worker"
2299 "Wage/salary, private, for profit to Missing/Unknown"
2400 "Wage/salary, government to NIU"
2410 "Wage/salary, government to Self-employed"
2421 "Wage/salary, government to Wage/salary, private"
2429 "Wage/salary, government to Unpaid family worker"
2499 "Wage/salary, government to Missing/Unknown"
2500 "Wage/salary, federal government employee to NIU"
2510 "Wage/salary, federal government employee to Self-employed"
2513 "Wage/salary, federal government employee to Self-employed, not incorporated"
2514 "Wage/salary, federal government employee to Self-employed, incorporated"
2521 "Wage/salary, federal government employee to Wage/salary, private"
2524 "Wage/salary, federal government employee to Wage/salary, government"
2527 "Wage/salary, federal government employee to Wage/salary, state government employee"
2528 "Wage/salary, federal government employee to Wage/salary, local government employee"
2529 "Wage/salary, federal government employee to Unpaid family worker"
2700 "Wage/salary, state government employee to NIU"
2710 "Wage/salary, state government employee to Self-employed"
2713 "Wage/salary, state government employee to Self-employed, not incorporated"
2714 "Wage/salary, state government employee to Self-employed, incorporated"
2721 "Wage/salary, state government employee to Wage/salary, private"
2724 "Wage/salary, state government employee to Wage/salary, government"
2725 "Wage/salary, state government employee to Wage/salary, federal government employee"
2726 "Wage/salary, state government employee to Wage/salary, armed forces"
2728 "Wage/salary, state government employee to Wage/salary, local government employee"
2729 "Wage/salary, state government employee to Unpaid family worker"
2800 "Wage/salary, local government employee to NIU"
2810 "Wage/salary, local government employee to Self-employed"
2813 "Wage/salary, local government employee to Self-employed, not incorporated"
2814 "Wage/salary, local government employee to Self-employed, incorporated"
2821 "Wage/salary, local government employee to Wage/salary, private"
2824 "Wage/salary, local government employee to Wage/salary, government"
2825 "Wage/salary, local government employee to Wage/salary, federal government employee"
2826 "Wage/salary, local government employee to Wage/salary, armed forces"
2827 "Wage/salary, local government employee to Wage/salary, state government employee"
2829 "Wage/salary, local government employee to Unpaid family worker"
2900 "Unpaid family worker to NIU"
2910 "Unpaid family worker to Self-employed"
2913 "Unpaid family worker to Self-employed, not incorporated"
2914 "Unpaid family worker to Self-employed, incorporated"
2921 "Unpaid family worker to Wage/salary, private"
2924 "Unpaid family worker to Wage/salary, government"
2925 "Unpaid family worker to Wage/salary, federal government employee"
2926 "Unpaid family worker to Wage/salary, armed forces"
2927 "Unpaid family worker to Wage/salary, state government employee"
2928 "Unpaid family worker to Wage/salary, local government employee"
0 "No change: NIU"
1010 "No change: Self-employed"
1313 "No change: Self-employed, not incorporated"
1414 "No change: Self-employed, incorporated"
2020 "No change: Works for wages or salary"
2121 "No change: Wage/salary, private"
2222 "No change: Wage/salary, private, for profit"
2323 "No change: Wage/salary, private, nonprofit"
2424 "No change: Wage/salary, government"
2525 "No change: Wage/salary, federal government employee"
2626 "No change: Wage/salary, armed forces"
2727 "No change: Wage/salary, state government employee"
2828 "No change: Wage/salary, local government employee"
2929 "No change: Unpaid family worker"
9999 "No change: Missing/Unknown"
2221 "No change: Wage/salary, private"
2526 "No change: Wage/salary, armed forces" 
2100 "Wage/salary, private to NIU"
2110 "Wage/salary, private to Self-employed"
2129 "Wage/salary, private to Unpaid family worker"
2124 "Wage/salary, private to Wage/salary, government"
2199 "Wage/salary, private to Missing/Unknown".

NUMERIC LR_SHIFTLYA (f4).
COMPUTE LR_SHIFTLYA = LR_SHIFTLYD.
EXECUTE.
/* Dit is de geaggregeerde variant, met minder mogelijke waarden.

VARIABLE LABELS LR_SHIFTLYA "Shift in labour relation in preceding year, aggregated".
ADD VALUE LABELS LR_SHIFTLYA 
10 "NIU to Self-employed"
13 "NIU to Self-employed, not incorporated"
14 "NIU to Self-employed, incorporated"
21 "NIU to Wage/salary, private"
24 "NIU to Wage/salary, government"
25 "NIU to Wage/salary, federal government employee"
26 "NIU to Wage/salary, armed forces"
27 "NIU to Wage/salary, state government employee"
28 "NIU to Wage/salary, local government employee"
29 "NIU to Unpaid family worker"
99 "NIU to Missing/Unknown"
1000 "Self-employed to NIU"
1021 "Self-employed to Wage/salary, private"
1024 "Self-employed to Wage/salary, government"
1029 "Self-employed to Unpaid family worker"
1300 "Self-employed, not incorporated to NIU"
1310 "Self-employed, not incorporated to Self-employed"
1314 "Self-employed, not incorporated to Self-employed, incorporated"
1321 "Self-employed, not incorporated to Wage/salary, private"
1324 "Self-employed, not incorporated to Wage/salary, government"
1325 "Self-employed, not incorporated to Wage/salary, federal government employee"
1326 "Self-employed, not incorporated to Wage/salary, armed forces"
1327 "Self-employed, not incorporated to Wage/salary, state government employee"
1328 "Self-employed, not incorporated to Wage/salary, local government employee"
1329 "Self-employed, not incorporated to Unpaid family worker"
1400 "Self-employed, incorporated to NIU"
1410 "Self-employed, incorporated to Self-employed"
1413 "Self-employed, incorporated to Self-employed, not incorporated"
1421 "Self-employed, incorporated to Wage/salary, private"
1424 "Self-employed, incorporated to Wage/salary, government"
1425 "Self-employed, incorporated to Wage/salary, federal government employee"
1426 "Self-employed, incorporated to Wage/salary, armed forces"
1427 "Self-employed, incorporated to Wage/salary, state government employee"
1428 "Self-employed, incorporated to Wage/salary, local government employee"
1429 "Self-employed, incorporated to Unpaid family worker"
2200 "Wage/salary, private, for profit to NIU"
2210 "Wage/salary, private, for profit to Self-employed"
2213 "Wage/salary, private, for profit to Self-employed, not incorporated"
2214 "Wage/salary, private, for profit to Self-employed, incorporated"
2224 "Wage/salary, private, for profit to Wage/salary, government"
2225 "Wage/salary, private, for profit to Wage/salary, federal government employee"
2226 "Wage/salary, private, for profit to Wage/salary, armed forces"
2227 "Wage/salary, private, for profit to Wage/salary, state government employee"
2228 "Wage/salary, private, for profit to Wage/salary, local government employee"
2229 "Wage/salary, private, for profit to Unpaid family worker"
2299 "Wage/salary, private, for profit to Missing/Unknown"
2400 "Wage/salary, government to NIU"
2410 "Wage/salary, government to Self-employed"
2421 "Wage/salary, government to Wage/salary, private"
2429 "Wage/salary, government to Unpaid family worker"
2499 "Wage/salary, government to Missing/Unknown"
2500 "Wage/salary, federal government employee to NIU"
2510 "Wage/salary, federal government employee to Self-employed"
2513 "Wage/salary, federal government employee to Self-employed, not incorporated"
2514 "Wage/salary, federal government employee to Self-employed, incorporated"
2521 "Wage/salary, federal government employee to Wage/salary, private"
2524 "Wage/salary, federal government employee to Wage/salary, government"
2527 "Wage/salary, federal government employee to Wage/salary, state government employee"
2528 "Wage/salary, federal government employee to Wage/salary, local government employee"
2529 "Wage/salary, federal government employee to Unpaid family worker"
2700 "Wage/salary, state government employee to NIU"
2710 "Wage/salary, state government employee to Self-employed"
2713 "Wage/salary, state government employee to Self-employed, not incorporated"
2714 "Wage/salary, state government employee to Self-employed, incorporated"
2721 "Wage/salary, state government employee to Wage/salary, private"
2724 "Wage/salary, state government employee to Wage/salary, government"
2725 "Wage/salary, state government employee to Wage/salary, federal government employee"
2726 "Wage/salary, state government employee to Wage/salary, armed forces"
2728 "Wage/salary, state government employee to Wage/salary, local government employee"
2729 "Wage/salary, state government employee to Unpaid family worker"
2800 "Wage/salary, local government employee to NIU"
2810 "Wage/salary, local government employee to Self-employed"
2813 "Wage/salary, local government employee to Self-employed, not incorporated"
2814 "Wage/salary, local government employee to Self-employed, incorporated"
2821 "Wage/salary, local government employee to Wage/salary, private"
2824 "Wage/salary, local government employee to Wage/salary, government"
2825 "Wage/salary, local government employee to Wage/salary, federal government employee"
2826 "Wage/salary, local government employee to Wage/salary, armed forces"
2827 "Wage/salary, local government employee to Wage/salary, state government employee"
2829 "Wage/salary, local government employee to Unpaid family worker"
2900 "Unpaid family worker to NIU"
2910 "Unpaid family worker to Self-employed"
2913 "Unpaid family worker to Self-employed, not incorporated"
2914 "Unpaid family worker to Self-employed, incorporated"
2921 "Unpaid family worker to Wage/salary, private"
2924 "Unpaid family worker to Wage/salary, government"
2925 "Unpaid family worker to Wage/salary, federal government employee"
2926 "Unpaid family worker to Wage/salary, armed forces"
2927 "Unpaid family worker to Wage/salary, state government employee"
2928 "Unpaid family worker to Wage/salary, local government employee"
0 "No change: NIU"
1010 "No change: Self-employed"
1313 "No change: Self-employed, not incorporated"
1414 "No change: Self-employed, incorporated"
2020 "No change: Works for wages or salary"
2121 "No change: Wage/salary, private"
2222 "No change: Wage/salary, private, for profit"
2323 "No change: Wage/salary, private, nonprofit"
2424 "No change: Wage/salary, government"
2525 "No change: Wage/salary, federal government employee"
2626 "No change: Wage/salary, armed forces"
2727 "No change: Wage/salary, state government employee"
2828 "No change: Wage/salary, local government employee"
2929 "No change: Unpaid family worker"
9999 "No change: Missing/Unknown"
2221 "No change: Wage/salary, private"
2526 "No change: Wage/salary, armed forces" 
2100 "Wage/salary, private to NIU"
2110 "Wage/salary, private to Self-employed"
2129 "Wage/salary, private to Unpaid family worker"
2124 "Wage/salary, private to Wage/salary, government"
2199 "Wage/salary, private to Missing/Unknown".
EXECUTE.


RECODE LR_SHIFTLYA (10=10)
(13=10)
(14=10)
(21=21)
(24=24)
(25=24)
(26=24)
(27=24)
(28=24)
(29=29)
(99=99)
(1000=1000)
(1021=1021)
(1024=1024)
(1029=1029)
(1300=1000)
(1310=1010)
(1314=1010)
(1321=1021)
(1324=1024)
(1325=1024)
(1326=1024)
(1327=1024)
(1328=1024)
(1329=1029)
(1400=1000)
(1410=1010)
(1413=1010)
(1421=1021)
(1424=1024)
(1425=1024)
(1426=1024)
(1427=1024)
(1428=1024)
(1429=1029)
(2200=2100)
(2210=2110)
(2213=2110)
(2214=2110)
(2224=2124)
(2225=2124)
(2226=2124)
(2227=2124)
(2228=2124)
(2229=2129)
(2299=2199)
(2400=2400)
(2410=2410)
(2421=2421)
(2429=2429)
(2499=2499)
(2500=2400)
(2510=2410)
(2513=2410)
(2514=2410)
(2521=2421)
(2524=2424)
(2527=2424)
(2528=2424)
(2529=2429)
(2700=2400)
(2710=2410)
(2713=2410)
(2714=2410)
(2721=2421)
(2724=2424)
(2725=2424)
(2726=2424)
(2728=2424)
(2729=2429)
(2800=2400)
(2810=2410)
(2813=2410)
(2814=2410)
(2821=2421)
(2824=2424)
(2825=2424)
(2826=2424)
(2827=2424)
(2829=2429)
(2900=2900)
(2910=2910)
(2913=2910)
(2914=2910)
(2921=2921)
(2924=2924)
(2925=2924)
(2926=2924)
(2927=2924)
(2928=2924)
(0=0)
(1010=1010)
(1313=1010)
(1414=1010)
(2020=2020)
(2121=2121)
(2222=2121)
(2323=2121)
(2424=2424)
(2525=2424)
(2626=2424)
(2727=2424)
(2828=2424)
(2929=2929)
(9999=9999)
(2221=2121)
(2526=2424).
EXECUTE.



IF (LR_SHIFTLYA = 2424 | LR_SHIFTLYA = 1010) LR_SHIFTLY = 0. 
EXECUTE.
