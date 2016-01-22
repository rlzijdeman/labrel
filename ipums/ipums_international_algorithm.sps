* Encoding: UTF-8.
GET FILE='/Users/RombertSt/Desktop/IPUMS/International/India.sav'.
/* Pas locatie (+ eventueel naam) aan van bestand.
WEIGHT BY PERWT.
NUMERIC LABREL (f16).
NUMERIC LABREL_2 (f16).
EXECUTE.

VARIABLE LABELS LABREL "Labour relations (primary), taxonomy v.2015".
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
121014018 "12a or 14 or 18: Self-employed leading producer or Wage earners for the market or WE for non-market institutions".
EXECUTE.

VARIABLE LABELS LABREL_2 "Labour relations (secondary), taxonomy v.2015".
VALUE LABELS LABREL_2
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
121014018 "12a or 14 or 18: Self-employed leading producer or Wage earners for the market or WE for non-market institutions".
EXECUTE.

/* Here starts the allocation algorithm.

/* Allocation of inactive population, primary labour relation.

IF (EMPSTATD = 300) LABREL = 10205.     /*INACTIVE (not in labor force).
IF (EMPSTATD = 310) LABREL = 5.         /*Housework.
IF (EMPSTATD = 320) LABREL = 1.         /*Unable to work/disabled.
IF (EMPSTATD = 321) LABREL = 1.         /*Permanent disability.
IF (EMPSTATD = 322) LABREL = 1.         /*Temporary illness.
IF (EMPSTATD = 323) LABREL = 108.       /*Disabled or imprisoned.
IF (EMPSTATD = 330) LABREL = 1.         /*In school.
IF (EMPSTATD = 340) LABREL = 102.       /*Retirees and living on rent.
IF (EMPSTATD = 341) LABREL = 2.         /*Living on rents.
IF (EMPSTATD = 342) LABREL = 102.       /*Living on rents or pension.
IF (EMPSTATD = 343) LABREL = 1.         /*Retirees/pensioners.
IF (EMPSTATD = 344) LABREL = 1.         /*Retired.
IF (EMPSTATD = 345) LABREL = 1.         /*Pensioner.
IF (EMPSTATD = 346) LABREL = 102.       /*Non-retirement pension.
IF (EMPSTATD = 347) LABREL = 1.         /*Disability pension.
IF (EMPSTATD = 348) LABREL = 1.         /*Retired without benefits.
IF (EMPSTATD = 350) LABREL = 1.         /*Elderly.
IF (EMPSTATD = 351) LABREL = 1.         /*Elderly or disabled.
IF (EMPSTATD = 360) LABREL = 1.         /*Institutionalized.
IF (EMPSTATD = 361) LABREL = 8.         /*Prisoner.
IF (EMPSTATD = 370) LABREL = 121014018. /*Intermittent worker.
IF (EMPSTATD = 371) LABREL = 3.         /*Not working, seasonal worker.
IF (EMPSTATD = 372) LABREL = 3.         /*Not working, occasional worker.
IF (EMPSTATD = 380) LABREL = 2.         /*Other income recipient.
IF (EMPSTATD = 390) LABREL = 10205.     /*Inactive, other reasons.
IF (EMPSTATD = 391) LABREL = 1.         /*Too young to work.
IF (EMPSTATD = 392) LABREL = 1.         /*Dependent.
IF (EMPSTATD = 999) LABREL = -1.        /*UNKNOWN/MISSING.
EXECUTE.

/* Allocation of unemployed population, primary labour relation.

IF (EMPSTATD = 200) LABREL = 3.         /*UNEMPLOYED, not specified.
IF (EMPSTATD = 201) LABREL = 3.         /*Unemployed 6 or more months.
IF (EMPSTATD = 202) LABREL = 3.         /*Worked fewer than 6 months, permanent job.
IF (EMPSTATD = 203) LABREL = 3.         /*Worked fewer than 6 months, temporary job.
IF (EMPSTATD = 210) LABREL = 3.         /*Unemployed, experienced worker.
IF (EMPSTATD = 220) LABREL = 3.         /*Unemployed, new worker.
IF (EMPSTATD = 230) LABREL = 3.         /*No work available.
IF (EMPSTATD = 240) LABREL = 3.         /*Inactive unemployed.
EXECUTE.

/* Allocation of armed forces, primary labour relation.

IF (EMPSTATD = 130) LABREL = 18.        /*Armed forces.
IF (EMPSTATD = 131) LABREL = 18.        /*Armed forces, at work.
IF (EMPSTATD = 132) LABREL = 18.        /*Armed forces, not at work in reference period.
IF (EMPSTATD = 133) LABREL = 18.        /*Military trainee.
EXECUTE.

/* Allocation of secondary labour relation.

IF (EMPSTATD = 345) LABREL_2 = 1.       /*At work, and 'student'.
IF (EMPSTATD = 346) LABREL_2 = 5.       /*At work, and 'housework'.
IF (EMPSTATD = 347) LABREL_2 = 3.       /*At work, and 'seeking work'.
IF (EMPSTATD = 348) LABREL_2 = 1.       /*At work, and 'retired'.
IF (EMPSTATD = 350) LABREL_2 = 3.       /*At work, and 'no work'.
IF (EMPSTATD = 351) LABREL_2 = -1.      /*At work, and other situation.
IF (EMPSTATD = 360) LABREL_2 = 3.       /*Have job, not at work in reference period.
IF (EMPSTATD = 361) LABREL_2 = 3.       /*Armed forces, not at work in reference period.
IF (EMPSTATD = 140) LABREL_2 = 3.       /*Marginally employed.
IF (EMPSTATD = 371) LABREL_2 = 121014.  /*Not working, seasonal worker.
IF (EMPSTATD = 372) LABREL_2 = 121014.  /*Not working, occasional worker.
EXECUTE.

/* Allocation in case of missing occupational data (01/2016: 3.2% samples, 9/276, average year 1982).

IF (MISSING(EMPSTATD) & MISSING(CLASSWKD)) LABREL = -1.
EXECUTE.

/* Allocation in case of missing only CLASSWKD (01/2016: 8.3% samples, 23/276, average year 1997).

IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 100) LABREL = 121014018.  /*EMPLOYED, not specified.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 110) LABREL = 121014018.  /*At work.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 111) LABREL = 121014018.  /*At work, and 'student'.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 112) LABREL = 121014018.  /*At work, and 'housework'.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 113) LABREL = 121014018.  /*At work, and 'seeking work'.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 114) LABREL = 121014018.  /*At work, and 'retired'.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 115) LABREL = 121014018.  /*At work, and 'no work'.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 116) LABREL = 121014018.  /*At work, and other situation.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 117) LABREL = 121014018.  /*At work, family holding, not specified.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 118) LABREL = 121014018.  /*At work, family holding, not agricultural.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 119) LABREL = 121014018.  /*At work, family holding, agricultural.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 120) LABREL = 121014018.  /*Have job, not at work in reference period.
IF (MISSING(LABREL) & MISSING(CLASSWKD) & EMPSTATD = 140) LABREL = 121014018.  /*Marginally employed.
EXECUTE.

/* Allocation of active population.

IF (MISSING(LABREL) & CLASSWKD =   0) LABREL = 10205.                        /*NIU (not in universe) [In years with MISSING(EMPSTATD), this is the entire non-working population: therefore LABREL = 10205 instead of -1].
IF (MISSING(LABREL) & CLASSWKD = 100) LABREL = 121013.                       /*SELF-EMPLOYED.
IF (MISSING(LABREL) & CLASSWKD = 101) LABREL = 121.                          /*Self-employed, unincorporated.
IF (MISSING(LABREL) & CLASSWKD = 102) LABREL = 13.                           /*Self-employed, incorporated.
IF (MISSING(LABREL) & CLASSWKD = 110) LABREL = 13.                           /*Employer.
IF (MISSING(LABREL) & CLASSWKD = 111) LABREL = 13.                           /*Sharecropper, employer.
IF (MISSING(LABREL) & CLASSWKD = 120) LABREL = 121.                          /*Working on own account.
IF (MISSING(LABREL) & CLASSWKD = 121) LABREL = 121.                          /*Own account, agriculture.
IF (MISSING(LABREL) & CLASSWKD = 122) LABREL = 122.                          /*Domestic worker, self-employed.
IF (MISSING(LABREL) & (MISSING(HEADLOC))  & CLASSWKD = 123) LABREL = 41042.  /*Subsistence worker, own consumption.
IF (MISSING(LABREL) & (HEADLOC =  PERNUM) & CLASSWKD = 123) LABREL = 41.     /*Subsistence worker, own consumption [Head of household].
IF (MISSING(LABREL) & (HEADLOC ~= PERNUM) & CLASSWKD = 123) LABREL = 42.     /*Subsistence worker, own consumption [Not head of household].
IF (MISSING(LABREL) & CLASSWKD = 124) LABREL = 121.                          /*Own account, other.
IF (MISSING(LABREL) & CLASSWKD = 125) LABREL = 121.                          /*Own account, without temporary/unpaid help.
IF (MISSING(LABREL) & CLASSWKD = 126) LABREL = 121.                          /*Own account, with temporary/unpaid help.
IF (MISSING(LABREL) & CLASSWKD = 130) LABREL = 144.                          /*Member of cooperative.
IF (MISSING(LABREL) & CLASSWKD = 140) LABREL = 141.                          /*Sharecropper.
IF (MISSING(LABREL) & CLASSWKD = 141) LABREL = 121.                          /*Sharecropper, self-employed.
IF (MISSING(LABREL) & CLASSWKD = 142) LABREL = 141.                          /*Sharecropper, employee.
IF (MISSING(LABREL) & CLASSWKD = 150) LABREL = 144.                          /*Kibbutz member.
IF (MISSING(LABREL) & CLASSWKD = 200) LABREL = 14018.                        /*WAGE/SALARY WORKER.
IF (MISSING(LABREL) & CLASSWKD = 201) LABREL = 14018.                        /*Management.
IF (MISSING(LABREL) & CLASSWKD = 202) LABREL = 14018.                        /*Non-management.
IF (MISSING(LABREL) & CLASSWKD = 203) LABREL = 14018.                        /*White collar (non-manual).
IF (MISSING(LABREL) & CLASSWKD = 204) LABREL = 14018.                        /*Blue collar (manual).
IF (MISSING(LABREL) & CLASSWKD = 205) LABREL = 14018.                        /*White and blue collar.
IF (MISSING(LABREL) & CLASSWKD = 206) LABREL = 14018.                        /*Day laborer.
IF (MISSING(LABREL) & CLASSWKD = 207) LABREL = 14018.                        /*Employee, with a permanent job.
IF (MISSING(LABREL) & CLASSWKD = 208) LABREL = 14018.                        /*Employee, occasional, temporary, contract.
IF (MISSING(LABREL) & CLASSWKD = 209) LABREL = 14018.                        /*Employee without legal contract.
IF (MISSING(LABREL) & CLASSWKD = 210) LABREL = 14018.                        /*Wage/salary worker, private employer.
IF (MISSING(LABREL) & CLASSWKD = 211) LABREL = 15.                           /*Apprentice.
IF (MISSING(LABREL) & CLASSWKD = 212) LABREL = 18.                           /*Religious worker.
IF (MISSING(LABREL) & CLASSWKD = 213) LABREL = 18.                           /*Wage/salary worker, non-profit, NGO.
IF (MISSING(LABREL) & CLASSWKD = 214) LABREL = 14.                           /*White collar, private.
IF (MISSING(LABREL) & CLASSWKD = 215) LABREL = 14.                           /*Blue collar, private.
IF (MISSING(LABREL) & CLASSWKD = 216) LABREL = 14.                           /*Paid family worker.
IF (MISSING(LABREL) & CLASSWKD = 217) LABREL = 144.                          /*Cooperative employee.
IF (MISSING(LABREL) & CLASSWKD = 220) LABREL = 18.                           /*Wage/salary worker, government.
IF (MISSING(LABREL) & CLASSWKD = 221) LABREL = 18.                           /*Federal, government employee.
IF (MISSING(LABREL) & CLASSWKD = 222) LABREL = 18.                           /*State government employee.
IF (MISSING(LABREL) & CLASSWKD = 223) LABREL = 18.                           /*Local government employee.
IF (MISSING(LABREL) & CLASSWKD = 224) LABREL = 14.                           /*White collar, public.
IF (MISSING(LABREL) & CLASSWKD = 225) LABREL = 14.                           /*Blue collar, public.
IF (MISSING(LABREL) & CLASSWKD = 226) LABREL = 18.                           /*Public companies.
IF (MISSING(LABREL) & CLASSWKD = 227) LABREL = 18.                           /*Civil servants, local collectives.
IF (MISSING(LABREL) & CLASSWKD = 230) LABREL = 14.                           /*Domestic worker (work for private household).
IF (MISSING(LABREL) & CLASSWKD = 240) LABREL = 14.                           /*Seasonal migrant.
IF (MISSING(LABREL) & CLASSWKD = 241) LABREL = 14.                           /*Seasonal migrant, no broker.
IF (MISSING(LABREL) & CLASSWKD = 242) LABREL = 14.                           /*Seasonal migrant, uses broker.
IF (MISSING(LABREL) & CLASSWKD = 250) LABREL = 14018.                        /*Other wage and salary.
IF (MISSING(LABREL) & CLASSWKD = 251) LABREL = 14018.                        /*Canal zone/commission employee [NB. Panama].
IF (MISSING(LABREL) & CLASSWKD = 252) LABREL = 18.                           /*Government employment/training program.
IF (MISSING(LABREL) & CLASSWKD = 253) LABREL = 18.                           /*Mixed state/private enterprise/parastatal.
IF (MISSING(LABREL) & CLASSWKD = 254) LABREL = 18.                           /*Government public work program.
IF (MISSING(LABREL) & CLASSWKD = 300) LABREL = 122.                          /*UNPAID WORKER.
IF (MISSING(LABREL) & CLASSWKD = 310) LABREL = 122.                          /*Unpaid family worker.
IF (MISSING(LABREL) & CLASSWKD = 320) LABREL = 15.                           /*Apprentice, unpaid or unspecified.
IF (MISSING(LABREL) & CLASSWKD = 330) LABREL = 14.                           /*Trainee.
IF (MISSING(LABREL) & CLASSWKD = 340) LABREL = 14015.                        /*Apprentice or trainee.
IF (MISSING(LABREL) & CLASSWKD = 350) LABREL = 122.                          /*Works for others without wage.
IF (MISSING(LABREL) & CLASSWKD = 400) LABREL = 121014018.                    /*OTHER.
IF (MISSING(LABREL) & CLASSWKD = 999) LABREL = -1.                           /*UNKNOWN/MISSING.
EXECUTE.

/* Re-allocation of active population, unclear public/private.

IF (LABREL = 14018 & MISSING(EMPSECT)) LABREL = 14018.
IF (LABREL = 14018 & EMPSECT =  0) LABREL = 14018.            /*NIU (not in universe).
IF (LABREL = 14018 & EMPSECT = 10) LABREL = 18.               /*Public.
IF (LABREL = 14018 & EMPSECT = 20) LABREL = 14.               /*Private.
IF (LABREL = 14018 & EMPSECT = 21) LABREL = 14.               /*Private, not elsewhere classified.
IF (LABREL = 14018 & EMPSECT = 22) LABREL = 14.               /*Individual/family enterprise, and self-employed.
IF (LABREL = 14018 & EMPSECT = 23) LABREL = 14018.            /*Foreign.
IF (LABREL = 14018 & EMPSECT = 30) LABREL = 18.               /*Mixed: public-private or parastatal.
IF (LABREL = 14018 & EMPSECT = 40) LABREL = 144.              /*Collective or cooperative.
IF (LABREL = 14018 & EMPSECT = 50) LABREL = 18.               /*Foreign government or non-governmental organization.
IF (LABREL = 14018 & EMPSECT = 60) LABREL = 14018.            /*Other, unspecified.
IF (LABREL = 14018 & EMPSECT = 61) LABREL = 14018.            /*Canal zone [NB. Panama].
IF (LABREL = 14018 & EMPSECT = 62) LABREL = 18.               /*Faith-based organization.
IF (LABREL = 14018 & EMPSECT = 99) LABREL = 14018.            /*Unknown.
IF (LABREL = 121014018 & MISSING(EMPSECT)) LABREL = 121014018.
IF (LABREL = 121014018 & EMPSECT =  0) LABREL = 121014018.    /*NIU (not in universe).
IF (LABREL = 121014018 & EMPSECT = 10) LABREL = 18.           /*Public.
IF (LABREL = 121014018 & EMPSECT = 20) LABREL = 121014.       /*Private.
IF (LABREL = 121014018 & EMPSECT = 21) LABREL = 121014.       /*Private, not elsewhere classified.
IF (LABREL = 121014018 & EMPSECT = 22) LABREL = 121.          /*Individual/family enterprise, and self-employed.
IF (LABREL = 121014018 & EMPSECT = 23) LABREL = 121014018.    /*Foreign.
IF (LABREL = 121014018 & EMPSECT = 30) LABREL = 18.           /*Mixed: public-private or parastatal.
IF (LABREL = 121014018 & EMPSECT = 40) LABREL = 144.          /*Collective or cooperative.
IF (LABREL = 121014018 & EMPSECT = 50) LABREL = 18.           /*Foreign government or non-governmental organization.
IF (LABREL = 121014018 & EMPSECT = 60) LABREL = 121014018.    /*Other, unspecified.
IF (LABREL = 121014018 & EMPSECT = 61) LABREL = 121014018.    /*Canal zone [NB. Panama].
IF (LABREL = 121014018 & EMPSECT = 62) LABREL = 18.           /*Faith-based organization.
IF (LABREL = 121014018 & EMPSECT = 99) LABREL = 121014018.    /*Unknown.
EXECUTE.

*/ Running the syntax on 22/01/2016 took 55 seconds on a OS X El Capitan: MacBook Pro 11,2 / Intel Core i7 / 2.8 GHz 
*/ quadcore / 16GB memory. Using India samples (1983, 1987, 1993, 1999, 2004) which have combined just under 3 million cases.
