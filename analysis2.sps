**** Beschreibung der Vorgehensweise ****
1) Fallzahlen f�r Geschenkekauf = 0 und Geschenkekauf = 1 angleichen
2) Faktoreanalyse f�r die Items der Kaufbereitschaft durchf�hren (WTPM_*)
3) ANOVA durchf�hren (Modell s.u.)
4) Realibilit�tsanalyse f�r die Manipulationsvariablen durchf�hren (Man_*)
5) Berechnung und Visualisierung deskriptiver Statistiken des Samples. 

**** Berechnungen und Analyse ****
*** 0) Fallzahlen f�r Geschenkekauf = 0 und Geschenkekauf = 1 angleichen.
** Initial haben wir f�r die Variable Geschenkekauf 76 F�lle, bei denen der Wert "0" ist (also "Produkt f�r Eigenbedarf gekauft" 
    und rund 250 F�lle, bei denen der Wert "1" ist ("Produkt als Geschenk gekauft"). Um diese Fallzahlen Anzugleichen, schlie�en 
    wir jeden dritten Wert der zweiten Gruppe aus. Hierbei handelt es sich also um ein Zufallssampling aus der zweiten Gruppe. Anschlie�end
    haben wir zwei etwa gleich gro�e Gruppen (76 vs. 86). Diese Auswahl erreichen wir, indem wir f�r alle Falle >76
    diejenigen ausw�hlen, deren Fallzahl durch 3 Teilbar ist (also Fallzahl mod 3 = 0):.

COMPUTE filter_$=(($CASENUM <= 76  |  MOD($CASENUM,3) = 0)). 
VARIABLE LABELS filter_$ '($CASENUM <= 76  |  MOD($CASENUM,3) = 0) (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE.

** Die F�lle f�r die vier Gruppen sind nun ungef�hr gleich besetzt, siehe dazu folgende Kreuztabelle.

CROSSTABS 
  /TABLES=GiftPurchase BY Reputation 
  /FORMAT=AVALUE TABLES 
  /CELLS=COUNT 
  /COUNT ROUND CELL.

***  --> Fallzahlen f�r Geschenkekauf angleichen abgeschlossen.

*** 2) Faktoreanalyse f�r die Items Kaufbereitschaft durchf�hren.

FACTOR 
  /VARIABLES WTPM_1 WTPM_2 WTPM_3 
  /MISSING LISTWISE 
  /ANALYSIS WTPM_1 WTPM_2 WTPM_3 
  /PRINT INITIAL CORRELATION EXTRACTION 
  /PLOT EIGEN 
  /CRITERIA MINEIGEN(1) ITERATE(25) 
  /EXTRACTION PAF 
  /ROTATION NOROTATE 
  /SAVE REG(ALL) 
  /METHOD=CORRELATION.
EXECUTE.

* Ergebnisse:
   - Die Items korrelieren unter einander wie erwartet sehr stark (siehe Tabelle "Correlation Matrix")
   - Die Kommunalit�t (siehe "Communalities") zeigen an dass ein Gro�teil der Varianz der einzelnen Items durch den latenten Faktor erkl�rt wird
   - An der "Total Variance Explained" bzw. dem "Screeplot" wird deutlich, dass wie erwartet lediglich ein einziger Faktor als latenter 
     Faktor der Items wirkt. Dieser latente Faktor sticht mit einer Eigenvalue von > 2 deutlich heuraus, w�hrend andere m�gliche Faktoren 
     lediglich Eigenvalues von <0,3 aufweisen Aus der Tabelle "Total Variance Explained" wird auch deutlich, dass die Items
     einen Gro�teil (>75%) der Varianz des latenten Faktors erkl�ren
   - Die Faktor Matrix unterstreicht das Ergebnis: die Items korrelieren stark mit dem latenten Faktor theoretisch (m�gliche Werite liegen zwischen
     -1 und 1, tats�chlich liegen die Korrelationen jedoch bei jedem Item bei >0,8, sind also jeweils sehr hoch)
   - Der neue Faktor wird als Variable FAC1_1 gespeichert. Hierbei ist anzumerken, dass Personen, die bei den WTPM-Items 
     sehr niedrige Werte angegeben haben einen niedrigen FAC1_1-Wert aufweisen (sie liegen am unteren Spektrum) und umgekehrt Personen 
     mit hohen Angaben einen hohen FAC1_1-Wert aufweisen. Man k�nnte diese Werte auf den Wertebereich [1,7] standardisieren, dies ist aber
     aus mathematischen Gr�nden nicht notwendig (der Informationsgehalt bleibt identisch).

* Die Variable FAC1_1 wird aus Gr�nden der Lesbarkeit in WTPM_latent umbenannt und bekommt ein neues Label.
RENAME VARIABLES (FAC1_1 = WTPM_latent).
EXECUTE.
VARIABLE LABELS
WTPM_latent 'Kaufbereitschaft-Faktor'.
EXECUTE.

*** --> Faktorenanalyse abgeschlossen.

*** 3) ANOVA durchf�hren
** Beschreibung des Modells:
* Zweifaktorielle Varianzanalyse
* Abh�ngige Variable: 
   - latenter Faktor aus der Faktorenanalyse (WTPM_latent, Skalenniveau: metrisch)
* Unabh�ngige Variablen: 
   - Haupteffekte:
   -- Geschenkekauf (GifPurchase, Skalenniveau bin�r/dichotom) - Faktorstufen: 1 (ja, Produkt als Geschenk gekauft); 0(nein, Produkt f�r eigenen Gebrauch gekauft)) 
   - Unternehmensreputation (Reputation, Skalenniveau bin�r/dichotom) - Faktorstufen: 1 (hohe Reputation); 0 (neutrale Reputation))
   - Interaktionseffekt:
   -- Interaktion zwischen Geschenkekauf und Unternehmensreputation
** Hypothesen: 
   - H1: Es besteht ein Effekt zwischen Geschenkekauf und dem Kaufverhalten
   -- Nullhypothese (H1_0): "Es besteht kein Effekt zwischen...." 
   - H2: Es besteht ein Effekt zwischen der Unternehmensreputation und dem Kaufverhalten
   -- Nullhypothese (H2_0): analog zu H1_0
   - H3: Es besteht ein Interaktionseffekt zwischen dem Geschenkekauf und der Unternehmensreputation auf das Kaufverhalten
   -- Nullhypothese (H2_0): analog zu H1_0
* Anmerkung zu den Hypothesen: unser Ziel ist es, die Nullhypothesen zu widerlegen. Eine Nullhypothese ist dann widerlegt, wenn 
  der jeweilige Effekt des Faktors (auf einem bestimmten Signifikanzniveau (alpha)) signifikant ist.

** Zun�chst: Pr�fung der Annahmen der ANOVA:
   - Annahme 1) Die abh�ngige Variable soll metrisch sein -> check
   - Annahme 2) Die unabh�ngigen Variablen bestehen aus zwei oder mehr unabh�ngigen Gruppen -> check
   - Annahme 3) Die Beobachtungen sind voneinander unabh�ngig -> Laborsetting, die Leute haben sich nicht gegenseitig beeinflusst -> check
   - Annahme 4) Es  gibt keine nennenswerten Ausrei�er in den Daten -> (s.u.)
   - Annahme 5) Die abh�ngige Variable ist Normalverteilt �ber alle Gruppen hinweg,
         also die Gruppen a) Geschenk 1, Reputation 1, b) Geschenk 0, Reputation 1, ... (4 Gruppen) -> (s.u.)
   - Annahme 6)  Es herrscht Varianzhomogenit�t f�r alle Gruppen der beiden unabh�ngigen Variablen. Dies Testen wir mit dem Levene-Test, 
     der uns unten bei der Berechnung der ANOVA mitgegeben wird (Hint: diese Annahme wird nicht verletzt).

* wir pr�fen 4) und 5): daf�r splitten wir den Datensatz nach GifPpurchase und Reputation.....
SORT CASES  BY GiftPurchase Reputation. 
SPLIT FILE SEPARATE BY GiftPurchase Reputation. 
* .... und schauen uns die deskriptiven Statistiken an.
EXAMINE VARIABLES=WTPM_latent BY GiftPurchase Reputation 
  /PLOT BOXPLOT NPPLOT 
  /COMPARE GROUPS 
  /STATISTICS DESCRIPTIVES 
  /CINTERVAL 95 
  /MISSING REPORT 
  /NOTOTAL.
** Ergebnis: 
   - Annahme 4) ist nicht verletzt
   - F�r die Annahme 5) sind im Output die Tabellen "Tests of Normality" relevant, und dabei Unter "Shapiro-Wilk" die Signifikanz ("Sig.)
      hier sollte die "Sig." des Shapiro-Wilk-Tests >0,05 sein, damit die abh�ngige Variable f�r diese Gruppe als normalverteilt angenommen
      werden kann. Es ist ersichtlich, dass bei der letzten Gruppe ("Kauf als Geschenk, Rep hoch") die Annahme 5 verletzt ist
   - Zwei L�sungm�glichkeiten bieten sich an: a) Transformation der abh�ngigen Variablen oder b) Verwendung eines Parameterfreien Tests
     (z.B. den H-Test, d.h. nicht mehr ANOVA). Ersteres ist relativ aufw�ndig und bei zweitem geht Aussagekraft verloren. Zudem ist ANOVA gegeb�ber einer
     Verletzung der Annahme 5) ziemlich robust und es handelt sich nur um eine Gruppe, daher schlage ich vor; mit der Analyse fortzufahren.
* Wir schalten dazu zun�chst den Split des Datensatzes wieder aus.
SPLIT FILE OFF.

** Nun rechnen wir die eigentliche ANOVA.
UNIANOVA WTPM_latent BY GiftPurchase Reputation 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /PLOT=PROFILE(GiftPurchase*Reputation) 
  /PRINT= OPOWER ETASQ HOMOGENEITY HOMOGENEITY 
  /CRITERIA=ALPHA(.05) 
  /DESIGN=GiftPurchase Reputation GiftPurchase*Reputation.
EXECUTE.

*  Wir pr�fen zun�chst die Ergebnisse des Levene-Tests
  - Das Ergebnis ist mit 0,142 nicht signifikant (siehe Tabelle "Levene's Test of ..."). Da der Test die Nullhypothese
    pr�ft, ob die Varianz der abh�ngigen Variable �ber die Gruppen hinweg gleich ist, und diese Nullhypothese
    nicht verworfen werden kann (unser p ist > 0,05), k�nnen wir schlussfolgern, dass Varianzhomogenit�t
     zwischen den Gruppen gegeben ist (und somit die Annahme 6 der ANOVA erf�llt ist)

* Nachdem die Annahmen gepr�ft wurden, k�nnen wir uns nun den eigentlichen Ergebnissen der ANOVA zuwenden:
   - Die letzte Spalte der Tabelle "Partial Eta Squared" der Tabelle "Tests of Between-Subjects Effects" gibt Auskunft
     �ber die St�rke der einzelnen Effekte. Hieraus wird ersichtlich, dass GiftPurchase den gr��ten Anteil an der Erkl�rung der
     Varianz der abh�ngigen Variablen hat (1,8%). Die Reputation der Variablen folgt mit 0,6% Varianzaufkl�rung. Die 
     Interaktion zwischen Geschenkekauf und der Reputation des Unternehmens ist mit 0% angegeben. Insgesamt
     werden 2,7% der Gesamtvarianz von WTPM_latent durch die unabh�ngigen Variablen erkl�rt (siehe 
     "R Squared" unterhalb der Tabelle "Tests of Between-Subjects Effects") 
   - Wird ein Signifikanzniveau von alpha = 0,05 festgelegt (Normalfall), ist kein Faktor signifikant (H1_0 kann also nicht 
     verworfen werden werden). Der Effekt der des Geschenkekaufs ist lediglich auf einem
     alpha- bzw. Signifikanzniveau von 0,10 signifikant (H1_0 kann also nur verworfen werden wenn ein alpha von 0,10 zugrunde 
     gelegt wird). Dieser Effekt kann daher als strittig angesehen werden (siehe f�r beide Signifikanzen die Spalte "Sig.",
     der daf�r Grundlegende F-Statistik steht links daneben). Die Reputation und der Interaktionseffekt zwischen Geschenkekauf und
     Unternehmensreputation k�nnen auf Grundlage dieses Modells unter keinen statistisch begr�ndbaren Umst�nden 
     als signifikant angesehen werden. Letztgenannte Tatsache verdeutlicht auch der Plot der Faktorstufenmittelwerte
     (siehe Grafik "Estimated Marginal Means of ....") - die Linien verlaufen nahezu parallel. Das bedeutet. dass 
     die Kaufbereitschaft gleicherma�en stark steigt wenn gleichzeitig ein Geschenkekauf und eine hohe Unternehmsreputation 
     vorliegt. (Wenn hier ein Interaktionseffekt herrschen w�rde, w�re das Gegenteil zu beobachten)
   - Anmerkung zum Wert "Intercept": dieser ist nicht weiter interessant; 
     er repr�sentiert die Sch�tzung des Werts der abh�ngigen Variable, wenn alle Faktoren auf 0 gesetzt sind.

*** --> ANOVA abgeschlossen.

***>>> ALT 4) Realibilit�tsanalyse f�r die Manipulationsvariablen durchf�hren.
** Wir pr�fen nun, wie verl�sslich die befragten Personen in Abh�ngigkeit deren "Geschenkekauf"-Szenario 
    tats�chlich auch danach einen passenden Wert f�r  Man_Gift_1  bzw.  Man_Gift_2  angegeben haben f�r 
    Wenn also das Szenario vorgab, dass die Person ein Geschenk gekauf hatte, erwarten wir, dass sie bei 
:   Man_Gift_2 sp�ter auch eher einen hohen Wert angegeben hat ("Bei meinem letzten Einkauf bei Belle et Beau 
    habe ich ein Produkt gekauft, das ich verschenkt habe.")
   - Hieraus ergeben zwei separate Analysen, einmal Geschenkekauf + Man_Gift_1 und einmal Geschenkekauf Man_Gift_2,
     da Man_Gift_1 fragt, ob "Sie ein Produkt f�r sich selber gekauft haben" und eben Man_Gift_2 ob es ein Geschenk war (Es 
     werden also zwei gegens�tzliche Dinge abgefragt.)
   - F�r die Pr�fung von Man_Gift_1 muss zudem eine neue Variable "hat Produkt f�r sich selber gekauft" eingef�hrt werden,
     die immer dann 1 ist, wenn GiftPurchase = 0 is (und umgekehrt). Der Grund daf�r liegt darin, dass sonst Chronbachs-Alpha keine sinnvollen 
     Ergebnisse liefern w�rde, denn es pr�ft intern "ist der Wert f�r Man_Gift_1 gr��er, wenn der Werr f�r Geschenkekauf gr��er ist?" 
     Man_Gift_1 ist aber ja inhaltlich immer eher kleiner, wenn Geschenkekauf 0 ist - es liegt also eine negative Korrelation
     vor, was bei der Berechnung des Chronbach-Alphas (welches ja positive Zusammenh�nge messen soll) zu invaliden
     Ergebnissen f�hren w�rde.

* Wir f�hren also zun�chst eine Variable ein, deren Werte jeweils gegenteilig (invers) zu denen von GiftPurchase sind.
RECODE GiftPurchase (1=0) (0=1) INTO GiftPurchase_inverse. 
VARIABLE LABELS  GiftPurchase_inverse 'GiftPurchase_inverse'. 
EXECUTE.

* Jetzt k�nnen wir Chronbachs-Alpha berechnen f�r die GiftPurchase_inverse und Man_Gift_1 berechnen.
RELIABILITY 
  /VARIABLES=GiftPurchase_inverse Man_Gift_1 
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.

* Der Wert ist mit rund 0,4 sehr niedrig, deutet also auf einen schwachen Zusammenhang hin.
* Ein �hnlich niedriger Wert ergibt sich f�r das Verh�ltnis von GiftPurchase und Man_Gift_2, bei der nun auch die 
  originale GiftPurchase-Variable verwendet werden kann. (F�r Argumentation siehe oben).
RELIABILITY 
  /VARIABLES=GiftPurchase Man_Gift_2 
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.

* Bessere Werte ergeben sich, wenn man die Man_Gift_*-Variablen nach 0 und 1 umkodiert. Hierdurch ergibt sich jeweils 
  die Interpretation "kann sich eher nicht erinnern" und "kann sich eher erinnern". Hierbei geht Information verloren, aber es 
  ergeben sich hohe C-Alpha-Werte.
* Das Vorgehen ist wie folgt: 
   - Die Variable Geschenkekauf hat nur zwei Auspr�gungen (1 und 0), w�hrend Man_Gift_* jeweils 7 Stufen haben. Chronbachs-Alpha
     l�sst sich jedoch nur sinnvoll auf Variablenmengen anwenden, die dieselbe Anzahl an Auspr�gungen haben. Wir
     m�ssen also die Man_Gift_* Variablen in 1 und 0 umcodieren bzw. neue Variablen erstellen 
   - Folgendes Schema empfielt sich: Die Werte
     1-3 bekommen den Wert 0 und die Werte 5-7 bekommen den Wert 1 zugewiesen. Die Auspr�gung 4 wird als neutraler
     Wert als "Missing" codiert. Hierdurch fallen lediglich wenige F�lle weg
   - Anmerkung: implizit wird durch das Vorhandensein von bin�ren Variablen von SPSS nicht Chronbachs-Alpha herangezogen
     sondern eine seiner Vorl�ufer-Formeln (Kuder-Richardson-Formel). Dies ist jedoch f�r den Benutzer von SPSS nicht ersichtlich.
* Wir kodieren also die Man_Gift_*-Variablen wie beschrieben in neue Variablen (Man_Gift_*_binary).
RECODE Man_Gift_1 Man_Gift_2 (4=SYSMIS) (1 thru 3=0) (5 thru 7=1) INTO Man_Gift_1_binary Man_Gift_2_binary. 
VARIABLE LABELS  Man_Gift_1_binary 'Man_Gift_1_binary' /Man_Gift_2_binary 'Man_Gift_2_binary'. 
EXECUTE.

* Nun k�nnen wir die Realibilit�tsberechnungen durchf�hren.
RELIABILITY 
  /VARIABLES=GiftPurchase_inverse Man_Gift_1_binary 
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.

RELIABILITY 
  /VARIABLES=GiftPurchase Man_Gift_2_binary 
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.
* -> Ergebnis: mit jeweils rund 0,8 ergeben sich gute Realibilit�tswerte.

** Dasselbe Vorgehen f�hren wir nun noch f�r die Unternehmensreputation durch.
* bei der Reputation sind allerdings die inhaltlichen Beschreibungen umgekehrt zu denen bei GiftPurchase, 
   d.h. bei Man_Rep_1 wird nach einer hohen - und bei Man_Rep_2 nach einer m��igen Reputation gefragt. Dies
   muss sich in den Berechnungen wiederspiegeln (siehe Funktion RELIABILITY).

RECODE Reputation (1=0) (0=1) INTO Reputation_inverse. 
VARIABLE LABELS  Reputation_inverse 'Reputation_inverse'. 
EXECUTE.

RECODE Man_Rep_1 Man_Rep_2 (4=SYSMIS) (1 thru 3=0) (5 thru 7=1) INTO Man_Rep_1_binary Man_Rep_2_binary. 
VARIABLE LABELS  Man_Rep_1_binary 'Man_Rep_1_binary' /Man_Rep_2_binary 'Man_Rep_2_binary'. 
EXECUTE.

RELIABILITY 
  /VARIABLES=Reputation_inverse Man_Rep_2_binary 
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.

RELIABILITY 
  /VARIABLES=Reputation Man_Rep_1_binary 
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.

* -> Ergebnis: auch hier ergeben sich mit jeweils rund 0,8+/- 0,025 gute Realibilit�tswerte.

***>>> ALT --> Realibilit�tsanalyse abgeschlossen.

***>>> NEU 4) Realibilit�tsanalyse f�r die Manipulationsvariablen durchf�hren.
** t-test f�r die beiden Geschenk-Manipulationsvariablen.
T-TEST GROUPS=GiftPurchase(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=Man_Gift_1 Man_Gift_2 
  /CRITERIA=CI(.95).
** Ergebnis: Differenzen hochsignifikant (siehe Tabelle "Group Statistics" Spalte "Mean" und die Tabelle darunter Spalte "Sig. (2-tailed)")
   d.h. wurden die Personen der Gruppe "Produkt f�r Eigenbedarf" zugeordnet, haben sie sp�ter im Mittel einen deutlich h�heren Wert (5,91 
   vs. 2,05) bei "Kauf f�r pers�nlichen Gebrauch" angegeben bzw. einen deutlich niedrigeren (2,82 vs. 6,45) bei "Geschenkekauf" -> also 
   beides wie erwartet. Manipulationscheck hat funktioniert.

** Nun f�r Reputation.
T-TEST GROUPS=Reputation(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=Man_Rep_1 Man_Rep_2 
  /CRITERIA=CI(.95).
** Ergebnis: analog zu Geschenkekauf (siehe Ergebnis und Interpretation bei Geschenkekauf).
***>>> NEU  --> Realibilit�tsanalyse abgeschlossen.

*** 5)  Berechnung und Visualisierung deskriptiver Statistiken des Samples (Alter, Geschlecht, Bildung).

**Grafiken
* Altersverteilung.
GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Age MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE. 
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: Age=col(source(s), name("Age")) 
  GUIDE: axis(dim(1), label("Age")) 
  GUIDE: axis(dim(2), label("Frequency")) 
  ELEMENT: interval(position(summary.count(bin.rect(Age))), shape.interior(shape.square)) 
END GPL.

* Verteilung Geschlechter.
GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Gender COUNT()[name="COUNT"] MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE. 
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: Gender=col(source(s), name("Gender"), unit.category()) 
  DATA: COUNT=col(source(s), name("COUNT")) 
  GUIDE: axis(dim(1), label("Gender")) 
  GUIDE: axis(dim(2), label("Count")) 
  SCALE: linear(dim(2), include(0)) 
  ELEMENT: interval(position(Gender*COUNT), shape.interior(shape.square)) 
END GPL.

* Verteilung Bildung.
GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Education COUNT()[name="COUNT"] MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE. 
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: Education=col(source(s), name("Education"), unit.category()) 
  DATA: COUNT=col(source(s), name("COUNT")) 
  GUIDE: axis(dim(1), label("Education")) 
  GUIDE: axis(dim(2), label("Count")) 
  SCALE: linear(dim(2), include(0)) 
  ELEMENT: interval(position(Education*COUNT), shape.interior(shape.square)) 
END GPL.

* Deskriptive Statistiken.
DESCRIPTIVES VARIABLES=Age Gender Education 
  /STATISTICS=MEAN SUM STDDEV VARIANCE RANGE MIN MAX SEMEAN.

* H�ufigkeitstabellen.
FREQUENCIES VARIABLES=Age Gender Education 
  /STATISTICS=STDDEV VARIANCE RANGE MINIMUM MAXIMUM SEMEAN MEAN MEDIAN MODE SUM 
  /ORDER=ANALYSIS.

*** --> Berechnung deskriptiver Statistiken abgeschlossen.
