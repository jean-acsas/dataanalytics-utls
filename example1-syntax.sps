/*. csv-Daten einlesen.
GET DATA
  /TYPE=TXT
  /FILE="C:\Example\results_VarNamesReplaced.csv"
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES=
  v1 F3.0
  v2 A19
  v3 F1.0
  v4 A2
  v5 A8
  v6 A10
  v7 A4
  v8 A11
  v9 A24
  v10 A4
  v11 A17
  v12 A19
  v13 A4
  v14 A4
  v15 A4
  v16 A25
  v17 A4
  v18 F2.0
  v19 A117
  v20 A4
  v21 A4
  v22 A4
  v23 A4
  v24 A4
  v25 A12
  v26 A4.
CACHE.
EXECUTE.
DATASET NAME DataSet3 WINDOW=FRONT.

/* als SPSS-Datei speichern.
SAVE OUTFILE='C:\Example\CleanedUpSPSSData.sav'
  /COMPRESSED.
EXECUTE.

/****** Aufräumen.
/* Nur Fälle/Zeilen auswählen die nicht leer sind. 
SELECT IF (v2 NE ''). 
EXECUTE.

/* variablen entfernen die überall dieselben Werte haben.
DELETE VARIABLES V2 V3 V4. 
EXECUTE. 

/******* Codieren.
/*** binäre Fälle (ja/nein, männlich/weiblich) in 1/0 umcodieren.
RECODE v5 ("männlich" = "0")("weiblich" = "1").
RECODE v6 ("keine" = "0")("mehr als 3" = "4").
RECODE v7 v10 v13 TO v15 v17 v20 TO v24 v26 ("Ja" = "1") ("Nein" = "0").
RECODE v8  ("17-25 Jahre" = "1")("26-35 Jahre" = "2")("36-45 Jahre" = "3")("46-55 Jahre" = "4")("56-65 Jahre" = "5")("> 65 Jahre" = "6").
RECODE v9  ("< 3 Jahre (Fahranfänger)" = "1")("3-5 Jahre" = "2")("6-10 Jahre" = "3")("11-15 Jahre" = "4")("16-25 Jahre" = "5")("26 und mehr Jahre" = "6").
RECODE v11  ("1-2 mal pro Woche" = "1")("3-4 mal pro Woche" = "2")("5 mal pro Woche" = "3")("6-7 mal pro Woche" = "4").
RECODE v12 ("weniger als 9000 km" = "1")("9.000 - 12.000 km" = "2")("12.000 - 20.000 km" = "3")("20.000 - 30.000 km" = "4")("30.000 - 50.000 km" = "5")("50.000 - 80.000 km" = "6")("mehr als 80.000 km" = "7").
RECODE v25 ("0-30 Euro" = "1")("31-50 Euro" = "4")("51-100 Euro" = "5")("101-150 Euro" = "2")("150-200 Euro" = "3").
EXECUTE.

/*** Als numerische und ordinale Variablen interpretieren wo angebracht.
ALTER TYPE  v1 v6 v8 v9 v11 v12 v18 v25 (F2).
EXECUTE.
VARIABLE LEVEL v1 v6 v8 v9 v11 v12 v18 v25 (ORDINAL).
EXECUTE.

ALTER TYPE v5 v7 v10 v13 TO v15 v17 v20 TO v24 v26 (F1).
EXECUTE.
VARIABLE LEVEL v5 v7 v10 v13 TO v15 v17 v20 TO v24 v26 (NOMINAL).
EXECUTE. 


/*** die Value Labels und Values setzen.
VARIABLE LABELS v1 'ID-Befragter'.
VARIABLE LABELS v16 'Eigener Fahrzeugtyp'.
VARIABLE LABELS v18 'Gefühlte Häufigkeit dass andere Fahrzeuge zu dicht auffahren'.
VARIABLE LABELS v19 'Situation in der sich der/die Befragte(r) von einem einholendem Auto bedrängt fühlt'.

VARIABLE LABELS v7 'In einer festen Partnerschaft'.
VARIABLE LABELS v10 'Besitzt ein eigenes Auto'.
VARIABLE LABELS v13 'Großteil gefahrene Kilometer [Innerorts]'.
VARIABLE LABELS v14 'Großteil gefahrene Kilometer [Landstraße]'.
VARIABLE LABELS v15 'Großteil gefahrene Kilometer [Autobahn]'.
VARIABLE LABELS v17 'Wurde kürzlich von auffahrendem Auto bedrängt'.
VARIABLE LABELS v20 'Interpretiert Lichthupe als harmlosen Hinweis des einholenden Fahrzeugs'.
VARIABLE LABELS v21 'Selber kürzlich Sicherheitsabstand unterschritten'.
VARIABLE LABELS v22 'Hält Warnung bei Sicherheitsabstandsunterschreitung für sinnvoll'.
VARIABLE LABELS v23 'Würde die Warnung beachten und den Abstand vergrößern'.
VARIABLE LABELS v24 'Würde ein System zur Warnung bei Unterschreitung des Sicherheitsabstands kaufen'.
VARIABLE LABELS v26 'Überzeugt dass ein solches System das Unfallrisiko senken würde'.
EXECUTE.

VALUE LABELS 
 v7 v10 v13 TO v15 v17 v20 TO v24 v26
1 'ja'
0 'nein'.
EXECUTE.

VARIABLE LABELS v5 'Geschlecht'.
VALUE LABELS 
v5
0 'männlich'
1 'weiblich'.
EXECUTE.

VARIABLE LABELS v6 'Kinderanzahl'.
VALUE LABELS 
v6
0 '0 Kinder'
1 '1 Kind'
2 '2 Kinder'
3 '3 Kinder'
4 'Mehr als 3 Kinder'.
EXECUTE.

NUMERIC v27 (F1).
DO IF (v6 > 0). 
     COMPUTE v27 = 1.
ELSE.
     COMPUTE v27 = 0.
END IF.
EXECUTE. 

VARIABLE LABELS v27 'Hat Kinder'.
VALUE LABELS 
v27
0 'nein'
1 'ja'.
EXECUTE.

VARIABLE LABELS v8 'Altersgruppe'.
VALUE LABELS 
v8
1 '17-25 Jahre'
2 '26-35 Jahre'
3 '36-45 Jahre'
4 '46-55 Jahre'
5 '56-65 Jahre'
6 '> 65 Jahre'.
EXECUTE.

VARIABLE LABELS v9 'Fahrerfahrung'.
VALUE LABELS 
v9
1 '< 3 Jahre (Fahranfänger)'
2 '3-5 Jahre'
3 '6-10 Jahre'
4 '11-15 Jahre'
5 '16-25 Jahre'
6 '26 und mehr Jahre'.
EXECUTE.

VARIABLE LABELS v11 'Fahrzeugnutzung'.
VALUE LABELS 
v11
1 '1-2 mal pro Woche'
2 '3-4 mal pro Woche'
3 '5 mal pro Woche'
4 '6-7 mal pro Woche'.
EXECUTE.

VARIABLE LABELS v12 'Gefahrene Kilometer im Jahr'.
VALUE LABELS 
v12
1 'weniger als 9000 km'
2 '9.000 - 12.000 km'
3 '12.000 - 20.000 km'
4 '20.000 - 30.000 km'
5 '30.000 - 50.000 km'
6 '50.000 - 80.000 km'
7 'mehr als 80.000 km'.
EXECUTE.

VARIABLE LABELS v25 'Preisrahmen'.
VALUE LABELS 
v25
1 '0-30 Euro'
2 '31-50 Euro'
3 '51-100 Euro'
4 '101-150 Euro'
5 '151-200 Euro'.
EXECUTE.
/********* Datenvorbereitung abgeschlossen.

/********* Analyse.
* Rund 43% der Befragten würden das System kaufen.
GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=v24 COUNT()[name="COUNT"] MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE. 
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: v24=col(source(s), name("v24"), unit.category()) 
  DATA: COUNT=col(source(s), name("COUNT")) 
  COORD: polar.theta(startAngle(0)) 
  GUIDE: axis(dim(1), null()) 
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Würde ein System zur Warnung bei Unterschreitung des Sicherheitsabstands kaufen")) 
  SCALE: linear(dim(1), dataMinimum(), dataMaximum()) 
  SCALE: cat(aesthetic(aesthetic.color.interior), include("0", "1")) 
  ELEMENT: interval.stack(position(summary.percent(COUNT))), color.interior(v24)) 
END GPL.

* Ein sehr billiges System (<= 30 Euro) würde kaum jemand kaufen, viele jedoch ein etwas teureres System im Bereich 31-50 Euro ("kein Billiggerät kaufen"?). Die meisten würden jedoch gleich ein wertiges Produkt zwischen 100 und 200 Euro kaufen.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=v25 COUNT()[name="COUNT"] v24 MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE  INLINETEMPLATE=
  ["<addDataLabels><labeling variable='percent'/><labeling variable='percent'><format maximumFractionDigits='2' minimumFractionDigits='2' prefix=' ' suffix='%' useGrouping='true'/></labeling></addDataLabels>"].
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: v25=col(source(s), name("v25"), unit.category()) 
  DATA: COUNT=col(source(s), name("COUNT")) 
  DATA: v24=col(source(s), name("v24"), unit.category()) 
  GUIDE: axis(dim(1), label("Preisrahmen")) 
  GUIDE: axis(dim(2), label("Prozent")) 
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Würde ein System zur Warnung bei Unterschreitung des Sicherheitsabstands kaufen")) 
  SCALE: cat(dim(1), include("1", "2", "3", "4", "5")) 
  SCALE: linear(dim(2), include(0)) 
  SCALE: cat(aesthetic(aesthetic.color.interior), include("0", "1")) 
  ELEMENT: interval.stack(position(summary.percent(v25*COUNT, base.coordinate(dim(1)))), color.interior(v24), shape.interior(shape.square)) 
END GPL.

* Personen mit Kindern würden das System eher kaufen.
GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=v27 COUNT()[name="COUNT"] v24 MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE INLINETEMPLATE=
  ["<addDataLabels><labeling variable='percent'/><labeling variable='percent'><format maximumFractionDigits='2' minimumFractionDigits='2' prefix=' ' suffix='%' useGrouping='true'/></labeling></addDataLabels>"].
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: v27=col(source(s), name("v27"), unit.category()) 
  DATA: COUNT=col(source(s), name("COUNT")) 
  DATA: v24=col(source(s), name("v24"), unit.category()) 
  GUIDE: axis(dim(1), label("Hat Kinder")) 
  GUIDE: axis(dim(2), label("Prozent")) 
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Würde ein System zur Warnung bei Unterschreitung des Sicherheitsabstands kaufen")) 
  SCALE: cat(dim(1), include("0", "1")) 
  SCALE: linear(dim(2), include(0)) 
  SCALE: cat(aesthetic(aesthetic.color.interior), include("0", "1")) 
  ELEMENT: interval.stack(position(summary.percent(v27*COUNT, base.coordinate(dim(1)))), color.interior(v24), shape.interior(shape.square)) 
END GPL.

* Frauen eher als Männer.
GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=v5 COUNT()[name="COUNT"] v24 MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE INLINETEMPLATE=
  ["<addDataLabels><labeling variable='percent'/><labeling variable='percent'><format maximumFractionDigits='2' minimumFractionDigits='2' prefix=' ' suffix='%' useGrouping='true'/></labeling></addDataLabels>"].
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: v5=col(source(s), name("v5"), unit.category()) 
  DATA: COUNT=col(source(s), name("COUNT")) 
  DATA: v24=col(source(s), name("v24"), unit.category()) 
  GUIDE: axis(dim(1), label("Geschlecht")) 
  GUIDE: axis(dim(2), label("Prozent")) 
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Würde ein System zur Warnung bei Unterschreitung des Sicherheitsabstands kaufen")) 
  SCALE: cat(dim(1), include("0", "1")) 
  SCALE: linear(dim(2), include(0)) 
  SCALE: cat(aesthetic(aesthetic.color.interior), include("0", "1")) 
  ELEMENT: interval.stack(position(summary.percent(v5*COUNT, base.coordinate(dim(1)))), color.interior(v24), shape.interior(shape.square)) 
END GPL.

* Je älter die Personen sind, desto wahrscheinlicher ist ein Kauf. 
GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=v8 COUNT()[name="COUNT"] v24 MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE  INLINETEMPLATE=
  ["<addDataLabels><labeling variable='percent'/><labeling variable='percent'><format maximumFractionDigits='2' minimumFractionDigits='2' prefix=' ' suffix='%' useGrouping='true'/></labeling></addDataLabels>"].
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: v8=col(source(s), name("v8"), unit.category()) 
  DATA: COUNT=col(source(s), name("COUNT")) 
  DATA: v24=col(source(s), name("v24"), unit.category()) 
  GUIDE: axis(dim(1), label("Altersgruppe")) 
  GUIDE: axis(dim(2), label("Prozent")) 
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Würde ein System zur Warnung bei Unterschreitung des Sicherheitsabstands kaufen")) 
  SCALE: cat(dim(1), include("1", "2", "3", "4", "5", "6")) 
  SCALE: linear(dim(2), include(0)) 
  SCALE: cat(aesthetic(aesthetic.color.interior), include("0", "1")) 
  ELEMENT: interval.stack(position(summary.percent(v8*COUNT, base.coordinate(dim(1)))), color.interior(v24), shape.interior(shape.square)) 
END GPL.

* Auch Personen die im Jahr viele Kilometer fahren wünschen sich eher ein solches System. 
GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=v12 COUNT()[name="COUNT"] v24 MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE  INLINETEMPLATE=
  ["<addDataLabels><labeling variable='percent'/><labeling variable='percent'><format maximumFractionDigits='2' minimumFractionDigits='1' prefix=' ' suffix='%' useGrouping='true'/></labeling></addDataLabels>"].
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: v12=col(source(s), name("v12"), unit.category()) 
  DATA: COUNT=col(source(s), name("COUNT")) 
  DATA: v24=col(source(s), name("v24"), unit.category()) 
  GUIDE: axis(dim(1), label("Gefahrene Kilometer im Jahr")) 
  GUIDE: axis(dim(2), label("Prozent")) 
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Würde ein System zur Warnung bei Unterschreitung des Sicherheitsabstands kaufen")) 
  SCALE: cat(dim(1), include("1", "2", "3", "4", "5", "6", "7")) 
  SCALE: linear(dim(2), include(0)) 
  SCALE: cat(aesthetic(aesthetic.color.interior), include("0", "1")) 
  ELEMENT: interval.stack(position(summary.percent(v12*COUNT, base.coordinate(dim(1)))), color.interior(v24), shape.interior(shape.square)) 
END GPL.

* Besonders Personen, bei denen kürzlich gedrängelt wurde, wünschen sich ein solches System. 
GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=v17 COUNT()[name="COUNT"] v24 MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE  INLINETEMPLATE=
  ["<addDataLabels><labeling variable='percent'/><labeling variable='percent'><format maximumFractionDigits='2' minimumFractionDigits='1' prefix=' ' suffix='%' useGrouping='true'/></labeling></addDataLabels>"].
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: v17=col(source(s), name("v17"), unit.category()) 
  DATA: COUNT=col(source(s), name("COUNT")) 
  DATA: v24=col(source(s), name("v24"), unit.category()) 
  GUIDE: axis(dim(1), label("Wurde kürzlich von auffahrendem Auto bedrängt")) 
  GUIDE: axis(dim(2), label("Prozent")) 
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Würde ein System zur Warnung bei Unterschreitung des Sicherheitsabstands kaufen")) 
  SCALE: cat(dim(1), include("0", "1")) 
  SCALE: linear(dim(2), include(0)) 
  SCALE: cat(aesthetic(aesthetic.color.interior), include("0", "1")) 
  ELEMENT: interval.stack(position(summary.percent(v17*COUNT, base.coordinate(dim(1)))), color.interior(v24), shape.interior(shape.square)) 
END GPL.

* Generell wünschen sich Personen, denen relativ häufig dicht aufgefahren wird, eher ein solches System. 
GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=v18 COUNT()[name="COUNT"] v24 MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE  INLINETEMPLATE=
  ["<addDataLabels><labeling variable='percent'/><labeling variable='percent'><format maximumFractionDigits='2' minimumFractionDigits='1' prefix=' ' suffix='%' useGrouping='true'/></labeling></addDataLabels>"].
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: v18=col(source(s), name("v18"), unit.category()) 
  DATA: COUNT=col(source(s), name("COUNT")) 
  DATA: v24=col(source(s), name("v24"), unit.category()) 
  GUIDE: axis(dim(1), label("Gefühlte Häufigkeit dass andere Fahrzeuge zu dicht auffahren")) 
  GUIDE: axis(dim(2), label("Percent")) 
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Würde ein System zur Warnung bei Unterschreitung des Sicherheitsabstands kaufen")) 
  SCALE: linear(dim(2), include(0)) 
  SCALE: cat(aesthetic(aesthetic.color.interior), include("0", "1")) 
  ELEMENT: interval.stack(position(summary.percent(v18*COUNT, base.coordinate(dim(1)))), color.interior(v24), shape.interior(shape.square)) 
END GPL.

/********** Tabellen, Histogramme, Korrelationen (fürs Archiv) und kompliziertere Verfahren.
/**** Häufigkeitstabellen und Histogramme für alle Variablen.
FREQUENCIES VARIABLES=v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17 v18 v20 v21 v22 v23 v24 v25 v26 v27 
  /STATISTICS=MEAN SUM 
  /BARCHART FREQ 
  /ORDER=ANALYSIS.

/**** Paarweise Korrelationen zwischen allen Variablen.
CORRELATIONS 
  /VARIABLES=v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v17 v18 v20 v21 v22 v23 v24 v25 v26 v5 v27 
  /PRINT=TWOTAIL NOSIG 
  /STATISTICS DESCRIPTIVES 
  /MISSING=PAIRWISE.

/**** Klassifikation der Käufergruppen durch einen Entscheidungsbaum.
TREE v24 [n] BY v5 [n] v6 [o] v7 [n] v8 [o] v9 [o] v10 [n] v11 [o] v12 [o] v13 [n] v14 [n] v15 [n] v16 [n] v25 [o] v18 [o] v20 [n] 
  /TREE DISPLAY=TOPDOWN NODES=BOTH BRANCHSTATISTICS=YES NODEDEFS=YES SCALE=100 
  /DEPCATEGORIES USEVALUES=[0 1] TARGET=[0 1] 
  /PRINT NONE 
  /GAIN CATEGORYTABLE=NO TYPE=[NODE] SORT=DESCENDING CUMULATIVE=NO 
  /METHOD TYPE=EXHAUSTIVECHAID 
  /GROWTHLIMIT MAXDEPTH=15 MINPARENTSIZE=10 MINCHILDSIZE=5 
  /VALIDATION TYPE=NONE OUTPUT=BOTHSAMPLES 
  /CHAID ALPHASPLIT=0.05 SPLITMERGED=NO CHISQUARE=PEARSON CONVERGE=0.001 MAXITERATIONS=100 ADJUST=BONFERRONI 
  /COSTS EQUAL 
  /MISSING NOMINALMISSING=MISSING.
