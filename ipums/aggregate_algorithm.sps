* Encoding: UTF-8.
GET FILE='/Users/RombertSt/Desktop/IPUMS/USA IPUMS 1850-2010.sav'.
WEIGHT BY PERWT.
NUMERIC LABREL (f16).
EXECUTE.

VARIABLE LABELS LABREL "Labour relations, taxonomy v.2015".
VALUE LABELS LABREL
-1 "-1: Not classifiable (as presented in source)" 	 
1 "1: Cannot work or cannot be expected to work"
2 "2: Affluent"
3 "3: Unemployed"
41 "4a: Leading household producers"
42 "4b: Household kin producers"
5 "5: Household kin non-producers"
6 "6: Household servants"
7 "7: Redistributive workers"
8 "8: Obligatory labourers"
9 "9: Indentured tributary labourers"
10 "10: Tributary serfs" 
11 "11: Tributary slaves"
121 "12a: Self-employed leading producer"
122 "12b: Self-employed kin producer"
13 "13: Employers"
131 "13.1: Employers of free wage earners"
132 "13.2: Employers of indentured labourers"
133 "13.3: Employers of serfs"
134 "13.4: Employers of slaves"
14 "14: Wage earners for the market"
141 "14.1: Wage earners for the market, sharecropping workers"
142 "14.2: Wage earners for the market, piece-rate workers"
143 "14.3: Wage earners for the market, time-rate workers"
144 "14.4: Wage earners for the market, cooperative subcontracting"
15 "15: Indentured labourers"
16 "16: Serfs"
17 "17: Slaves"
171 "17.1: Slaves working for proprietor"
172 "17.2: Slaves working for hire"
18 "18: Wage earners for non-market institutions"
181 "18.1: Wage earners for non-market institutions, sharecropping workers"
182 "18.2: Wage earners for non-market institutions, piece-rate workers"
183 "18.3: Wage earners for non-market institutions, time-rate workers"
105 "1 or 5: Cannot work or cannot be expected to work or Household kin non-producer"
121013 "12a or 13: Self-employed leading producer or Employer"
14018 "14 or 18: Wage earners for the market or Wage earners for non-market institutions"
121014 "12a or 14: Self-employed leading producer or Wage earners for the market"
121013014 "12a or 13 or 14: Self-employed leading producer or Employer or Wage earners for the market"
121014018 "12a or 14 or 18: Self-employed leading producer or Wage earners for the market or For non-market institutions".
EXECUTE.

/* IF  (MISSING(LABREL)  & AGE <= 15) LABREL=-1. 
/* EXECUTE. 
/* Dit vernietigt direct alle kans om kinderarbeid er uit te halen, maar zorgt wel voor een consistente vergelijking over tijd. 
/* Ongeveer 1-3% van alle individuen van 16jr (sic, oude berekening) en jonger uit het VS bestand is wel degelijk werkzaam volgens de census. 
/* Vaak gaat het dan om 14, 15jarigen. Meestal zijn mensen jonger dan dat niet ondervraagd.
/* UPDATE: Een betere manier is om dit weg te laten (we vergelijken immers individuen, en de consistente vergelijking is vooral nuttig bij geaggregeerde data). 
/* Mochten we toch geaggregeerde data willen, is het super makkelijk om achteraf alles af te toppen, ipv vooraf.
IF  (MISSING(LABREL) & (OCC1950 = 987)) LABREL=8. 
EXECUTE.
/* Inmates: hier al, omdat deze anders of bij labrel 1, 105 of 3 terecht komen.
IF  (MISSING(LABREL) & OCC1950 = 991) LABREL=2. 
EXECUTE.
/* Gentleman/lady/at leisure, zelfde reden.
IF  (MISSING(LABREL)  & (EMPSTATD = 32 | EMPSTATD = 33)) LABREL=1. 
EXECUTE.
IF  (MISSING(LABREL)  & (EMPSTATD = 34)) LABREL=105. 
EXECUTE.
/* "Not in labour force, other" > restant na aftrek 'Housework', 'School', 'Unable'. O.a. "people who simply choose not to work or to look for work"? Maar afgaand van enkele voorbeelden lijkt affluent (2) toch niet helemaal juist.
IF  (MISSING(LABREL)  & (EMPSTATD = 20 | EMPSTATD = 21 | EMPSTATD = 22)) LABREL=3. 
EXECUTE. 
IF  (MISSING(LABREL)  & (EMPSTATD = 31)) LABREL=5. 
EXECUTE. 
IF  (MISSING(LABREL)  & (EMPSTATD = 30)) LABREL=105. 
EXECUTE.
/* Volgende set hier nu ingevoegd, om te voorkomen dat deze beroepen worden verdeeld over alles en nog wat.
IF  (MISSING(LABREL) & (OCC1950 = 9 | OCC1950 = 595)) LABREL=18.
EXECUTE.
IF  (MISSING(LABREL) & OCC1950 = 820) LABREL=14.
EXECUTE.
IF  (MISSING(LABREL) & OCC1950 = 830) LABREL=122.
EXECUTE.
IF  (MISSING(LABREL) & OCC1950 = 840) LABREL=121.
EXECUTE.
IF  (MISSING(LABREL) & (OCC1950 = 980 | OCC1950 = 981 | OCC1950 = 982)) LABREL=5.
EXECUTE.
IF  (MISSING(LABREL) & (OCC1950 = 983 | OCC1950 = 984 | OCC1950 = 986)) LABREL=1.
EXECUTE.
IF  (MISSING(LABREL) & (OCC1950 = 985 | OCC1950 = 990)) LABREL=3.
EXECUTE.
IF  (MISSING(LABREL) & OCC1950 = 995) LABREL=105.
EXECUTE.
/* Het gaat hier om beroepencoderingen in OCC1950 die onmiskenbaar een bepaalde labrel vertegenwoordigen:
/* 009: Clergymen [18]
/* 595: Members of the armed services [18]
/* 820: Farm laborers, wage workers [14]
/* 830: Farm laborers, unpaid family workers [12b]
/* 840: Farm service workers, self-employed [12a]
/* 
/* En de 'non-occupational responses' 1850-1930:
/* 980: Keeps house/housekeeping at home/housewife [5]
/* 981: Inputed keeping house (1850-1900) [5]
/* 982: Helping at home/helps parents/housework [5]
/* 983: At school/student [1]
/* 984: Retired [1]
/* 985: Unemployed/without occupation [3]
/* 986: Invalid/disabled with no occupation reported [1]
/* *987: Inmate [8]
/* 990: New Worker [3]
/* *991: Gentleman/lady/at leisure [2]
/* 995: Other non-occupational response [105].

IF  (MISSING(LABREL)  & EMPSTATD = 00 & YEAR = 1910 & CLASSWKRD = 11) LABREL=13. 
EXECUTE. 
IF  (MISSING(LABREL)  & EMPSTATD = 00 & YEAR = 1910 & CLASSWKRD = 12) LABREL=121. 
EXECUTE. 
IF  (MISSING(LABREL)  & EMPSTATD = 00) LABREL=1. 
EXECUTE. 
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 
    14 | EMPSTATD = 15) | ((MISSING(EMPSTATD) & YEAR = 1920) & ( CLASSWKRD = 10 | CLASSWKRD = 14 )))) LABREL=121013. 
EXECUTE. 
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 
    14 | EMPSTATD = 15) | ((MISSING(EMPSTATD) & YEAR = 1920) & ( CLASSWKRD = 11 )))) LABREL=13. 
EXECUTE. 
/* Ben niet zeker of CLASSWKRD=14 (="Self-employed, incorporated"; waarbij incorporated betekent of het bedrijf is geregistreerd bij de belastingdienst) als employer kan worden gerekend. 
/* Hippler 2009 hierover: "Since 1967, the offcial estimates of self-employment published by the Bureau of Labor Statistics (BLS, the Bureau) have included only the unincorporated self-employed. 
/* Although it is possible to identify the incorporated self-employed separately, these individuals are counted as wage and salary workers in the official statistics because, 
/* from a legal standpoint, they are employees of their own businesses.". 
/* Nu dus 12a013, niet iedereen zal employer geweest zijn: veel om belasting redenen. Hele reeks self-employed en employer nog eens goed nakijken. 
/* IPUMS meldt: "Employers can be distinguished from other self-employed persons "working on own account" in 1910, 1920, 1930, and 1940, but this distinction cannot be made in later years.
/* The 1970-2000 censuses, the ACS and the PRCS distinguish between employers and other self-employed persons whose businesses/farms were incorporated and those whose businesses/farms were not". 

IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15) | ((MISSING(EMPSTATD) & YEAR = 1920) & ( CLASSWKRD = 12 | CLASSWKRD = 13 )))) LABREL=121. 
EXECUTE.  
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15)  | ((MISSING(EMPSTATD) & YEAR = 1920) & ( CLASSWKRD = 29 )))) LABREL=122. 
EXECUTE.  
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15)  | ((MISSING(EMPSTATD) &  YEAR = 1920) & ( CLASSWKRD = 20 | CLASSWKRD = 21 ) & OCC1950 = 830))) LABREL=122. 
EXECUTE.  
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15)  | ((MISSING(EMPSTATD) &  YEAR = 1920) & ( CLASSWKRD = 20 | CLASSWKRD = 21 )))) LABREL=14018. 
EXECUTE.  
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15)  | ((MISSING(EMPSTATD) &  YEAR = 1920) &  CLASSWKRD = 22 ))) LABREL=14. 
EXECUTE.  
IF  (MISSING(LABREL) & ((EMPSTATD=10 | EMPSTATD=11 | EMPSTATD=12 | EMPSTATD=13 | EMPSTATD=14 | EMPSTATD=15) | ((MISSING(EMPSTATD) &  YEAR=1920) & ( CLASSWKRD=23 | CLASSWKRD=24 | CLASSWKRD=25 | CLASSWKRD=26 | CLASSWKRD=27 | CLASSWKRD=28 )))) LABREL=18.
EXECUTE. 
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & YEAR = 1850 & LABFORCE = 0)) LABREL=-1. 
EXECUTE.  
/* Het probleem is dat de 1850 census alleen mensen "in the labour force" noemt, als zij man en 16+ zijn. Dat betekent dat alle vrouwen als "niet-werkend" worden opgevat. 
/* In vergelijking met 1860 zal ongeveer 18% van deze groep (944,614) een labrel tussen 12a en 18 moeten hebben; de rest is 105 (al kun je je ook daar van afvragen of het niet gaat om een onderrepresentatie van vrouwenarbeid).
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & YEAR ~= 1850 & LABFORCE = 0)) LABREL=-1. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & LABFORCE = 1)) LABREL=105. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ( OCC1950 = 995 | OCC1950 = 997 ))) LABREL=-1. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ( OCC1950 = 983 | OCC1950 = 984 | OCC1950 = 985 | OCC1950 = 
    986 ))) LABREL=1. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ( OCC1950 = 980 | OCC1950 = 981 | OCC1950 = 982 ))) LABREL=5. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ( OCC1950 = 987 ))) LABREL=8. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ( OCC1950 = 830 ))) LABREL=122. 
EXECUTE.  
/* Je kunt je afvragen of we niet beter gewoon alle OCC1950=830 als LABREL=122 kunnen coderen, al is dat al gebeurd via CLASSWKR als die juist is gecodeerd in IPUMS. 
/* Dat blijkt echter niet het geval, OCC1950=830 heeft allerlei uiteenlopende CLASSWKR coderingen (zie ook aantal andere beroepen). Moeten die niet voorrang krijgen in dit stroomschema, dus voordat de labrels via CLASSWKR worden verdeeld?.
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & ( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2)) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 ) & ( OCC1950 = 1 | OCC1950 = 5 | OCC1950 = 6 | OCC1950 = 8 | 
    OCC1950 = 31 | OCC1950 = 32 | OCC1950 = 34 | OCC1950 = 35 | OCC1950 = 51 | OCC1950 = 52 | OCC1950 = 
    57 | OCC1950 = 71 | OCC1950 = 73 | OCC1950 = 74 | OCC1950 = 98 | OCC1950 = 100 | OCC1950 = 430 | 
    OCC1950 = 470 | OCC1950 = 582 | OCC1950 = 752 | OCC1950 = 840 )) LABREL=121. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & ( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2)) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 ) & ( OCC1950 = 0 | OCC1950 = 2 | OCC1950 = 7 | OCC1950 = 10 | 
    OCC1950 = 36 | OCC1950 = 41 | OCC1950 = 42 | OCC1950 = 44 | OCC1950 = 45 | OCC1950 = 46 | OCC1950 = 
    47 | OCC1950 = 48 | OCC1950 = 49 | OCC1950 = 58 | OCC1950 = 59 | OCC1950 = 94 | OCC1950 = 95 | 
    OCC1950 = 96 | OCC1950 = 97 | OCC1950 = 200 | OCC1950 = 201 | OCC1950 = 203 | OCC1950 = 204 | 
    OCC1950 = 205 | OCC1950 = 240 | OCC1950 = 280 | OCC1950 = 300 | OCC1950 = 302 | OCC1950 = 304 | 
    OCC1950 = 305 | OCC1950 = 310 | OCC1950 = 320 | OCC1950 = 321 | OCC1950 = 322 | OCC1950 = 340 | 
    OCC1950 = 341 | OCC1950 = 342 | OCC1950 = 350 | OCC1950 = 360 | OCC1950 = 365 | OCC1950 = 370 | 
    OCC1950 = 380 | OCC1950 = 390 | OCC1950 = 400 | OCC1950 = 420 | OCC1950 = 460 | OCC1950 = 480 | 
    OCC1950 = 490 | OCC1950 = 500 | OCC1950 = 502 | OCC1950 = 503 | OCC1950 = 504 | OCC1950 = 505 | 
    OCC1950 = 510 | OCC1950 = 511 | OCC1950 = 512 | OCC1950 = 513 | OCC1950 = 514 | OCC1950 = 515 | 
    OCC1950 = 520 | OCC1950 = 521 | OCC1950 = 522 | OCC1950 = 523 | OCC1950 = 524 | OCC1950 = 525 | 
    OCC1950 = 531 | OCC1950 = 532 | OCC1950 = 533 | OCC1950 = 534 | OCC1950 = 535 | OCC1950 = 540 | 
    OCC1950 = 541 | OCC1950 = 542 | OCC1950 = 543 | OCC1950 = 544 | OCC1950 = 545 | OCC1950 = 550 | 
    OCC1950 = 551 | OCC1950 = 552 | OCC1950 = 553 | OCC1950 = 554 | OCC1950 = 555 | OCC1950 = 560 | 
    OCC1950 = 561 | OCC1950 = 562 | OCC1950 = 563 | OCC1950 = 564 | OCC1950 = 565 | OCC1950 = 570 | 
    OCC1950 = 571 | OCC1950 = 573 | OCC1950 = 574 | OCC1950 = 575 | OCC1950 = 580 | OCC1950 = 581 | 
    OCC1950 = 583 | OCC1950 = 584 | OCC1950 = 585 | OCC1950 = 592 | OCC1950 = 593 | OCC1950 = 594 | 
    OCC1950 = 600 | OCC1950 = 601 | OCC1950 = 602 | OCC1950 = 603 | OCC1950 = 604 | OCC1950 = 605 | 
    OCC1950 = 610 | OCC1950 = 611 | OCC1950 = 612 | OCC1950 = 613 | OCC1950 = 614 | OCC1950 = 615 | 
    OCC1950 = 620 | OCC1950 = 621 | OCC1950 = 622 | OCC1950 = 623 | OCC1950 = 624 | OCC1950 = 625 | 
    OCC1950 = 631 | OCC1950 = 632 | OCC1950 = 633 | OCC1950 = 634 | OCC1950 = 635 | OCC1950 = 640 | 
    OCC1950 = 641 | OCC1950 = 642 | OCC1950 = 643 | OCC1950 = 644 | OCC1950 = 650 | OCC1950 = 660 | 
    OCC1950 = 661 | OCC1950 = 662 | OCC1950 = 670 | OCC1950 = 671 | OCC1950 = 672 | OCC1950 = 673 | 
    OCC1950 = 674 | OCC1950 = 675 | OCC1950 = 680 | OCC1950 = 681 | OCC1950 = 682 | OCC1950 = 683 | 
    OCC1950 = 684 | OCC1950 = 685 | OCC1950 = 690 | OCC1950 = 700 | OCC1950 = 720 | OCC1950 = 750 | 
    OCC1950 = 753 | OCC1950 = 754 | OCC1950 = 760 | OCC1950 = 761 | OCC1950 = 764 | OCC1950 = 780 | 
    OCC1950 = 781 | OCC1950 = 783 | OCC1950 = 784 | OCC1950 = 785 | OCC1950 = 790 | OCC1950 = 810 | 
    OCC1950 = 820 | OCC1950 = 920 | OCC1950 = 930 | OCC1950 = 940 | OCC1950 = 950 | OCC1950 = 960 )) 
    LABREL=14. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & ( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2)) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 ) & ( OCC1950 = 9 | OCC1950 = 12 | OCC1950 = 13 | OCC1950 = 14 | 
    OCC1950 = 15 | OCC1950 = 16 | OCC1950 = 17 | OCC1950 = 18 | OCC1950 = 19 | OCC1950 = 23 | OCC1950 = 
    24 | OCC1950 = 25 | OCC1950 = 26 | OCC1950 = 27 | OCC1950 = 28 | OCC1950 = 29 | OCC1950 = 33 | 
    OCC1950 = 55 | OCC1950 = 56 | OCC1950 = 61 | OCC1950 = 62 | OCC1950 = 63 | OCC1950 = 67 | OCC1950 = 
    68 | OCC1950 = 69 | OCC1950 = 77 | OCC1950 = 78 | OCC1950 = 79 | OCC1950 = 81 | OCC1950 = 82 | 
    OCC1950 = 84 | OCC1950 = 93 | OCC1950 = 210 | OCC1950 = 250 | OCC1950 = 260 | OCC1950 = 270 | 
    OCC1950 = 301 | OCC1950 = 325 | OCC1950 = 335 | OCC1950 = 595 | OCC1950 = 762 | OCC1950 = 771 | 
    OCC1950 = 773 | OCC1950 = 782 )) LABREL=18. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & ( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2)) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 ) & OCC1950 = 999) LABREL=105. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & ( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2)) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 ) & ( OCC1950 = 3 | OCC1950 = 4 | OCC1950 = 54 | OCC1950 = 70 | 
    OCC1950 = 123 | OCC1950 = 230 | OCC1950 = 410 | OCC1950 = 450 | OCC1950 = 501 | OCC1950 = 530 | 
    OCC1950 = 572 | OCC1950 = 590 | OCC1950 = 591 | OCC1950 = 645 | OCC1950 = 710 | OCC1950 = 740 | 
    OCC1950 = 751 | OCC1950 = 772 | OCC1950 = 910 )) LABREL=121014. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & ( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2)) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 ) & ( OCC1950 = 43 | OCC1950 = 53 | OCC1950 = 72 | OCC1950 = 76 | 
    OCC1950 = 83 | OCC1950 = 91 | OCC1950 = 92 | OCC1950 = 99 | OCC1950 = 630 | OCC1950 = 730 | OCC1950 
    = 731 | OCC1950 = 732 | OCC1950 = 763 | OCC1950 = 770 | OCC1950 = 970 )) LABREL=14018. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & ( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2)) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 ) & OCC1950 = 290) LABREL=121013014. 
EXECUTE.  
IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & ( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2)) | ( (EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 ) & OCC1950 = 75) LABREL=121014018. 
EXECUTE.
*/ Running the syntax on 17/11/2015 took 63 minutes on a OS X El Capitan: MacBook Pro 11,2 / Intel Core i7 / 2.8 GHz quadcore / 16GB memory.
