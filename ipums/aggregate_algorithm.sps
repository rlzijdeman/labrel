* Encoding: UTF-8.
GET FILE='/Users/RombertSt/Desktop/IPUMS/USA IPUMS 1850-2010.sav'.
/* Pas locatie (+ eventueel naam) aan van bestand.
WEIGHT BY PERWT.
NUMERIC LABREL (f16).
EXECUTE.

VARIABLE LABELS LABREL "Labour relations, taxonomy v.2015".
VALUE LABELS LABREL
-2 "-2: Not classifiable (age under 16)" 
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
121014 "12a or 14: Self-employed leading producer or Wage earners for the market"
13014 "13 or 14: Employer or Wage earners for the market"
13018 "13 or 18: Employer or Wage earners for non-market institutions"
14018 "14 or 18: Wage earners for the market or Wage earners for non-market institutions"
121013014 "12a or 13 or 14: Self-employed leading producer or Employer or Wage earners for the market"
121014018 "12a or 14 or 18: Self-employed leading producer or Wage earners for the market or WE for non-market institutions"
121013014018 "12a or 13 or 14 or 18: Self-employed leading producer or Employer or Wage earners (market/non-market)".
EXECUTE.

IF  (MISSING(LABREL)  & AGE <= 15) LABREL=-2. 
EXECUTE. 
/* Dit vernietigt direct alle kans om kinderarbeid er uit te halen, maar zorgt wel voor een consistente vergelijking over 
/* tijd. Ongeveer 1-3% van alle individuen van 16jr (sic, oude berekening) en jonger uit het VS bestand is wel degelijk 
/* werkzaam volgens de census. Vaak gaat het dan om 14, 15jarigen. Meestal zijn mensen jonger dan dat niet ondervraagd.

/* UPDATE 17/11/2015: Een betere manier is om dit weg te laten (we vergelijken immers individuen, en de consistente vergelijking 
/* is vooral nuttig bij geaggregeerde data). Mochten we toch geaggregeerde data willen, is het super makkelijk om achteraf 
/* alles af te toppen, ipv vooraf.

/* UPDATE 6/7/2016: Nieuwe voorstel is om alle leeftijden onder 16 als -2 te classificeren, zodat onderscheid met "Unknown" scherp is.

IF  (MISSING(LABREL) & OCC1950 = 987) LABREL=8. 
IF  (MISSING(LABREL) & (OCC1950 = 980 | OCC1950 = 981 | OCC1950 = 982)) LABREL=5.
IF  (MISSING(LABREL) & (OCC1950 = 983 | OCC1950 = 984 | OCC1950 = 986)) LABREL=1.
IF  (MISSING(LABREL) & (OCC1950 = 985 | OCC1950 = 990)) LABREL=3.
IF  (MISSING(LABREL) & OCC1950 = 995) LABREL=105.
IF  (MISSING(LABREL) & OCC1950 = 991) LABREL=2. 
EXECUTE.
/* Allereerst enkele 'non-occupational responses' 1850-1930, omdat deze anders of bij labrel 1, 105 of 3 terecht komen:
/* 980: Keeps house/housekeeping at home/housewife [5]
/* 981: Inputed keeping house (1850-1900) [5]
/* 982: Helping at home/helps parents/housework [5]
/* 983: At school/student [1]
/* 984: Retired [1]
/* 985: Unemployed/without occupation [3]
/* 986: Invalid/disabled with no occupation reported [1]
/* 987: Inmate [8]
/* 990: New Worker [3]
/* 991: Gentleman/lady/at leisure [2]
/* 995: Other non-occupational response [105]
/* UPDATE 10/1/2018: deels verplaatst van hieronder. 

IF  (MISSING(LABREL)  & (EMPSTATD = 32 | EMPSTATD = 33)) LABREL=1. 
IF  (MISSING(LABREL)  & EMPSTATD = 34) LABREL=105. 
/* "Not in labour force, other" > restant na aftrek 'Housework', 'School', 'Unable'. Dus o.a. "people who simply choose not 
/* to work or to look for work"? Maar afgaand van enkele voorbeelden lijkt affluent (2) toch niet helemaal juist: dus LR 105.
IF  (MISSING(LABREL)  & (EMPSTATD = 20 | EMPSTATD = 21 | EMPSTATD = 22)) LABREL=3. 
IF  (MISSING(LABREL)  & EMPSTATD = 31) LABREL=5. 
IF  (MISSING(LABREL)  & EMPSTATD = 30) LABREL=105. 
EXECUTE.
/* Dit omvat ook alle gepensioneerden. Moeten we een cutoff point bij bepaalde leeftijd maken?.

/* Volgende set beroepen hier nu ingevoegd, om te voorkomen dat deze beroepen worden verdeeld over alles en nog wat.
IF  (MISSING(LABREL) & (OCC1950 = 9 | OCC1950 = 595)) LABREL=18.
IF  (MISSING(LABREL) & OCC1950 = 820) LABREL=14.
IF  (MISSING(LABREL) & OCC1950 = 830) LABREL=122.
IF  (MISSING(LABREL) & OCC1950 = 840) LABREL=121.
EXECUTE.
/* Het gaat hier om beroepencoderingen in OCC1950 die onmiskenbaar een bepaalde labrel vertegenwoordigen:
/* 009: Clergymen [18]
/* 595: Members of the armed services [18]
/* 820: Farm laborers, wage workers [14]
/* 830: Farm laborers, unpaid family workers [12b]
/* 840: Farm service workers, self-employed [12a].

IF  (MISSING(LABREL)  & EMPSTATD = 00 & YEAR = 1910 & CLASSWKRD = 11) LABREL=13. 
IF  (MISSING(LABREL)  & EMPSTATD = 00 & YEAR = 1910 & CLASSWKRD = 12) LABREL=121. 
IF  (MISSING(LABREL)  & EMPSTATD = 00) LABREL=1.  
EXECUTE. 
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15) | 
    (MISSING(EMPSTATD) & YEAR = 1920)) & ( CLASSWKRD = 10 | CLASSWKRD = 14 )) LABREL=121013. 
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15) | 
    (MISSING(EMPSTATD) & YEAR = 1920)) & CLASSWKRD = 11 ) LABREL=13. 

/* Ben niet zeker of CLASSWKRD=14 (="Self-employed, incorporated"; waarbij incorporated betekent of het bedrijf is 
/* geregistreerd bij de belastingdienst) als employer kan worden gerekend. 
/* Hippler 2009 hierover: "Since 1967, the offcial estimates of self-employment published by the Bureau of Labor Statistics 
/* (BLS, the Bureau) have included only the unincorporated self-employed. Although it is possible to identify the 
/* incorporated self-employed separately, these individuals are counted as wage and salary workers in the official statistics
/* because, from a legal standpoint, they are employees of their own businesses." 
/* Nu dus 12a013, niet iedereen zal employer geweest zijn: veel om belasting redenen. Hele reeks self-employed en employer 
/* nog eens goed nakijken. 
/* IPUMS meldt: "Employers can be distinguished from other self-employed persons "working on own account" in 1910, 1920, 
/* 1930, and 1940, but this distinction cannot be made in later years. The 1970-2000 censuses, the ACS and the PRCS 
/* distinguish between employers and other self-employed persons whose businesses/farms were incorporated and those whose 
/* businesses/farms were not". 

IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15) | 
    (MISSING(EMPSTATD) & YEAR = 1920)) & ( CLASSWKRD = 12 | CLASSWKRD = 13 )) LABREL=121. 
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15) | 
    (MISSING(EMPSTATD) & YEAR = 1920)) & CLASSWKRD = 29 ) LABREL=122. 
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15) | 
    (MISSING(EMPSTATD) & YEAR = 1920)) & ( CLASSWKRD = 20 | CLASSWKRD = 21 )) LABREL=14018.  
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15) | 
    (MISSING(EMPSTATD) & YEAR = 1920)) & CLASSWKRD = 22 ) LABREL=14. 
IF  (MISSING(LABREL)  & ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | EMPSTATD = 15) | 
    (MISSING(EMPSTATD) & YEAR = 1920)) & ( CLASSWKRD = 23 | CLASSWKRD = 24 | CLASSWKRD = 25 | CLASSWKRD = 26 | CLASSWKRD = 27 | 
    CLASSWKRD = 28 )) LABREL=18.
EXECUTE. 

IF  (MISSING(LABREL) & (MISSING(EMPSTATD) & YEAR = 1850 & LABFORCE = 0)) LABREL=-1.  
/* Het probleem is dat de 1850 census alleen mensen "in the labour force" noemt, als zij man en 16+ zijn. Dat betekent dat 
/* alle vrouwen en kinderen als "niet-werkend" worden opgevat. 
/* In vergelijking met 1860 zal ongeveer 18% van deze groep (944,614) een labrel tussen 12a en 18 moeten hebben; de rest is 
/* 105 (al kun je je ook daar van afvragen of het niet gaat om een onderrepresentatie van vrouwenarbeid).
IF  (MISSING(LABREL) & MISSING(EMPSTATD) & YEAR ~= 1850 & LABFORCE = 0) LABREL=-1. 
EXECUTE.  

IF  (MISSING(LABREL) & MISSING(EMPSTATD) & LABFORCE = 1) LABREL=105. 
EXECUTE.  
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ( OCC1950 = 997 | OCC1950 = 999 )) LABREL=-1. 
/* This rule applies to all years from 1850-1900, so we have not distinguished them.
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 47) | 
(YEAR = 1850 & OCC1950 = 52) | 
(YEAR = 1850 & OCC1950 = 73) | 
(YEAR = 1850 & OCC1950 = 100) | 
(YEAR = 1850 & OCC1950 = 123) | 
(YEAR = 1850 & OCC1950 = 290) | 
(YEAR = 1850 & OCC1950 = 555) | 
(YEAR = 1850 & OCC1950 = 644) | 
(YEAR = 1850 & OCC1950 = 810) | 
(YEAR = 1860 & OCC1950 = 47) | 
(YEAR = 1860 & OCC1950 = 52) | 
(YEAR = 1860 & OCC1950 = 73) | 
(YEAR = 1860 & OCC1950 = 100) | 
(YEAR = 1860 & OCC1950 = 123) | 
(YEAR = 1860 & OCC1950 = 290) | 
(YEAR = 1860 & OCC1950 = 555) | 
(YEAR = 1860 & OCC1950 = 644) | 
(YEAR = 1860 & OCC1950 = 810) | 
(YEAR = 1870 & OCC1950 = 47) | 
(YEAR = 1870 & OCC1950 = 73) | 
(YEAR = 1870 & OCC1950 = 100) | 
(YEAR = 1870 & OCC1950 = 123) | 
(YEAR = 1870 & OCC1950 = 290) | 
(YEAR = 1870 & OCC1950 = 644) | 
(YEAR = 1880 & OCC1950 = 100) | 
(YEAR = 1880 & OCC1950 = 123) | 
(YEAR = 1880 & OCC1950 = 290))) LABREL=13. 
EXECUTE.  
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 0) | 
(YEAR = 1850 & OCC1950 = 1) | 
(YEAR = 1850 & OCC1950 = 5) | 
(YEAR = 1850 & OCC1950 = 7) | 
(YEAR = 1850 & OCC1950 = 10) | 
(YEAR = 1850 & OCC1950 = 12) | 
(YEAR = 1850 & OCC1950 = 13) | 
(YEAR = 1850 & OCC1950 = 14) | 
(YEAR = 1850 & OCC1950 = 18) | 
(YEAR = 1850 & OCC1950 = 23) | 
(YEAR = 1850 & OCC1950 = 27) | 
(YEAR = 1850 & OCC1950 = 33) | 
(YEAR = 1850 & OCC1950 = 34) | 
(YEAR = 1850 & OCC1950 = 35) | 
(YEAR = 1850 & OCC1950 = 42) | 
(YEAR = 1850 & OCC1950 = 44) | 
(YEAR = 1850 & OCC1950 = 45) | 
(YEAR = 1850 & OCC1950 = 46) | 
(YEAR = 1850 & OCC1950 = 51) | 
(YEAR = 1850 & OCC1950 = 53) | 
(YEAR = 1850 & OCC1950 = 59) | 
(YEAR = 1850 & OCC1950 = 61) | 
(YEAR = 1850 & OCC1950 = 63) | 
(YEAR = 1850 & OCC1950 = 68) | 
(YEAR = 1850 & OCC1950 = 72) | 
(YEAR = 1850 & OCC1950 = 77) | 
(YEAR = 1850 & OCC1950 = 81) | 
(YEAR = 1850 & OCC1950 = 83) | 
(YEAR = 1850 & OCC1950 = 84) | 
(YEAR = 1850 & OCC1950 = 94) | 
(YEAR = 1850 & OCC1950 = 95) | 
(YEAR = 1850 & OCC1950 = 200) | 
(YEAR = 1850 & OCC1950 = 203) | 
(YEAR = 1850 & OCC1950 = 204) | 
(YEAR = 1850 & OCC1950 = 205) | 
(YEAR = 1850 & OCC1950 = 240) | 
(YEAR = 1850 & OCC1950 = 260) | 
(YEAR = 1850 & OCC1950 = 280) | 
(YEAR = 1850 & OCC1950 = 300) | 
(YEAR = 1850 & OCC1950 = 302) | 
(YEAR = 1850 & OCC1950 = 304) | 
(YEAR = 1850 & OCC1950 = 305) | 
(YEAR = 1850 & OCC1950 = 310) | 
(YEAR = 1850 & OCC1950 = 320) | 
(YEAR = 1850 & OCC1950 = 321) | 
(YEAR = 1850 & OCC1950 = 322) | 
(YEAR = 1850 & OCC1950 = 340) | 
(YEAR = 1850 & OCC1950 = 341) | 
(YEAR = 1850 & OCC1950 = 342) | 
(YEAR = 1850 & OCC1950 = 350) | 
(YEAR = 1850 & OCC1950 = 360) | 
(YEAR = 1850 & OCC1950 = 365) | 
(YEAR = 1850 & OCC1950 = 370) | 
(YEAR = 1850 & OCC1950 = 380) | 
(YEAR = 1850 & OCC1950 = 390) | 
(YEAR = 1850 & OCC1950 = 400) | 
(YEAR = 1850 & OCC1950 = 420) | 
(YEAR = 1850 & OCC1950 = 450) | 
(YEAR = 1850 & OCC1950 = 490) | 
(YEAR = 1850 & OCC1950 = 500) | 
(YEAR = 1850 & OCC1950 = 502) | 
(YEAR = 1850 & OCC1950 = 503) | 
(YEAR = 1850 & OCC1950 = 504) | 
(YEAR = 1850 & OCC1950 = 505) | 
(YEAR = 1850 & OCC1950 = 510) | 
(YEAR = 1850 & OCC1950 = 511) | 
(YEAR = 1850 & OCC1950 = 512) | 
(YEAR = 1850 & OCC1950 = 513) | 
(YEAR = 1850 & OCC1950 = 514) | 
(YEAR = 1850 & OCC1950 = 515) | 
(YEAR = 1850 & OCC1950 = 520) | 
(YEAR = 1850 & OCC1950 = 521) | 
(YEAR = 1850 & OCC1950 = 522) | 
(YEAR = 1850 & OCC1950 = 523) | 
(YEAR = 1850 & OCC1950 = 524) | 
(YEAR = 1850 & OCC1950 = 525) | 
(YEAR = 1850 & OCC1950 = 531) | 
(YEAR = 1850 & OCC1950 = 532) | 
(YEAR = 1850 & OCC1950 = 533) | 
(YEAR = 1850 & OCC1950 = 534) | 
(YEAR = 1850 & OCC1950 = 535) | 
(YEAR = 1850 & OCC1950 = 540) | 
(YEAR = 1850 & OCC1950 = 541) | 
(YEAR = 1850 & OCC1950 = 542) | 
(YEAR = 1850 & OCC1950 = 543) | 
(YEAR = 1850 & OCC1950 = 544) | 
(YEAR = 1850 & OCC1950 = 545) | 
(YEAR = 1850 & OCC1950 = 550) | 
(YEAR = 1850 & OCC1950 = 551) | 
(YEAR = 1850 & OCC1950 = 552) | 
(YEAR = 1850 & OCC1950 = 553) | 
(YEAR = 1850 & OCC1950 = 560) | 
(YEAR = 1850 & OCC1950 = 561) | 
(YEAR = 1850 & OCC1950 = 562) | 
(YEAR = 1850 & OCC1950 = 564) | 
(YEAR = 1850 & OCC1950 = 565) | 
(YEAR = 1850 & OCC1950 = 570) | 
(YEAR = 1850 & OCC1950 = 571) | 
(YEAR = 1850 & OCC1950 = 572) | 
(YEAR = 1850 & OCC1950 = 573) | 
(YEAR = 1850 & OCC1950 = 574) | 
(YEAR = 1850 & OCC1950 = 575) | 
(YEAR = 1850 & OCC1950 = 580) | 
(YEAR = 1850 & OCC1950 = 581) | 
(YEAR = 1850 & OCC1950 = 583) | 
(YEAR = 1850 & OCC1950 = 584) | 
(YEAR = 1850 & OCC1950 = 585) | 
(YEAR = 1850 & OCC1950 = 590) | 
(YEAR = 1850 & OCC1950 = 592) | 
(YEAR = 1850 & OCC1950 = 593) | 
(YEAR = 1850 & OCC1950 = 600) | 
(YEAR = 1850 & OCC1950 = 601) | 
(YEAR = 1850 & OCC1950 = 602) | 
(YEAR = 1850 & OCC1950 = 603) | 
(YEAR = 1850 & OCC1950 = 604) | 
(YEAR = 1850 & OCC1950 = 605) | 
(YEAR = 1850 & OCC1950 = 610) | 
(YEAR = 1850 & OCC1950 = 611) | 
(YEAR = 1850 & OCC1950 = 612) | 
(YEAR = 1850 & OCC1950 = 613) | 
(YEAR = 1850 & OCC1950 = 614) | 
(YEAR = 1850 & OCC1950 = 615) | 
(YEAR = 1850 & OCC1950 = 620) | 
(YEAR = 1850 & OCC1950 = 621) | 
(YEAR = 1850 & OCC1950 = 622) | 
(YEAR = 1850 & OCC1950 = 623) | 
(YEAR = 1850 & OCC1950 = 624) | 
(YEAR = 1850 & OCC1950 = 631) | 
(YEAR = 1850 & OCC1950 = 632) | 
(YEAR = 1850 & OCC1950 = 634) | 
(YEAR = 1850 & OCC1950 = 635) | 
(YEAR = 1850 & OCC1950 = 640) | 
(YEAR = 1850 & OCC1950 = 641) | 
(YEAR = 1850 & OCC1950 = 642) | 
(YEAR = 1850 & OCC1950 = 643) | 
(YEAR = 1850 & OCC1950 = 650) | 
(YEAR = 1850 & OCC1950 = 660) | 
(YEAR = 1850 & OCC1950 = 661) | 
(YEAR = 1850 & OCC1950 = 662) | 
(YEAR = 1850 & OCC1950 = 670) | 
(YEAR = 1850 & OCC1950 = 671) | 
(YEAR = 1850 & OCC1950 = 673) | 
(YEAR = 1850 & OCC1950 = 674) | 
(YEAR = 1850 & OCC1950 = 675) | 
(YEAR = 1850 & OCC1950 = 680) | 
(YEAR = 1850 & OCC1950 = 681) | 
(YEAR = 1850 & OCC1950 = 682) | 
(YEAR = 1850 & OCC1950 = 683) | 
(YEAR = 1850 & OCC1950 = 684) | 
(YEAR = 1850 & OCC1950 = 685) | 
(YEAR = 1850 & OCC1950 = 690) | 
(YEAR = 1850 & OCC1950 = 700) | 
(YEAR = 1850 & OCC1950 = 720) | 
(YEAR = 1850 & OCC1950 = 732) | 
(YEAR = 1850 & OCC1950 = 750) | 
(YEAR = 1850 & OCC1950 = 753) | 
(YEAR = 1850 & OCC1950 = 754) | 
(YEAR = 1850 & OCC1950 = 760) | 
(YEAR = 1850 & OCC1950 = 761) | 
(YEAR = 1850 & OCC1950 = 763) | 
(YEAR = 1850 & OCC1950 = 764) | 
(YEAR = 1850 & OCC1950 = 770) | 
(YEAR = 1850 & OCC1950 = 780) | 
(YEAR = 1850 & OCC1950 = 783) | 
(YEAR = 1850 & OCC1950 = 784) | 
(YEAR = 1850 & OCC1950 = 785) | 
(YEAR = 1850 & OCC1950 = 790) | 
(YEAR = 1850 & OCC1950 = 820) | 
(YEAR = 1850 & OCC1950 = 920) | 
(YEAR = 1850 & OCC1950 = 930) | 
(YEAR = 1850 & OCC1950 = 940) | 
(YEAR = 1850 & OCC1950 = 950) | 
(YEAR = 1850 & OCC1950 = 960) | 
(YEAR = 1860 & OCC1950 = 0) | 
(YEAR = 1860 & OCC1950 = 1) | 
(YEAR = 1860 & OCC1950 = 5) | 
(YEAR = 1860 & OCC1950 = 7) | 
(YEAR = 1860 & OCC1950 = 10) | 
(YEAR = 1860 & OCC1950 = 12) | 
(YEAR = 1860 & OCC1950 = 13) | 
(YEAR = 1860 & OCC1950 = 14) | 
(YEAR = 1860 & OCC1950 = 18) | 
(YEAR = 1860 & OCC1950 = 23) | 
(YEAR = 1860 & OCC1950 = 27) | 
(YEAR = 1860 & OCC1950 = 33) | 
(YEAR = 1860 & OCC1950 = 34) | 
(YEAR = 1860 & OCC1950 = 35) | 
(YEAR = 1860 & OCC1950 = 42) | 
(YEAR = 1860 & OCC1950 = 44) | 
(YEAR = 1860 & OCC1950 = 45) | 
(YEAR = 1860 & OCC1950 = 46) | 
(YEAR = 1860 & OCC1950 = 51) | 
(YEAR = 1860 & OCC1950 = 53) | 
(YEAR = 1860 & OCC1950 = 59) | 
(YEAR = 1860 & OCC1950 = 61) | 
(YEAR = 1860 & OCC1950 = 63) | 
(YEAR = 1860 & OCC1950 = 68) | 
(YEAR = 1860 & OCC1950 = 72) | 
(YEAR = 1860 & OCC1950 = 77) | 
(YEAR = 1860 & OCC1950 = 81) | 
(YEAR = 1860 & OCC1950 = 83) | 
(YEAR = 1860 & OCC1950 = 84) | 
(YEAR = 1860 & OCC1950 = 94) | 
(YEAR = 1860 & OCC1950 = 95) | 
(YEAR = 1860 & OCC1950 = 200) | 
(YEAR = 1860 & OCC1950 = 203) | 
(YEAR = 1860 & OCC1950 = 204) | 
(YEAR = 1860 & OCC1950 = 205) | 
(YEAR = 1860 & OCC1950 = 240) | 
(YEAR = 1860 & OCC1950 = 260) | 
(YEAR = 1860 & OCC1950 = 280) | 
(YEAR = 1860 & OCC1950 = 300) | 
(YEAR = 1860 & OCC1950 = 302) | 
(YEAR = 1860 & OCC1950 = 304) | 
(YEAR = 1860 & OCC1950 = 305) | 
(YEAR = 1860 & OCC1950 = 310) | 
(YEAR = 1860 & OCC1950 = 320) | 
(YEAR = 1860 & OCC1950 = 321) | 
(YEAR = 1860 & OCC1950 = 322) | 
(YEAR = 1860 & OCC1950 = 340) | 
(YEAR = 1860 & OCC1950 = 341) | 
(YEAR = 1860 & OCC1950 = 342) | 
(YEAR = 1860 & OCC1950 = 350) | 
(YEAR = 1860 & OCC1950 = 360) | 
(YEAR = 1860 & OCC1950 = 365) | 
(YEAR = 1860 & OCC1950 = 370) | 
(YEAR = 1860 & OCC1950 = 380) | 
(YEAR = 1860 & OCC1950 = 390) | 
(YEAR = 1860 & OCC1950 = 400) | 
(YEAR = 1860 & OCC1950 = 420) | 
(YEAR = 1860 & OCC1950 = 450) | 
(YEAR = 1860 & OCC1950 = 490) | 
(YEAR = 1860 & OCC1950 = 500) | 
(YEAR = 1860 & OCC1950 = 502) | 
(YEAR = 1860 & OCC1950 = 503) | 
(YEAR = 1860 & OCC1950 = 504) | 
(YEAR = 1860 & OCC1950 = 505) | 
(YEAR = 1860 & OCC1950 = 510) | 
(YEAR = 1860 & OCC1950 = 511) | 
(YEAR = 1860 & OCC1950 = 512) | 
(YEAR = 1860 & OCC1950 = 513) | 
(YEAR = 1860 & OCC1950 = 514) | 
(YEAR = 1860 & OCC1950 = 515) | 
(YEAR = 1860 & OCC1950 = 520) | 
(YEAR = 1860 & OCC1950 = 521) | 
(YEAR = 1860 & OCC1950 = 522) | 
(YEAR = 1860 & OCC1950 = 523) | 
(YEAR = 1860 & OCC1950 = 524) | 
(YEAR = 1860 & OCC1950 = 525) | 
(YEAR = 1860 & OCC1950 = 531) | 
(YEAR = 1860 & OCC1950 = 532) | 
(YEAR = 1860 & OCC1950 = 533) | 
(YEAR = 1860 & OCC1950 = 534) | 
(YEAR = 1860 & OCC1950 = 535) | 
(YEAR = 1860 & OCC1950 = 540) | 
(YEAR = 1860 & OCC1950 = 541) | 
(YEAR = 1860 & OCC1950 = 542) | 
(YEAR = 1860 & OCC1950 = 543) | 
(YEAR = 1860 & OCC1950 = 544) | 
(YEAR = 1860 & OCC1950 = 545) | 
(YEAR = 1860 & OCC1950 = 550) | 
(YEAR = 1860 & OCC1950 = 551) | 
(YEAR = 1860 & OCC1950 = 552) | 
(YEAR = 1860 & OCC1950 = 553) | 
(YEAR = 1860 & OCC1950 = 554) | 
(YEAR = 1860 & OCC1950 = 560) | 
(YEAR = 1860 & OCC1950 = 561) | 
(YEAR = 1860 & OCC1950 = 562) | 
(YEAR = 1860 & OCC1950 = 564) | 
(YEAR = 1860 & OCC1950 = 565) | 
(YEAR = 1860 & OCC1950 = 570) | 
(YEAR = 1860 & OCC1950 = 571) | 
(YEAR = 1860 & OCC1950 = 572) | 
(YEAR = 1860 & OCC1950 = 573) | 
(YEAR = 1860 & OCC1950 = 574) | 
(YEAR = 1860 & OCC1950 = 575) | 
(YEAR = 1860 & OCC1950 = 580) | 
(YEAR = 1860 & OCC1950 = 581) | 
(YEAR = 1860 & OCC1950 = 583) | 
(YEAR = 1860 & OCC1950 = 584) | 
(YEAR = 1860 & OCC1950 = 585) | 
(YEAR = 1860 & OCC1950 = 590) | 
(YEAR = 1860 & OCC1950 = 591) | 
(YEAR = 1860 & OCC1950 = 592) | 
(YEAR = 1860 & OCC1950 = 593) | 
(YEAR = 1860 & OCC1950 = 600) | 
(YEAR = 1860 & OCC1950 = 601) | 
(YEAR = 1860 & OCC1950 = 602) | 
(YEAR = 1860 & OCC1950 = 603) | 
(YEAR = 1860 & OCC1950 = 604) | 
(YEAR = 1860 & OCC1950 = 605) | 
(YEAR = 1860 & OCC1950 = 610) | 
(YEAR = 1860 & OCC1950 = 611) | 
(YEAR = 1860 & OCC1950 = 612) | 
(YEAR = 1860 & OCC1950 = 613) | 
(YEAR = 1860 & OCC1950 = 614) | 
(YEAR = 1860 & OCC1950 = 615) | 
(YEAR = 1860 & OCC1950 = 620) | 
(YEAR = 1860 & OCC1950 = 621) | 
(YEAR = 1860 & OCC1950 = 622) | 
(YEAR = 1860 & OCC1950 = 623) | 
(YEAR = 1860 & OCC1950 = 624) | 
(YEAR = 1860 & OCC1950 = 631) | 
(YEAR = 1860 & OCC1950 = 632) | 
(YEAR = 1860 & OCC1950 = 634) | 
(YEAR = 1860 & OCC1950 = 635) | 
(YEAR = 1860 & OCC1950 = 640) | 
(YEAR = 1860 & OCC1950 = 641) | 
(YEAR = 1860 & OCC1950 = 642) | 
(YEAR = 1860 & OCC1950 = 643) | 
(YEAR = 1860 & OCC1950 = 650) | 
(YEAR = 1860 & OCC1950 = 660) | 
(YEAR = 1860 & OCC1950 = 661) | 
(YEAR = 1860 & OCC1950 = 662) | 
(YEAR = 1860 & OCC1950 = 670) | 
(YEAR = 1860 & OCC1950 = 671) | 
(YEAR = 1860 & OCC1950 = 673) | 
(YEAR = 1860 & OCC1950 = 674) | 
(YEAR = 1860 & OCC1950 = 675) | 
(YEAR = 1860 & OCC1950 = 680) | 
(YEAR = 1860 & OCC1950 = 681) | 
(YEAR = 1860 & OCC1950 = 682) | 
(YEAR = 1860 & OCC1950 = 683) | 
(YEAR = 1860 & OCC1950 = 684) | 
(YEAR = 1860 & OCC1950 = 685) | 
(YEAR = 1860 & OCC1950 = 690) | 
(YEAR = 1860 & OCC1950 = 700) | 
(YEAR = 1860 & OCC1950 = 720) | 
(YEAR = 1860 & OCC1950 = 732) | 
(YEAR = 1860 & OCC1950 = 750) | 
(YEAR = 1860 & OCC1950 = 753) | 
(YEAR = 1860 & OCC1950 = 754) | 
(YEAR = 1860 & OCC1950 = 760) | 
(YEAR = 1860 & OCC1950 = 761) | 
(YEAR = 1860 & OCC1950 = 763) | 
(YEAR = 1860 & OCC1950 = 764) | 
(YEAR = 1860 & OCC1950 = 770) | 
(YEAR = 1860 & OCC1950 = 780) | 
(YEAR = 1860 & OCC1950 = 783) | 
(YEAR = 1860 & OCC1950 = 784) | 
(YEAR = 1860 & OCC1950 = 785) | 
(YEAR = 1860 & OCC1950 = 790) | 
(YEAR = 1860 & OCC1950 = 820) | 
(YEAR = 1860 & OCC1950 = 920) | 
(YEAR = 1860 & OCC1950 = 930) | 
(YEAR = 1860 & OCC1950 = 940) | 
(YEAR = 1860 & OCC1950 = 950) | 
(YEAR = 1860 & OCC1950 = 960) | 
(YEAR = 1870 & OCC1950 = 0) | 
(YEAR = 1870 & OCC1950 = 1) | 
(YEAR = 1870 & OCC1950 = 5) | 
(YEAR = 1870 & OCC1950 = 7) | 
(YEAR = 1870 & OCC1950 = 10) | 
(YEAR = 1870 & OCC1950 = 12) | 
(YEAR = 1870 & OCC1950 = 13) | 
(YEAR = 1870 & OCC1950 = 14) | 
(YEAR = 1870 & OCC1950 = 18) | 
(YEAR = 1870 & OCC1950 = 23) | 
(YEAR = 1870 & OCC1950 = 27) | 
(YEAR = 1870 & OCC1950 = 33) | 
(YEAR = 1870 & OCC1950 = 34) | 
(YEAR = 1870 & OCC1950 = 35) | 
(YEAR = 1870 & OCC1950 = 42) | 
(YEAR = 1870 & OCC1950 = 44) | 
(YEAR = 1870 & OCC1950 = 45) | 
(YEAR = 1870 & OCC1950 = 46) | 
(YEAR = 1870 & OCC1950 = 51) | 
(YEAR = 1870 & OCC1950 = 53) | 
(YEAR = 1870 & OCC1950 = 58) | 
(YEAR = 1870 & OCC1950 = 59) | 
(YEAR = 1870 & OCC1950 = 61) | 
(YEAR = 1870 & OCC1950 = 63) | 
(YEAR = 1870 & OCC1950 = 68) | 
(YEAR = 1870 & OCC1950 = 72) | 
(YEAR = 1870 & OCC1950 = 77) | 
(YEAR = 1870 & OCC1950 = 78) | 
(YEAR = 1870 & OCC1950 = 81) | 
(YEAR = 1870 & OCC1950 = 83) | 
(YEAR = 1870 & OCC1950 = 84) | 
(YEAR = 1870 & OCC1950 = 94) | 
(YEAR = 1870 & OCC1950 = 95) | 
(YEAR = 1870 & OCC1950 = 200) | 
(YEAR = 1870 & OCC1950 = 203) | 
(YEAR = 1870 & OCC1950 = 204) | 
(YEAR = 1870 & OCC1950 = 205) | 
(YEAR = 1870 & OCC1950 = 240) | 
(YEAR = 1870 & OCC1950 = 260) | 
(YEAR = 1870 & OCC1950 = 280) | 
(YEAR = 1870 & OCC1950 = 300) | 
(YEAR = 1870 & OCC1950 = 302) | 
(YEAR = 1870 & OCC1950 = 304) | 
(YEAR = 1870 & OCC1950 = 305) | 
(YEAR = 1870 & OCC1950 = 310) | 
(YEAR = 1870 & OCC1950 = 320) | 
(YEAR = 1870 & OCC1950 = 321) | 
(YEAR = 1870 & OCC1950 = 322) | 
(YEAR = 1870 & OCC1950 = 340) | 
(YEAR = 1870 & OCC1950 = 341) | 
(YEAR = 1870 & OCC1950 = 342) | 
(YEAR = 1870 & OCC1950 = 350) | 
(YEAR = 1870 & OCC1950 = 360) | 
(YEAR = 1870 & OCC1950 = 365) | 
(YEAR = 1870 & OCC1950 = 370) | 
(YEAR = 1870 & OCC1950 = 380) | 
(YEAR = 1870 & OCC1950 = 390) | 
(YEAR = 1870 & OCC1950 = 400) | 
(YEAR = 1870 & OCC1950 = 420) | 
(YEAR = 1870 & OCC1950 = 450) | 
(YEAR = 1870 & OCC1950 = 480) | 
(YEAR = 1870 & OCC1950 = 490) | 
(YEAR = 1870 & OCC1950 = 500) | 
(YEAR = 1870 & OCC1950 = 502) | 
(YEAR = 1870 & OCC1950 = 503) | 
(YEAR = 1870 & OCC1950 = 504) | 
(YEAR = 1870 & OCC1950 = 505) | 
(YEAR = 1870 & OCC1950 = 510) | 
(YEAR = 1870 & OCC1950 = 511) | 
(YEAR = 1870 & OCC1950 = 512) | 
(YEAR = 1870 & OCC1950 = 513) | 
(YEAR = 1870 & OCC1950 = 514) | 
(YEAR = 1870 & OCC1950 = 515) | 
(YEAR = 1870 & OCC1950 = 520) | 
(YEAR = 1870 & OCC1950 = 521) | 
(YEAR = 1870 & OCC1950 = 522) | 
(YEAR = 1870 & OCC1950 = 523) | 
(YEAR = 1870 & OCC1950 = 524) | 
(YEAR = 1870 & OCC1950 = 525) | 
(YEAR = 1870 & OCC1950 = 531) | 
(YEAR = 1870 & OCC1950 = 532) | 
(YEAR = 1870 & OCC1950 = 533) | 
(YEAR = 1870 & OCC1950 = 534) | 
(YEAR = 1870 & OCC1950 = 535) | 
(YEAR = 1870 & OCC1950 = 540) | 
(YEAR = 1870 & OCC1950 = 541) | 
(YEAR = 1870 & OCC1950 = 542) | 
(YEAR = 1870 & OCC1950 = 543) | 
(YEAR = 1870 & OCC1950 = 544) | 
(YEAR = 1870 & OCC1950 = 545) | 
(YEAR = 1870 & OCC1950 = 550) | 
(YEAR = 1870 & OCC1950 = 551) | 
(YEAR = 1870 & OCC1950 = 552) | 
(YEAR = 1870 & OCC1950 = 553) | 
(YEAR = 1870 & OCC1950 = 554) | 
(YEAR = 1870 & OCC1950 = 560) | 
(YEAR = 1870 & OCC1950 = 561) | 
(YEAR = 1870 & OCC1950 = 562) | 
(YEAR = 1870 & OCC1950 = 564) | 
(YEAR = 1870 & OCC1950 = 565) | 
(YEAR = 1870 & OCC1950 = 570) | 
(YEAR = 1870 & OCC1950 = 571) | 
(YEAR = 1870 & OCC1950 = 572) | 
(YEAR = 1870 & OCC1950 = 573) | 
(YEAR = 1870 & OCC1950 = 574) | 
(YEAR = 1870 & OCC1950 = 575) | 
(YEAR = 1870 & OCC1950 = 580) | 
(YEAR = 1870 & OCC1950 = 581) | 
(YEAR = 1870 & OCC1950 = 583) | 
(YEAR = 1870 & OCC1950 = 584) | 
(YEAR = 1870 & OCC1950 = 585) | 
(YEAR = 1870 & OCC1950 = 590) | 
(YEAR = 1870 & OCC1950 = 591) | 
(YEAR = 1870 & OCC1950 = 592) | 
(YEAR = 1870 & OCC1950 = 593) | 
(YEAR = 1870 & OCC1950 = 600) | 
(YEAR = 1870 & OCC1950 = 601) | 
(YEAR = 1870 & OCC1950 = 602) | 
(YEAR = 1870 & OCC1950 = 603) | 
(YEAR = 1870 & OCC1950 = 604) | 
(YEAR = 1870 & OCC1950 = 605) | 
(YEAR = 1870 & OCC1950 = 610) | 
(YEAR = 1870 & OCC1950 = 611) | 
(YEAR = 1870 & OCC1950 = 612) | 
(YEAR = 1870 & OCC1950 = 613) | 
(YEAR = 1870 & OCC1950 = 614) | 
(YEAR = 1870 & OCC1950 = 615) | 
(YEAR = 1870 & OCC1950 = 620) | 
(YEAR = 1870 & OCC1950 = 621) | 
(YEAR = 1870 & OCC1950 = 622) | 
(YEAR = 1870 & OCC1950 = 623) | 
(YEAR = 1870 & OCC1950 = 624) | 
(YEAR = 1870 & OCC1950 = 631) | 
(YEAR = 1870 & OCC1950 = 632) | 
(YEAR = 1870 & OCC1950 = 634) | 
(YEAR = 1870 & OCC1950 = 635) | 
(YEAR = 1870 & OCC1950 = 640) | 
(YEAR = 1870 & OCC1950 = 641) | 
(YEAR = 1870 & OCC1950 = 642) | 
(YEAR = 1870 & OCC1950 = 643) | 
(YEAR = 1870 & OCC1950 = 650) | 
(YEAR = 1870 & OCC1950 = 660) | 
(YEAR = 1870 & OCC1950 = 661) | 
(YEAR = 1870 & OCC1950 = 662) | 
(YEAR = 1870 & OCC1950 = 670) | 
(YEAR = 1870 & OCC1950 = 671) | 
(YEAR = 1870 & OCC1950 = 672) | 
(YEAR = 1870 & OCC1950 = 673) | 
(YEAR = 1870 & OCC1950 = 674) | 
(YEAR = 1870 & OCC1950 = 675) | 
(YEAR = 1870 & OCC1950 = 680) | 
(YEAR = 1870 & OCC1950 = 681) | 
(YEAR = 1870 & OCC1950 = 682) | 
(YEAR = 1870 & OCC1950 = 683) | 
(YEAR = 1870 & OCC1950 = 684) | 
(YEAR = 1870 & OCC1950 = 685) | 
(YEAR = 1870 & OCC1950 = 690) | 
(YEAR = 1870 & OCC1950 = 700) | 
(YEAR = 1870 & OCC1950 = 720) | 
(YEAR = 1870 & OCC1950 = 732) | 
(YEAR = 1870 & OCC1950 = 750) | 
(YEAR = 1870 & OCC1950 = 753) | 
(YEAR = 1870 & OCC1950 = 754) | 
(YEAR = 1870 & OCC1950 = 760) | 
(YEAR = 1870 & OCC1950 = 761) | 
(YEAR = 1870 & OCC1950 = 763) | 
(YEAR = 1870 & OCC1950 = 764) | 
(YEAR = 1870 & OCC1950 = 770) | 
(YEAR = 1870 & OCC1950 = 780) | 
(YEAR = 1870 & OCC1950 = 783) | 
(YEAR = 1870 & OCC1950 = 784) | 
(YEAR = 1870 & OCC1950 = 785) | 
(YEAR = 1870 & OCC1950 = 790) | 
(YEAR = 1870 & OCC1950 = 820) | 
(YEAR = 1870 & OCC1950 = 920) | 
(YEAR = 1870 & OCC1950 = 930) | 
(YEAR = 1870 & OCC1950 = 940) | 
(YEAR = 1870 & OCC1950 = 950) | 
(YEAR = 1870 & OCC1950 = 960) | 
(YEAR = 1880 & OCC1950 = 0) | 
(YEAR = 1880 & OCC1950 = 1) | 
(YEAR = 1880 & OCC1950 = 5) | 
(YEAR = 1880 & OCC1950 = 7) | 
(YEAR = 1880 & OCC1950 = 10) | 
(YEAR = 1880 & OCC1950 = 12) | 
(YEAR = 1880 & OCC1950 = 13) | 
(YEAR = 1880 & OCC1950 = 14) | 
(YEAR = 1880 & OCC1950 = 18) | 
(YEAR = 1880 & OCC1950 = 23) | 
(YEAR = 1880 & OCC1950 = 27) | 
(YEAR = 1880 & OCC1950 = 33) | 
(YEAR = 1880 & OCC1950 = 34) | 
(YEAR = 1880 & OCC1950 = 35) | 
(YEAR = 1880 & OCC1950 = 42) | 
(YEAR = 1880 & OCC1950 = 44) | 
(YEAR = 1880 & OCC1950 = 45) | 
(YEAR = 1880 & OCC1950 = 46) | 
(YEAR = 1880 & OCC1950 = 51) | 
(YEAR = 1880 & OCC1950 = 53) | 
(YEAR = 1880 & OCC1950 = 58) | 
(YEAR = 1880 & OCC1950 = 59) | 
(YEAR = 1880 & OCC1950 = 61) | 
(YEAR = 1880 & OCC1950 = 63) | 
(YEAR = 1880 & OCC1950 = 68) | 
(YEAR = 1880 & OCC1950 = 72) | 
(YEAR = 1880 & OCC1950 = 77) | 
(YEAR = 1880 & OCC1950 = 78) | 
(YEAR = 1880 & OCC1950 = 81) | 
(YEAR = 1880 & OCC1950 = 83) | 
(YEAR = 1880 & OCC1950 = 84) | 
(YEAR = 1880 & OCC1950 = 94) | 
(YEAR = 1880 & OCC1950 = 95) | 
(YEAR = 1880 & OCC1950 = 200) | 
(YEAR = 1880 & OCC1950 = 203) | 
(YEAR = 1880 & OCC1950 = 204) | 
(YEAR = 1880 & OCC1950 = 205) | 
(YEAR = 1880 & OCC1950 = 240) | 
(YEAR = 1880 & OCC1950 = 260) | 
(YEAR = 1880 & OCC1950 = 280) | 
(YEAR = 1880 & OCC1950 = 300) | 
(YEAR = 1880 & OCC1950 = 302) | 
(YEAR = 1880 & OCC1950 = 304) | 
(YEAR = 1880 & OCC1950 = 305) | 
(YEAR = 1880 & OCC1950 = 310) | 
(YEAR = 1880 & OCC1950 = 320) | 
(YEAR = 1880 & OCC1950 = 321) | 
(YEAR = 1880 & OCC1950 = 322) | 
(YEAR = 1880 & OCC1950 = 340) | 
(YEAR = 1880 & OCC1950 = 341) | 
(YEAR = 1880 & OCC1950 = 342) | 
(YEAR = 1880 & OCC1950 = 350) | 
(YEAR = 1880 & OCC1950 = 360) | 
(YEAR = 1880 & OCC1950 = 365) | 
(YEAR = 1880 & OCC1950 = 370) | 
(YEAR = 1880 & OCC1950 = 380) | 
(YEAR = 1880 & OCC1950 = 390) | 
(YEAR = 1880 & OCC1950 = 400) | 
(YEAR = 1880 & OCC1950 = 420) | 
(YEAR = 1880 & OCC1950 = 450) | 
(YEAR = 1880 & OCC1950 = 480) | 
(YEAR = 1880 & OCC1950 = 490) | 
(YEAR = 1880 & OCC1950 = 500) | 
(YEAR = 1880 & OCC1950 = 502) | 
(YEAR = 1880 & OCC1950 = 503) | 
(YEAR = 1880 & OCC1950 = 504) | 
(YEAR = 1880 & OCC1950 = 505) | 
(YEAR = 1880 & OCC1950 = 510) | 
(YEAR = 1880 & OCC1950 = 511) | 
(YEAR = 1880 & OCC1950 = 512) | 
(YEAR = 1880 & OCC1950 = 513) | 
(YEAR = 1880 & OCC1950 = 514) | 
(YEAR = 1880 & OCC1950 = 515) | 
(YEAR = 1880 & OCC1950 = 520) | 
(YEAR = 1880 & OCC1950 = 521) | 
(YEAR = 1880 & OCC1950 = 522) | 
(YEAR = 1880 & OCC1950 = 523) | 
(YEAR = 1880 & OCC1950 = 524) | 
(YEAR = 1880 & OCC1950 = 525) | 
(YEAR = 1880 & OCC1950 = 531) | 
(YEAR = 1880 & OCC1950 = 532) | 
(YEAR = 1880 & OCC1950 = 533) | 
(YEAR = 1880 & OCC1950 = 534) | 
(YEAR = 1880 & OCC1950 = 535) | 
(YEAR = 1880 & OCC1950 = 540) | 
(YEAR = 1880 & OCC1950 = 541) | 
(YEAR = 1880 & OCC1950 = 542) | 
(YEAR = 1880 & OCC1950 = 543) | 
(YEAR = 1880 & OCC1950 = 544) | 
(YEAR = 1880 & OCC1950 = 545) | 
(YEAR = 1880 & OCC1950 = 550) | 
(YEAR = 1880 & OCC1950 = 551) | 
(YEAR = 1880 & OCC1950 = 552) | 
(YEAR = 1880 & OCC1950 = 553) | 
(YEAR = 1880 & OCC1950 = 554) | 
(YEAR = 1880 & OCC1950 = 560) | 
(YEAR = 1880 & OCC1950 = 561) | 
(YEAR = 1880 & OCC1950 = 562) | 
(YEAR = 1880 & OCC1950 = 564) | 
(YEAR = 1880 & OCC1950 = 565) | 
(YEAR = 1880 & OCC1950 = 570) | 
(YEAR = 1880 & OCC1950 = 571) | 
(YEAR = 1880 & OCC1950 = 572) | 
(YEAR = 1880 & OCC1950 = 573) | 
(YEAR = 1880 & OCC1950 = 574) | 
(YEAR = 1880 & OCC1950 = 575) | 
(YEAR = 1880 & OCC1950 = 580) | 
(YEAR = 1880 & OCC1950 = 581) | 
(YEAR = 1880 & OCC1950 = 583) | 
(YEAR = 1880 & OCC1950 = 584) | 
(YEAR = 1880 & OCC1950 = 585) | 
(YEAR = 1880 & OCC1950 = 590) | 
(YEAR = 1880 & OCC1950 = 591) | 
(YEAR = 1880 & OCC1950 = 592) | 
(YEAR = 1880 & OCC1950 = 593) | 
(YEAR = 1880 & OCC1950 = 594) | 
(YEAR = 1880 & OCC1950 = 600) | 
(YEAR = 1880 & OCC1950 = 601) | 
(YEAR = 1880 & OCC1950 = 602) | 
(YEAR = 1880 & OCC1950 = 603) | 
(YEAR = 1880 & OCC1950 = 604) | 
(YEAR = 1880 & OCC1950 = 605) | 
(YEAR = 1880 & OCC1950 = 610) | 
(YEAR = 1880 & OCC1950 = 611) | 
(YEAR = 1880 & OCC1950 = 612) | 
(YEAR = 1880 & OCC1950 = 613) | 
(YEAR = 1880 & OCC1950 = 614) | 
(YEAR = 1880 & OCC1950 = 615) | 
(YEAR = 1880 & OCC1950 = 620) | 
(YEAR = 1880 & OCC1950 = 621) | 
(YEAR = 1880 & OCC1950 = 622) | 
(YEAR = 1880 & OCC1950 = 623) | 
(YEAR = 1880 & OCC1950 = 624) | 
(YEAR = 1880 & OCC1950 = 631) | 
(YEAR = 1880 & OCC1950 = 632) | 
(YEAR = 1880 & OCC1950 = 634) | 
(YEAR = 1880 & OCC1950 = 635) | 
(YEAR = 1880 & OCC1950 = 640) | 
(YEAR = 1880 & OCC1950 = 641) | 
(YEAR = 1880 & OCC1950 = 642) | 
(YEAR = 1880 & OCC1950 = 643) | 
(YEAR = 1880 & OCC1950 = 650) | 
(YEAR = 1880 & OCC1950 = 660) | 
(YEAR = 1880 & OCC1950 = 661) | 
(YEAR = 1880 & OCC1950 = 662) | 
(YEAR = 1880 & OCC1950 = 670) | 
(YEAR = 1880 & OCC1950 = 671) | 
(YEAR = 1880 & OCC1950 = 672) | 
(YEAR = 1880 & OCC1950 = 673) | 
(YEAR = 1880 & OCC1950 = 674) | 
(YEAR = 1880 & OCC1950 = 675) | 
(YEAR = 1880 & OCC1950 = 680) | 
(YEAR = 1880 & OCC1950 = 681) | 
(YEAR = 1880 & OCC1950 = 682) | 
(YEAR = 1880 & OCC1950 = 683) | 
(YEAR = 1880 & OCC1950 = 684) | 
(YEAR = 1880 & OCC1950 = 685) | 
(YEAR = 1880 & OCC1950 = 690) | 
(YEAR = 1880 & OCC1950 = 700) | 
(YEAR = 1880 & OCC1950 = 720) | 
(YEAR = 1880 & OCC1950 = 732) | 
(YEAR = 1880 & OCC1950 = 750) | 
(YEAR = 1880 & OCC1950 = 753) | 
(YEAR = 1880 & OCC1950 = 754) | 
(YEAR = 1880 & OCC1950 = 760) | 
(YEAR = 1880 & OCC1950 = 761) | 
(YEAR = 1880 & OCC1950 = 763) | 
(YEAR = 1880 & OCC1950 = 764) | 
(YEAR = 1880 & OCC1950 = 770) | 
(YEAR = 1880 & OCC1950 = 780) | 
(YEAR = 1880 & OCC1950 = 781) | 
(YEAR = 1880 & OCC1950 = 783) | 
(YEAR = 1880 & OCC1950 = 784) | 
(YEAR = 1880 & OCC1950 = 785) | 
(YEAR = 1880 & OCC1950 = 790) | 
(YEAR = 1880 & OCC1950 = 820) | 
(YEAR = 1880 & OCC1950 = 920) | 
(YEAR = 1880 & OCC1950 = 930) | 
(YEAR = 1880 & OCC1950 = 940) | 
(YEAR = 1880 & OCC1950 = 950) | 
(YEAR = 1880 & OCC1950 = 960) | 
(YEAR = 1900 & OCC1950 = 0) | 
(YEAR = 1900 & OCC1950 = 1) | 
(YEAR = 1900 & OCC1950 = 5) | 
(YEAR = 1900 & OCC1950 = 7) | 
(YEAR = 1900 & OCC1950 = 10) | 
(YEAR = 1900 & OCC1950 = 12) | 
(YEAR = 1900 & OCC1950 = 13) | 
(YEAR = 1900 & OCC1950 = 14) | 
(YEAR = 1900 & OCC1950 = 16) | 
(YEAR = 1900 & OCC1950 = 18) | 
(YEAR = 1900 & OCC1950 = 23) | 
(YEAR = 1900 & OCC1950 = 27) | 
(YEAR = 1900 & OCC1950 = 33) | 
(YEAR = 1900 & OCC1950 = 34) | 
(YEAR = 1900 & OCC1950 = 35) | 
(YEAR = 1900 & OCC1950 = 36) | 
(YEAR = 1900 & OCC1950 = 42) | 
(YEAR = 1900 & OCC1950 = 44) | 
(YEAR = 1900 & OCC1950 = 45) | 
(YEAR = 1900 & OCC1950 = 46) | 
(YEAR = 1900 & OCC1950 = 48) | 
(YEAR = 1900 & OCC1950 = 51) | 
(YEAR = 1900 & OCC1950 = 53) | 
(YEAR = 1900 & OCC1950 = 58) | 
(YEAR = 1900 & OCC1950 = 59) | 
(YEAR = 1900 & OCC1950 = 61) | 
(YEAR = 1900 & OCC1950 = 63) | 
(YEAR = 1900 & OCC1950 = 68) | 
(YEAR = 1900 & OCC1950 = 72) | 
(YEAR = 1900 & OCC1950 = 77) | 
(YEAR = 1900 & OCC1950 = 78) | 
(YEAR = 1900 & OCC1950 = 81) | 
(YEAR = 1900 & OCC1950 = 83) | 
(YEAR = 1900 & OCC1950 = 84) | 
(YEAR = 1900 & OCC1950 = 94) | 
(YEAR = 1900 & OCC1950 = 95) | 
(YEAR = 1900 & OCC1950 = 200) | 
(YEAR = 1900 & OCC1950 = 203) | 
(YEAR = 1900 & OCC1950 = 204) | 
(YEAR = 1900 & OCC1950 = 205) | 
(YEAR = 1900 & OCC1950 = 240) | 
(YEAR = 1900 & OCC1950 = 260) | 
(YEAR = 1900 & OCC1950 = 280) | 
(YEAR = 1900 & OCC1950 = 300) | 
(YEAR = 1900 & OCC1950 = 302) | 
(YEAR = 1900 & OCC1950 = 304) | 
(YEAR = 1900 & OCC1950 = 305) | 
(YEAR = 1900 & OCC1950 = 310) | 
(YEAR = 1900 & OCC1950 = 320) | 
(YEAR = 1900 & OCC1950 = 321) | 
(YEAR = 1900 & OCC1950 = 322) | 
(YEAR = 1900 & OCC1950 = 340) | 
(YEAR = 1900 & OCC1950 = 341) | 
(YEAR = 1900 & OCC1950 = 342) | 
(YEAR = 1900 & OCC1950 = 350) | 
(YEAR = 1900 & OCC1950 = 360) | 
(YEAR = 1900 & OCC1950 = 365) | 
(YEAR = 1900 & OCC1950 = 370) | 
(YEAR = 1900 & OCC1950 = 380) | 
(YEAR = 1900 & OCC1950 = 390) | 
(YEAR = 1900 & OCC1950 = 400) | 
(YEAR = 1900 & OCC1950 = 420) | 
(YEAR = 1900 & OCC1950 = 450) | 
(YEAR = 1900 & OCC1950 = 480) | 
(YEAR = 1900 & OCC1950 = 490) | 
(YEAR = 1900 & OCC1950 = 500) | 
(YEAR = 1900 & OCC1950 = 502) | 
(YEAR = 1900 & OCC1950 = 503) | 
(YEAR = 1900 & OCC1950 = 504) | 
(YEAR = 1900 & OCC1950 = 505) | 
(YEAR = 1900 & OCC1950 = 510) | 
(YEAR = 1900 & OCC1950 = 511) | 
(YEAR = 1900 & OCC1950 = 512) | 
(YEAR = 1900 & OCC1950 = 513) | 
(YEAR = 1900 & OCC1950 = 514) | 
(YEAR = 1900 & OCC1950 = 515) | 
(YEAR = 1900 & OCC1950 = 520) | 
(YEAR = 1900 & OCC1950 = 521) | 
(YEAR = 1900 & OCC1950 = 522) | 
(YEAR = 1900 & OCC1950 = 523) | 
(YEAR = 1900 & OCC1950 = 524) | 
(YEAR = 1900 & OCC1950 = 525) | 
(YEAR = 1900 & OCC1950 = 530) | 
(YEAR = 1900 & OCC1950 = 531) | 
(YEAR = 1900 & OCC1950 = 532) | 
(YEAR = 1900 & OCC1950 = 533) | 
(YEAR = 1900 & OCC1950 = 534) | 
(YEAR = 1900 & OCC1950 = 535) | 
(YEAR = 1900 & OCC1950 = 540) | 
(YEAR = 1900 & OCC1950 = 541) | 
(YEAR = 1900 & OCC1950 = 542) | 
(YEAR = 1900 & OCC1950 = 543) | 
(YEAR = 1900 & OCC1950 = 544) | 
(YEAR = 1900 & OCC1950 = 545) | 
(YEAR = 1900 & OCC1950 = 550) | 
(YEAR = 1900 & OCC1950 = 551) | 
(YEAR = 1900 & OCC1950 = 552) | 
(YEAR = 1900 & OCC1950 = 553) | 
(YEAR = 1900 & OCC1950 = 554) | 
(YEAR = 1900 & OCC1950 = 560) | 
(YEAR = 1900 & OCC1950 = 561) | 
(YEAR = 1900 & OCC1950 = 562) | 
(YEAR = 1900 & OCC1950 = 564) | 
(YEAR = 1900 & OCC1950 = 570) | 
(YEAR = 1900 & OCC1950 = 571) | 
(YEAR = 1900 & OCC1950 = 572) | 
(YEAR = 1900 & OCC1950 = 573) | 
(YEAR = 1900 & OCC1950 = 574) | 
(YEAR = 1900 & OCC1950 = 575) | 
(YEAR = 1900 & OCC1950 = 580) | 
(YEAR = 1900 & OCC1950 = 581) | 
(YEAR = 1900 & OCC1950 = 583) | 
(YEAR = 1900 & OCC1950 = 584) | 
(YEAR = 1900 & OCC1950 = 585) | 
(YEAR = 1900 & OCC1950 = 590) | 
(YEAR = 1900 & OCC1950 = 591) | 
(YEAR = 1900 & OCC1950 = 592) | 
(YEAR = 1900 & OCC1950 = 593) | 
(YEAR = 1900 & OCC1950 = 594) | 
(YEAR = 1900 & OCC1950 = 600) | 
(YEAR = 1900 & OCC1950 = 601) | 
(YEAR = 1900 & OCC1950 = 602) | 
(YEAR = 1900 & OCC1950 = 603) | 
(YEAR = 1900 & OCC1950 = 604) | 
(YEAR = 1900 & OCC1950 = 605) | 
(YEAR = 1900 & OCC1950 = 610) | 
(YEAR = 1900 & OCC1950 = 611) | 
(YEAR = 1900 & OCC1950 = 612) | 
(YEAR = 1900 & OCC1950 = 613) | 
(YEAR = 1900 & OCC1950 = 614) | 
(YEAR = 1900 & OCC1950 = 615) | 
(YEAR = 1900 & OCC1950 = 620) | 
(YEAR = 1900 & OCC1950 = 621) | 
(YEAR = 1900 & OCC1950 = 622) | 
(YEAR = 1900 & OCC1950 = 623) | 
(YEAR = 1900 & OCC1950 = 624) | 
(YEAR = 1900 & OCC1950 = 625) | 
(YEAR = 1900 & OCC1950 = 631) | 
(YEAR = 1900 & OCC1950 = 632) | 
(YEAR = 1900 & OCC1950 = 634) | 
(YEAR = 1900 & OCC1950 = 635) | 
(YEAR = 1900 & OCC1950 = 640) | 
(YEAR = 1900 & OCC1950 = 641) | 
(YEAR = 1900 & OCC1950 = 642) | 
(YEAR = 1900 & OCC1950 = 643) | 
(YEAR = 1900 & OCC1950 = 645) | 
(YEAR = 1900 & OCC1950 = 650) | 
(YEAR = 1900 & OCC1950 = 660) | 
(YEAR = 1900 & OCC1950 = 661) | 
(YEAR = 1900 & OCC1950 = 662) | 
(YEAR = 1900 & OCC1950 = 670) | 
(YEAR = 1900 & OCC1950 = 671) | 
(YEAR = 1900 & OCC1950 = 672) | 
(YEAR = 1900 & OCC1950 = 673) | 
(YEAR = 1900 & OCC1950 = 674) | 
(YEAR = 1900 & OCC1950 = 675) | 
(YEAR = 1900 & OCC1950 = 680) | 
(YEAR = 1900 & OCC1950 = 681) | 
(YEAR = 1900 & OCC1950 = 682) | 
(YEAR = 1900 & OCC1950 = 683) | 
(YEAR = 1900 & OCC1950 = 684) | 
(YEAR = 1900 & OCC1950 = 685) | 
(YEAR = 1900 & OCC1950 = 690) | 
(YEAR = 1900 & OCC1950 = 700) | 
(YEAR = 1900 & OCC1950 = 720) | 
(YEAR = 1900 & OCC1950 = 732) | 
(YEAR = 1900 & OCC1950 = 750) | 
(YEAR = 1900 & OCC1950 = 753) | 
(YEAR = 1900 & OCC1950 = 754) | 
(YEAR = 1900 & OCC1950 = 760) | 
(YEAR = 1900 & OCC1950 = 761) | 
(YEAR = 1900 & OCC1950 = 763) | 
(YEAR = 1900 & OCC1950 = 764) | 
(YEAR = 1900 & OCC1950 = 770) | 
(YEAR = 1900 & OCC1950 = 780) | 
(YEAR = 1900 & OCC1950 = 781) | 
(YEAR = 1900 & OCC1950 = 783) | 
(YEAR = 1900 & OCC1950 = 784) | 
(YEAR = 1900 & OCC1950 = 785) | 
(YEAR = 1900 & OCC1950 = 790) | 
(YEAR = 1900 & OCC1950 = 820) | 
(YEAR = 1900 & OCC1950 = 920) | 
(YEAR = 1900 & OCC1950 = 930) | 
(YEAR = 1900 & OCC1950 = 940) | 
(YEAR = 1900 & OCC1950 = 950) | 
(YEAR = 1900 & OCC1950 = 960))) 
    LABREL=14.  
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 9) | 
(YEAR = 1850 & OCC1950 = 56) | 
(YEAR = 1850 & OCC1950 = 79) | 
(YEAR = 1850 & OCC1950 = 93) | 
(YEAR = 1850 & OCC1950 = 210) | 
(YEAR = 1850 & OCC1950 = 250) | 
(YEAR = 1850 & OCC1950 = 270) | 
(YEAR = 1850 & OCC1950 = 301) | 
(YEAR = 1850 & OCC1950 = 325) | 
(YEAR = 1850 & OCC1950 = 335) | 
(YEAR = 1850 & OCC1950 = 595) | 
(YEAR = 1850 & OCC1950 = 730) | 
(YEAR = 1850 & OCC1950 = 762) | 
(YEAR = 1850 & OCC1950 = 771) | 
(YEAR = 1850 & OCC1950 = 773) | 
(YEAR = 1850 & OCC1950 = 782) | 
(YEAR = 1860 & OCC1950 = 9) | 
(YEAR = 1860 & OCC1950 = 56) | 
(YEAR = 1860 & OCC1950 = 79) | 
(YEAR = 1860 & OCC1950 = 93) | 
(YEAR = 1860 & OCC1950 = 210) | 
(YEAR = 1860 & OCC1950 = 250) | 
(YEAR = 1860 & OCC1950 = 270) | 
(YEAR = 1860 & OCC1950 = 301) | 
(YEAR = 1860 & OCC1950 = 325) | 
(YEAR = 1860 & OCC1950 = 335) | 
(YEAR = 1860 & OCC1950 = 595) | 
(YEAR = 1860 & OCC1950 = 730) | 
(YEAR = 1860 & OCC1950 = 762) | 
(YEAR = 1860 & OCC1950 = 771) | 
(YEAR = 1860 & OCC1950 = 773) | 
(YEAR = 1860 & OCC1950 = 782) | 
(YEAR = 1870 & OCC1950 = 9) | 
(YEAR = 1870 & OCC1950 = 56) | 
(YEAR = 1870 & OCC1950 = 79) | 
(YEAR = 1870 & OCC1950 = 93) | 
(YEAR = 1870 & OCC1950 = 210) | 
(YEAR = 1870 & OCC1950 = 250) | 
(YEAR = 1870 & OCC1950 = 270) | 
(YEAR = 1870 & OCC1950 = 301) | 
(YEAR = 1870 & OCC1950 = 325) | 
(YEAR = 1870 & OCC1950 = 335) | 
(YEAR = 1870 & OCC1950 = 595) | 
(YEAR = 1870 & OCC1950 = 730) | 
(YEAR = 1870 & OCC1950 = 762) | 
(YEAR = 1870 & OCC1950 = 771) | 
(YEAR = 1870 & OCC1950 = 773) | 
(YEAR = 1870 & OCC1950 = 782) | 
(YEAR = 1880 & OCC1950 = 9) | 
(YEAR = 1880 & OCC1950 = 56) | 
(YEAR = 1880 & OCC1950 = 79) | 
(YEAR = 1880 & OCC1950 = 93) | 
(YEAR = 1880 & OCC1950 = 210) | 
(YEAR = 1880 & OCC1950 = 250) | 
(YEAR = 1880 & OCC1950 = 270) | 
(YEAR = 1880 & OCC1950 = 301) | 
(YEAR = 1880 & OCC1950 = 325) | 
(YEAR = 1880 & OCC1950 = 335) | 
(YEAR = 1880 & OCC1950 = 595) | 
(YEAR = 1880 & OCC1950 = 730) | 
(YEAR = 1880 & OCC1950 = 762) | 
(YEAR = 1880 & OCC1950 = 771) | 
(YEAR = 1880 & OCC1950 = 773) | 
(YEAR = 1880 & OCC1950 = 782) | 
(YEAR = 1900 & OCC1950 = 9) | 
(YEAR = 1900 & OCC1950 = 56) | 
(YEAR = 1900 & OCC1950 = 79) | 
(YEAR = 1900 & OCC1950 = 93) | 
(YEAR = 1900 & OCC1950 = 210) | 
(YEAR = 1900 & OCC1950 = 250) | 
(YEAR = 1900 & OCC1950 = 270) | 
(YEAR = 1900 & OCC1950 = 301) | 
(YEAR = 1900 & OCC1950 = 325) | 
(YEAR = 1900 & OCC1950 = 335) | 
(YEAR = 1900 & OCC1950 = 595) | 
(YEAR = 1900 & OCC1950 = 730) | 
(YEAR = 1900 & OCC1950 = 762) | 
(YEAR = 1900 & OCC1950 = 771) | 
(YEAR = 1900 & OCC1950 = 773) | 
(YEAR = 1900 & OCC1950 = 782))) LABREL=18.   
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 2) | 
(YEAR = 1850 & OCC1950 = 4) | 
(YEAR = 1850 & OCC1950 = 6) | 
(YEAR = 1850 & OCC1950 = 8) | 
(YEAR = 1850 & OCC1950 = 15) | 
(YEAR = 1850 & OCC1950 = 17) | 
(YEAR = 1850 & OCC1950 = 19) | 
(YEAR = 1850 & OCC1950 = 24) | 
(YEAR = 1850 & OCC1950 = 25) | 
(YEAR = 1850 & OCC1950 = 28) | 
(YEAR = 1850 & OCC1950 = 31) | 
(YEAR = 1850 & OCC1950 = 32) | 
(YEAR = 1850 & OCC1950 = 41) | 
(YEAR = 1850 & OCC1950 = 55) | 
(YEAR = 1850 & OCC1950 = 57) | 
(YEAR = 1850 & OCC1950 = 62) | 
(YEAR = 1850 & OCC1950 = 67) | 
(YEAR = 1850 & OCC1950 = 69) | 
(YEAR = 1850 & OCC1950 = 71) | 
(YEAR = 1850 & OCC1950 = 74) | 
(YEAR = 1850 & OCC1950 = 75) | 
(YEAR = 1850 & OCC1950 = 82) | 
(YEAR = 1850 & OCC1950 = 97) | 
(YEAR = 1850 & OCC1950 = 98) | 
(YEAR = 1850 & OCC1950 = 99) | 
(YEAR = 1850 & OCC1950 = 430) | 
(YEAR = 1850 & OCC1950 = 460) | 
(YEAR = 1850 & OCC1950 = 470) | 
(YEAR = 1850 & OCC1950 = 582) | 
(YEAR = 1850 & OCC1950 = 633) | 
(YEAR = 1850 & OCC1950 = 752) | 
(YEAR = 1850 & OCC1950 = 772) | 
(YEAR = 1850 & OCC1950 = 910) | 
(YEAR = 1860 & OCC1950 = 2) | 
(YEAR = 1860 & OCC1950 = 4) | 
(YEAR = 1860 & OCC1950 = 6) | 
(YEAR = 1860 & OCC1950 = 8) | 
(YEAR = 1860 & OCC1950 = 15) | 
(YEAR = 1860 & OCC1950 = 17) | 
(YEAR = 1860 & OCC1950 = 19) | 
(YEAR = 1860 & OCC1950 = 24) | 
(YEAR = 1860 & OCC1950 = 25) | 
(YEAR = 1860 & OCC1950 = 28) | 
(YEAR = 1860 & OCC1950 = 31) | 
(YEAR = 1860 & OCC1950 = 32) | 
(YEAR = 1860 & OCC1950 = 41) | 
(YEAR = 1860 & OCC1950 = 55) | 
(YEAR = 1860 & OCC1950 = 57) | 
(YEAR = 1860 & OCC1950 = 62) | 
(YEAR = 1860 & OCC1950 = 67) | 
(YEAR = 1860 & OCC1950 = 69) | 
(YEAR = 1860 & OCC1950 = 71) | 
(YEAR = 1860 & OCC1950 = 74) | 
(YEAR = 1860 & OCC1950 = 75) | 
(YEAR = 1860 & OCC1950 = 82) | 
(YEAR = 1860 & OCC1950 = 97) | 
(YEAR = 1860 & OCC1950 = 98) | 
(YEAR = 1860 & OCC1950 = 430) | 
(YEAR = 1860 & OCC1950 = 460) | 
(YEAR = 1860 & OCC1950 = 470) | 
(YEAR = 1860 & OCC1950 = 582) | 
(YEAR = 1860 & OCC1950 = 633) | 
(YEAR = 1860 & OCC1950 = 752) | 
(YEAR = 1860 & OCC1950 = 772) | 
(YEAR = 1860 & OCC1950 = 910) | 
(YEAR = 1870 & OCC1950 = 2) | 
(YEAR = 1870 & OCC1950 = 4) | 
(YEAR = 1870 & OCC1950 = 6) | 
(YEAR = 1870 & OCC1950 = 8) | 
(YEAR = 1870 & OCC1950 = 15) | 
(YEAR = 1870 & OCC1950 = 17) | 
(YEAR = 1870 & OCC1950 = 19) | 
(YEAR = 1870 & OCC1950 = 24) | 
(YEAR = 1870 & OCC1950 = 25) | 
(YEAR = 1870 & OCC1950 = 28) | 
(YEAR = 1870 & OCC1950 = 31) | 
(YEAR = 1870 & OCC1950 = 32) | 
(YEAR = 1870 & OCC1950 = 41) | 
(YEAR = 1870 & OCC1950 = 55) | 
(YEAR = 1870 & OCC1950 = 57) | 
(YEAR = 1870 & OCC1950 = 62) | 
(YEAR = 1870 & OCC1950 = 67) | 
(YEAR = 1870 & OCC1950 = 69) | 
(YEAR = 1870 & OCC1950 = 71) | 
(YEAR = 1870 & OCC1950 = 74) | 
(YEAR = 1870 & OCC1950 = 75) | 
(YEAR = 1870 & OCC1950 = 82) | 
(YEAR = 1870 & OCC1950 = 97) | 
(YEAR = 1870 & OCC1950 = 98) | 
(YEAR = 1870 & OCC1950 = 430) | 
(YEAR = 1870 & OCC1950 = 460) | 
(YEAR = 1870 & OCC1950 = 470) | 
(YEAR = 1870 & OCC1950 = 563) | 
(YEAR = 1870 & OCC1950 = 582) | 
(YEAR = 1870 & OCC1950 = 633) | 
(YEAR = 1870 & OCC1950 = 751) | 
(YEAR = 1870 & OCC1950 = 752) | 
(YEAR = 1870 & OCC1950 = 772) | 
(YEAR = 1880 & OCC1950 = 2) | 
(YEAR = 1880 & OCC1950 = 4) | 
(YEAR = 1880 & OCC1950 = 6) | 
(YEAR = 1880 & OCC1950 = 8) | 
(YEAR = 1880 & OCC1950 = 15) | 
(YEAR = 1880 & OCC1950 = 17) | 
(YEAR = 1880 & OCC1950 = 19) | 
(YEAR = 1880 & OCC1950 = 24) | 
(YEAR = 1880 & OCC1950 = 25) | 
(YEAR = 1880 & OCC1950 = 28) | 
(YEAR = 1880 & OCC1950 = 31) | 
(YEAR = 1880 & OCC1950 = 32) | 
(YEAR = 1880 & OCC1950 = 41) | 
(YEAR = 1880 & OCC1950 = 55) | 
(YEAR = 1880 & OCC1950 = 57) | 
(YEAR = 1880 & OCC1950 = 67) | 
(YEAR = 1880 & OCC1950 = 69) | 
(YEAR = 1880 & OCC1950 = 71) | 
(YEAR = 1880 & OCC1950 = 74) | 
(YEAR = 1880 & OCC1950 = 75) | 
(YEAR = 1880 & OCC1950 = 82) | 
(YEAR = 1880 & OCC1950 = 97) | 
(YEAR = 1880 & OCC1950 = 98) | 
(YEAR = 1880 & OCC1950 = 430) | 
(YEAR = 1880 & OCC1950 = 460) | 
(YEAR = 1880 & OCC1950 = 470) | 
(YEAR = 1880 & OCC1950 = 563) | 
(YEAR = 1880 & OCC1950 = 582) | 
(YEAR = 1880 & OCC1950 = 633) | 
(YEAR = 1880 & OCC1950 = 751) | 
(YEAR = 1880 & OCC1950 = 752) | 
(YEAR = 1880 & OCC1950 = 772) | 
(YEAR = 1900 & OCC1950 = 2) | 
(YEAR = 1900 & OCC1950 = 4) | 
(YEAR = 1900 & OCC1950 = 6) | 
(YEAR = 1900 & OCC1950 = 8) | 
(YEAR = 1900 & OCC1950 = 15) | 
(YEAR = 1900 & OCC1950 = 17) | 
(YEAR = 1900 & OCC1950 = 24) | 
(YEAR = 1900 & OCC1950 = 25) | 
(YEAR = 1900 & OCC1950 = 31) | 
(YEAR = 1900 & OCC1950 = 32) | 
(YEAR = 1900 & OCC1950 = 55) | 
(YEAR = 1900 & OCC1950 = 67) | 
(YEAR = 1900 & OCC1950 = 71) | 
(YEAR = 1900 & OCC1950 = 74) | 
(YEAR = 1900 & OCC1950 = 75) | 
(YEAR = 1900 & OCC1950 = 82) | 
(YEAR = 1900 & OCC1950 = 97) | 
(YEAR = 1900 & OCC1950 = 98) | 
(YEAR = 1900 & OCC1950 = 201) | 
(YEAR = 1900 & OCC1950 = 410) | 
(YEAR = 1900 & OCC1950 = 430) | 
(YEAR = 1900 & OCC1950 = 470) | 
(YEAR = 1900 & OCC1950 = 582) | 
(YEAR = 1900 & OCC1950 = 752) | 
(YEAR = 1900 & OCC1950 = 772) | 
(YEAR = 1850 & OCC1950 = 26) | 
(YEAR = 1860 & OCC1950 = 26) | 
(YEAR = 1870 & OCC1950 = 26) | 
(YEAR = 1880 & OCC1950 = 26) | 
(YEAR = 1900 & OCC1950 = 26))) LABREL=121. 
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 36) | 
(YEAR = 1850 & OCC1950 = 554) | 
(YEAR = 1850 & OCC1950 = 591) | 
(YEAR = 1850 & OCC1950 = 645) | 
(YEAR = 1860 & OCC1950 = 36) | 
(YEAR = 1870 & OCC1950 = 36) | 
(YEAR = 1870 & OCC1950 = 555) | 
(YEAR = 1870 & OCC1950 = 810) | 
(YEAR = 1880 & OCC1950 = 36) | 
(YEAR = 1880 & OCC1950 = 47) | 
(YEAR = 1880 & OCC1950 = 555))) LABREL=13014. 
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1870 & OCC1950 = 52) | 
(YEAR = 1880 & OCC1950 = 52) | 
(YEAR = 1900 & OCC1950 = 52))) LABREL=13018. 
            IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 29) | 
(YEAR = 1850 & OCC1950 = 43) | 
(YEAR = 1850 & OCC1950 = 76) | 
(YEAR = 1850 & OCC1950 = 630) | 
(YEAR = 1850 & OCC1950 = 970) | 
(YEAR = 1860 & OCC1950 = 29) | 
(YEAR = 1860 & OCC1950 = 43) | 
(YEAR = 1860 & OCC1950 = 76) | 
(YEAR = 1860 & OCC1950 = 630) | 
(YEAR = 1860 & OCC1950 = 970) | 
(YEAR = 1870 & OCC1950 = 29) | 
(YEAR = 1870 & OCC1950 = 43) | 
(YEAR = 1870 & OCC1950 = 76) | 
(YEAR = 1870 & OCC1950 = 630) | 
(YEAR = 1870 & OCC1950 = 970) | 
(YEAR = 1880 & OCC1950 = 29) | 
(YEAR = 1880 & OCC1950 = 43) | 
(YEAR = 1880 & OCC1950 = 76) | 
(YEAR = 1880 & OCC1950 = 630) | 
(YEAR = 1880 & OCC1950 = 731) | 
(YEAR = 1880 & OCC1950 = 970) | 
(YEAR = 1900 & OCC1950 = 29) | 
(YEAR = 1900 & OCC1950 = 43) | 
(YEAR = 1900 & OCC1950 = 76) | 
(YEAR = 1900 & OCC1950 = 91) | 
(YEAR = 1900 & OCC1950 = 92) | 
(YEAR = 1900 & OCC1950 = 630) | 
(YEAR = 1900 & OCC1950 = 731) | 
(YEAR = 1900 & OCC1950 = 970))) LABREL=14018. 
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 3) | 
(YEAR = 1850 & OCC1950 = 49) | 
(YEAR = 1850 & OCC1950 = 54) | 
(YEAR = 1850 & OCC1950 = 201) | 
(YEAR = 1850 & OCC1950 = 410) | 
(YEAR = 1850 & OCC1950 = 563) | 
(YEAR = 1850 & OCC1950 = 751) | 
(YEAR = 1850 & OCC1950 = 840) | 
(YEAR = 1860 & OCC1950 = 3) | 
(YEAR = 1860 & OCC1950 = 49) | 
(YEAR = 1860 & OCC1950 = 54) | 
(YEAR = 1860 & OCC1950 = 201) | 
(YEAR = 1860 & OCC1950 = 410) | 
(YEAR = 1860 & OCC1950 = 563) | 
(YEAR = 1860 & OCC1950 = 751) | 
(YEAR = 1860 & OCC1950 = 840) | 
(YEAR = 1870 & OCC1950 = 3) | 
(YEAR = 1870 & OCC1950 = 49) | 
(YEAR = 1870 & OCC1950 = 54) | 
(YEAR = 1870 & OCC1950 = 201) | 
(YEAR = 1870 & OCC1950 = 410) | 
(YEAR = 1870 & OCC1950 = 840) | 
(YEAR = 1880 & OCC1950 = 3) | 
(YEAR = 1880 & OCC1950 = 49) | 
(YEAR = 1880 & OCC1950 = 54) | 
(YEAR = 1880 & OCC1950 = 73) | 
(YEAR = 1880 & OCC1950 = 201) | 
(YEAR = 1880 & OCC1950 = 410) | 
(YEAR = 1880 & OCC1950 = 840) | 
(YEAR = 1900 & OCC1950 = 54) | 
(YEAR = 1900 & OCC1950 = 100) | 
(YEAR = 1900 & OCC1950 = 290) | 
(YEAR = 1900 & OCC1950 = 840))) LABREL=121013.  
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 16) | 
(YEAR = 1850 & OCC1950 = 48) | 
(YEAR = 1850 & OCC1950 = 58) | 
(YEAR = 1850 & OCC1950 = 78) | 
(YEAR = 1850 & OCC1950 = 96) | 
(YEAR = 1850 & OCC1950 = 480) | 
(YEAR = 1850 & OCC1950 = 530) | 
(YEAR = 1850 & OCC1950 = 594) | 
(YEAR = 1850 & OCC1950 = 625) | 
(YEAR = 1850 & OCC1950 = 672) | 
(YEAR = 1850 & OCC1950 = 710) | 
(YEAR = 1850 & OCC1950 = 781) | 
(YEAR = 1860 & OCC1950 = 16) | 
(YEAR = 1860 & OCC1950 = 48) | 
(YEAR = 1860 & OCC1950 = 58) | 
(YEAR = 1860 & OCC1950 = 78) | 
(YEAR = 1860 & OCC1950 = 96) | 
(YEAR = 1860 & OCC1950 = 480) | 
(YEAR = 1860 & OCC1950 = 530) | 
(YEAR = 1860 & OCC1950 = 594) | 
(YEAR = 1860 & OCC1950 = 625) | 
(YEAR = 1860 & OCC1950 = 672) | 
(YEAR = 1860 & OCC1950 = 710) | 
(YEAR = 1860 & OCC1950 = 781) | 
(YEAR = 1870 & OCC1950 = 16) | 
(YEAR = 1870 & OCC1950 = 48) | 
(YEAR = 1870 & OCC1950 = 96) | 
(YEAR = 1870 & OCC1950 = 530) | 
(YEAR = 1870 & OCC1950 = 594) | 
(YEAR = 1870 & OCC1950 = 625) | 
(YEAR = 1870 & OCC1950 = 710) | 
(YEAR = 1870 & OCC1950 = 781) | 
(YEAR = 1870 & OCC1950 = 910) | 
(YEAR = 1880 & OCC1950 = 16) | 
(YEAR = 1880 & OCC1950 = 48) | 
(YEAR = 1880 & OCC1950 = 62) | 
(YEAR = 1880 & OCC1950 = 96) | 
(YEAR = 1880 & OCC1950 = 230) | 
(YEAR = 1880 & OCC1950 = 530) | 
(YEAR = 1880 & OCC1950 = 625) | 
(YEAR = 1880 & OCC1950 = 710) | 
(YEAR = 1880 & OCC1950 = 910) | 
(YEAR = 1900 & OCC1950 = 19) | 
(YEAR = 1900 & OCC1950 = 28) | 
(YEAR = 1900 & OCC1950 = 41) | 
(YEAR = 1900 & OCC1950 = 57) | 
(YEAR = 1900 & OCC1950 = 62) | 
(YEAR = 1900 & OCC1950 = 69) | 
(YEAR = 1900 & OCC1950 = 96) | 
(YEAR = 1900 & OCC1950 = 230) | 
(YEAR = 1900 & OCC1950 = 460) | 
(YEAR = 1900 & OCC1950 = 501) | 
(YEAR = 1900 & OCC1950 = 563) | 
(YEAR = 1900 & OCC1950 = 565) | 
(YEAR = 1900 & OCC1950 = 633) | 
(YEAR = 1900 & OCC1950 = 710) | 
(YEAR = 1900 & OCC1950 = 751) | 
(YEAR = 1900 & OCC1950 = 910))) LABREL=121014.  
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 230) | 
(YEAR = 1850 & OCC1950 = 501) | 
(YEAR = 1850 & OCC1950 = 740) | 
(YEAR = 1860 & OCC1950 = 230) | 
(YEAR = 1860 & OCC1950 = 501) | 
(YEAR = 1860 & OCC1950 = 645) | 
(YEAR = 1860 & OCC1950 = 740) | 
(YEAR = 1870 & OCC1950 = 230) | 
(YEAR = 1870 & OCC1950 = 501) | 
(YEAR = 1870 & OCC1950 = 645) | 
(YEAR = 1870 & OCC1950 = 740) | 
(YEAR = 1880 & OCC1950 = 501) | 
(YEAR = 1880 & OCC1950 = 644) | 
(YEAR = 1880 & OCC1950 = 645) | 
(YEAR = 1880 & OCC1950 = 740) | 
(YEAR = 1880 & OCC1950 = 810) | 
(YEAR = 1900 & OCC1950 = 3) | 
(YEAR = 1900 & OCC1950 = 47) | 
(YEAR = 1900 & OCC1950 = 49) | 
(YEAR = 1900 & OCC1950 = 73) | 
(YEAR = 1900 & OCC1950 = 123) | 
(YEAR = 1900 & OCC1950 = 555) | 
(YEAR = 1900 & OCC1950 = 644) | 
(YEAR = 1900 & OCC1950 = 740) | 
(YEAR = 1900 & OCC1950 = 810))) LABREL=121013014.  
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 91) | 
(YEAR = 1850 & OCC1950 = 92) | 
(YEAR = 1850 & OCC1950 = 731) | 
(YEAR = 1860 & OCC1950 = 91) | 
(YEAR = 1860 & OCC1950 = 92) | 
(YEAR = 1860 & OCC1950 = 99) | 
(YEAR = 1860 & OCC1950 = 731) | 
(YEAR = 1870 & OCC1950 = 91) | 
(YEAR = 1870 & OCC1950 = 92) | 
(YEAR = 1870 & OCC1950 = 99) | 
(YEAR = 1870 & OCC1950 = 731) | 
(YEAR = 1880 & OCC1950 = 91) | 
(YEAR = 1880 & OCC1950 = 92) | 
(YEAR = 1880 & OCC1950 = 99) | 
(YEAR = 1900 & OCC1950 = 70) | 
(YEAR = 1900 & OCC1950 = 99))) LABREL=121014018. 
IF  (MISSING(LABREL) & ((MISSING(EMPSTATD) & (( YEAR = 1920 & CLASSWKRD = 00 ) | (YEAR  ~= 1920 & 
    LABFORCE = 2))) | ((EMPSTATD = 10 | EMPSTATD = 11 | EMPSTATD = 12 | EMPSTATD = 13 | EMPSTATD = 14 | 
    EMPSTATD = 15 ) & CLASSWKRD = 00 )) & ((YEAR = 1850 & OCC1950 = 70) | 
(YEAR = 1860 & OCC1950 = 70) | 
(YEAR = 1870 & OCC1950 = 70) | 
(YEAR = 1880 & OCC1950 = 70))) LABREL=121013014018. 
EXECUTE.

*/ Running the syntax on 17/11/2015 took 63 minutes on a OS X El Capitan: MacBook Pro 11,2 / Intel Core i7 / 2.8 GHz 
*/ quadcore / 16GB memory.
*/ UPDATE 10/1/2018: reduced the number of executes in the syntax, and deleted some duplicate rules: must therefore be quicker now.  

*/ TEMPORARY ADDITION:
*/ Meant to aggregate self-employed and wage-earning categories, 
*/ and add an numerical indication of the number of years of schooling, using available non-numerical values. 

NUMERIC SE (f8).
NUMERIC WE (f8).
NUMERIC EITHER (f8).
NUMERIC OTHER (f8).
NUMERIC EDUYEAR (f8.1).
EXECUTE.

VARIABLE LABELS SE "Self-employment status".
VALUE LABELS SE
0 "N/A" 
1 "Self-employed".

IF (LABREL = 121 | LABREL = 122 | LABREL = 13 | LABREL = 121013) SE=1.
EXECUTE.
IF (MISSING(SE)) SE=0.
EXECUTE. 

VARIABLE LABELS WE "Wage-earners status".
VALUE LABELS WE
0 "N/A" 
1 "Wage-earner".

IF (LABREL = 14 | LABREL = 18 | LABREL = 14018) WE=1.
EXECUTE.
IF (MISSING(WE)) WE=0.
EXECUTE. 

VARIABLE LABELS EITHER "Either Wage-earner or self-employed".
VALUE LABELS EITHER
0 "N/A" 
1 "Either Wage-earner or self-employed".

IF (LABREL = 121014 | LABREL = 121013014 | LABREL = 121014018) EITHER=1.
EXECUTE.
IF (MISSING(EITHER)) EITHER=0.
EXECUTE. 

VARIABLE LABELS OTHER "Other labour relation".
VALUE LABELS OTHER
0 "N/A" 
1 "Other labour relation".

IF (SE = 0 & WE = 0 & EITHER = 0) OTHER=1.
EXECUTE.
IF (MISSING(OTHER)) OTHER=0.
EXECUTE. 

VARIABLE LABELS EDUYEAR "Years of schooling (from Kindergarten)".
EXECUTE.

IF (EDUCD = 0 ) EDUYEAR = 0.
IF (EDUCD = 1 ) EDUYEAR = 0.
IF (EDUCD = 2 ) EDUYEAR = 0.
IF (EDUCD = 10 ) EDUYEAR = 2.5.
IF (EDUCD = 11 ) EDUYEAR = 0.
IF (EDUCD = 12 ) EDUYEAR = 1.
IF (EDUCD = 13 ) EDUYEAR = 3.6.
IF (EDUCD = 14 ) EDUYEAR = 2.
IF (EDUCD = 15 ) EDUYEAR = 3.
IF (EDUCD = 16 ) EDUYEAR = 4.
IF (EDUCD = 17 ) EDUYEAR = 5.
IF (EDUCD = 20 ) EDUYEAR = 7.9.
IF (EDUCD = 21 ) EDUYEAR = 6.6.
IF (EDUCD = 22 ) EDUYEAR = 6.
IF (EDUCD = 23 ) EDUYEAR = 7.
IF (EDUCD = 24 ) EDUYEAR = 8.6.
IF (EDUCD = 25 ) EDUYEAR = 8.
IF (EDUCD = 26 ) EDUYEAR = 9.
IF (EDUCD = 30 ) EDUYEAR = 10.
IF (EDUCD = 40 ) EDUYEAR = 11.
IF (EDUCD = 50 ) EDUYEAR = 12.
IF (EDUCD = 60 ) EDUYEAR = 13.
IF (EDUCD = 61 ) EDUYEAR = 13.
IF (EDUCD = 62 ) EDUYEAR = 13.
IF (EDUCD = 63 ) EDUYEAR = 13.
IF (EDUCD = 64 ) EDUYEAR = 13.
IF (EDUCD = 65 ) EDUYEAR = 13.
IF (EDUCD = 70 ) EDUYEAR = 14.
IF (EDUCD = 71 ) EDUYEAR = 14.
IF (EDUCD = 80 ) EDUYEAR = 15.
IF (EDUCD = 81 ) EDUYEAR = 15.
IF (EDUCD = 82 ) EDUYEAR = 15.
IF (EDUCD = 83 ) EDUYEAR = 15.
IF (EDUCD = 90 ) EDUYEAR = 16.
IF (EDUCD = 100 ) EDUYEAR = 17.
IF (EDUCD = 101 ) EDUYEAR = 16.7.
IF (EDUCD = 110 ) EDUYEAR = 18.
IF (EDUCD = 111 ) EDUYEAR = 19.
IF (EDUCD = 112 ) EDUYEAR = 20.
IF (EDUCD = 113 ) EDUYEAR = 21.
IF (EDUCD = 114 ) EDUYEAR = 18.4.
IF (EDUCD = 115 ) EDUYEAR = 20.4.
IF (EDUCD = 116 ) EDUYEAR = 21.
IF (EDUCD = 999 ) EDUYEAR = 0.
EXECUTE.
