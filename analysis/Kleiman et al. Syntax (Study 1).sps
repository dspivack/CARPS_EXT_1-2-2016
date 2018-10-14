* Encoding: UTF-8.
USE ALL.
COMPUTE filter_$=(check_pass=1 & Categorize_correct>=85).
VARIABLE LABELS filter_$ 'check1=1 & Categorize_correct>=85 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

COMPUTE Categorize_correct=SUM(Obama1A,Obama2A,Obama3A,Obama4A,Obama5A,Obama6A,Obama7A,Obama8A,
    Obama9A,Obama10A,Obama11A,Obama12A,Obama13A,Obama14A,Obama15A,Obama16A,Obama17A,Obama18A,Obama19A,
    Obama20A,Obama21A,Obama22A,Obama23A,Obama24A,Obama25A,Obama26A,Obama27A,Obama28A,Obama29A,Obama30A,
    Obama31A,Obama32A,Obama33A,Obama34A,Obama35A,Obama36A,Obama37A,Obama38A,Obama39A,Obama40A,Obama41A,
    Obama42A,Obama43A,Obama44A,Obama45A,Obama46A,Obama47A,Obama48A,Obama49A,Obama50A,Romney1,Romney2,
    Romney3,Romney4,Romney5,Romney6,Romney7,Romney8,Romney9,Romney10,Romney11,Romney12,Romney13,
    Romney14,Romney15,Romney16,Romney17,Romney18,Romney19,Romney20,Romney21,Romney22,Romney23,Romney24,
    Romney25,Romney26,Romney27,Romney28,Romney29,Romney30,Romney31,Romney32,Romney33,Romney34,Romney35,
    Romney36,Romney37,Romney38,Romney39,Romney40,Romney41,Romney42,Romney43,Romney44,Romney45,Romney46,
    Romney47,Romney48,Romney49,Romney50).
EXECUTE.

DESCRIPTIVES VARIABLES=Age
  /STATISTrICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=Condition Sex
  /ORDER=ANALYSIS.

*all items are coded so that higher numbers mean more conservative beliefs.
RECODE O_abortion O_marriage O_AfAct O_guns O_StemCell R_abortion R_marriage R_affiact R_guns 
    R_StemCell (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO O_abortion_reverse O_marriage_reverse 
    O_affirmative_action_reverse O_guns_reverse O_stem_cells_reverse R_abortion_reverse 
    R_marriage_reverse R_affirmative_action_reverse R_guns_reverse R_stem_cells_reverse.
EXECUTE.

RELIABILITY
  /VARIABLES=O_ideology O_economic O_social
  /SCALE("Obama's Ideologies") ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE
  /SUMMARY=TOTAL.

RELIABILITY
  /VARIABLES=R_ideology R_economic R_social
  /SCALE("Romney's Ideologies") ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE
  /SUMMARY=TOTAL.

RELIABILITY
  /VARIABLES=O_environment O_interrogate O_immigration O_Iran O_deathpen O_abortion_reverse 
    O_marriage_reverse O_affirmative_action_reverse O_guns_reverse O_stem_cells_reverse
  /SCALE("Obama's Beliefs on Specific Issues") ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

RELIABILITY
  /VARIABLES=R_environment R_interrogation R_immigration R_Iran R_deathpen R_abortion_reverse 
    R_marriage_reverse R_affirmative_action_reverse R_guns_reverse R_stem_cells_reverse
  /SCALE("Romney's Beliefs on Specific Issues") ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

COMPUTE Romney_specific_issues_composite=MEAN(R_environment,R_interrogation,R_immigration,R_Iran,
    R_deathpen,R_abortion_reverse,R_marriage_reverse,R_affirmative_action_reverse,R_guns_reverse,
    R_stem_cells_reverse).
COMPUTE Obama_specific_issues_composite=MEAN(O_environment,O_interrogate,O_immigration,O_Iran,
    O_deathpen,O_abortion_reverse,O_marriage_reverse,O_affirmative_action_reverse,O_guns_reverse,
    O_stem_cells_reverse).
COMPUTE delta_Romney_Obama_specific_issues=
    Romney_specific_issues_composite-Obama_specific_issues_composite.
EXECUTE.

COMPUTE Obama_ideology_composite=MEAN(O_ideology,O_economic,O_social).
COMPUTE Romney_ideology_composite=MEAN(R_ideology,R_economic,R_social).
COMPUTE delta_Romney_Obama_ideology_composite=Romney_ideology_composite-Obama_ideology_composite.
EXECUTE.

*testing whether the perceived difference between Obama's and Romney's ideologies changes as a function of congruency condition.
T-TEST GROUPS=Condition(-1 1)
  /MISSING=ANALYSIS
  /VARIABLES=delta_Romney_Obama_ideology_composite
  /CRITERIA=CI(.95).

*testing whether the perceived difference between Obama's and Romney's beliefs on specific issues changes as a function of congruency condition.
T-TEST GROUPS=Condition(-1 1)
  /MISSING=ANALYSIS
  /VARIABLES=delta_Romney_Obama_specific_issues
  /CRITERIA=CI(.95).




