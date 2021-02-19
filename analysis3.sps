************************************************
***** Dateneinlese und -aufbereitung.******
************************************************.

*********************************************
Spreadsheet einlesen (Pfad beachten).
*********************************************.
GET DATA /TYPE=XLS
  /FILE='C:\Users\User\Rohdaten\VorbereitungAuswertung_Aufgearbeitet.xls' 
  /SHEET=name 'Tabelle1' 
  /CELLRANGE=full 
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767. 
EXECUTE. 


**********************
Variablen codieren.
**********************.
***********************************************************************************
-> Nachkommastellen f�r die Zeitvariablen von 0 auf 2 setzen (Decimals).
***********************************************************************************.
format 
StdBuecherTag 
StdZeitschriftenTag 
StdZeitungenTag 
StdRadioTag 
StdFernsehenTag 
StdSmartphoneTag 
StdTabletTag 
StdLaptopPCTag
StdFacebookTag 
StdYoutubeTag 
StdInstagramTag 
StdSnapchatTag
(f8.2).

***************************
-> Wertelabels (Values).
***************************.
value labels 
InfosMusikAusBuechern
InfosPolitikWeltAusBuechern
InfosModeSchoenheitAusBuechern
InfosSportErnaehrungAusBuechern
InfosBekanntePersonenAusBuechern
InfosMusikAusZeitschriften
InfosPolitikWeltAusZeitschriften
InfosModeSchoenheitAusZeitschriften
InfosSportErnaehrungAusZeitschriften
InfosBekanntePersonenAusZeitschriften
InfosMusikAusZeitungen
InfosPolitikWeltAusZeitungen
InfosModeSchoenheitAusZeitungen
InfosSportErnaehrungAusZeitungen
InfosBekanntePersonenAusZeitungen
InfosMusikAusDemRadio
InfosPolitikWeltAusDemRadio
InfosModeSchoenheitAusDemRadio
InfosSportErnaehrungAusDemRadio
InfosBekanntePersonenAusDemRadio
InfosMusikAusDemFernsehen
InfosPolitikWeltAusDemFernsehen
InfosModeSchoenheitAusDemFernsehen
InfosSportErnaehrungAusDemFernsehen
InfosBekanntePersonenAusDemFernsehen
InfosMusikVonFacebook
InfosPolitikWeltVonFacebook
InfosModeSchoenheitVonFacebook
InfosSportErnaehrungVonFacebook
InfosBekanntePersonenVonFacebook
InfosMusikVonInstagram
InfosPolitikWeltVonInstagram
InfosModeSchoenheitVonInstagram
InfosSportErnaehrungVonInstagram
InfosBekanntePersonenVonInstagram
InfosMusikVonYoutube
InfosPolitikWeltVonYoutube
InfosModeSchoenheitVonYoutube
InfosSportErnaehrungVonYoutube
InfosBekanntePersonenVonYoutube
InfosMusikVonSnapchat
InfosPolitikWeltVonSnapchat
InfosModeSchoenheitVonSnapchat
InfosSportErnaehrungVonSnapchat
InfosBekanntePersonenVonSnapchat
WiederholtAehnlicheThemenWerdenAngezeigt
BegriffFilterblaseEchokammerSchonmalGehoert 
0 'Nein' 1 'Ja'.

value labels 
HaeufigkeitSozMedien_InhalteLiken
HaeufigkeitSozMedien_InhalteTeilen
HaeufigkeitSozMedien_InhalteKommentieren
HaeufigkeitSozMedien_BilderVideoHochladen
HaeufigkeitSozMedien__AnDiskussionenTeilnehmen
HaeufigkeitSozMedien_AustauschInGruppenMitGleichgesinnten
HaeufigkeitSozMedien_AlgorithmischVorgeschlageneSeitenOderPersonenFolgen
0 'nie'  1 'selten'  2 'weniger h�ufig' 3 'h�ufig' 4 'sehr h�ufig'.

value labels 
EinschaetzungHaeufigkeitEigeneMeinungWirdVonVielenAnderenBestaetigt
UninteressanteInhalteWerdenVorgeschlagen
1 'selten'  2 'weniger h�ufig' 3 'h�ufig' 4 'sehr h�ufig'.

value labels 
NutztHaeufigerBeiYoutube_NewsfeedVsSuchfunktion
NutztHaeufigerBeiInstagram_NewsfeedVsSuchfunktion
NutztHaeufigerBeiSnapchat_NewsfeedVsSuchfunktion
1 'Newsfeed' 2 'Suchfunktion'.


***********************************
->  Fehlende Werte (Missing).
***********************************.
missing values 
StdBuecherTag to BegriffFilterblaseEchokammerSchonmalGehoert
(-98,-99).

******************************************
->   Variablenbeschreibungen (Label).
*******************************************.
* Fragenogen-id.
variable labels 
FragebogenNr 'id'.

* Frage 4.
variable labels 
StdBuecherTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende Medien?'
/StdZeitschriftenTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende Medien?'
/StdZeitungenTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende Medien?'
/StdRadioTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende Medien?'
/StdFernsehenTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende Medien?'
/StdSmartphoneTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende Medien?'
/StdTabletTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende Medien?'
/StdLaptopPCTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende Medien?'.

* Frage 4.
variable labels
StdFacebookTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende sozialen Medien?'
/StdYoutubeTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende sozialen Medien?'
/StdInstagramTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende sozialen Medien?'
/StdSnapchatTag 'Wie viele Stunden nutzt du durchschnittlich t�glich folgende sozialen Medien?'.

* Frage 7.
variable labels 
InfosMusikAusBuechern 'Wo informierst du dich �ber folgende Themen?'
/InfosPolitikWeltAusBuechern 'Wo informierst du dich �ber folgende Themen?'
/InfosModeSchoenheitAusBuechern 'Wo informierst du dich �ber folgende Themen?'
/InfosSportErnaehrungAusBuechern 'Wo informierst du dich �ber folgende Themen?'
/InfosBekanntePersonenAusBuechern 'Wo informierst du dich �ber folgende Themen?'
/InfosMusikAusZeitschriften 'Wo informierst du dich �ber folgende Themen?'
/InfosPolitikWeltAusZeitschriften 'Wo informierst du dich �ber folgende Themen?'
/InfosModeSchoenheitAusZeitschriften 'Wo informierst du dich �ber folgende Themen?'
/InfosSportErnaehrungAusZeitschriften 'Wo informierst du dich �ber folgende Themen?'
/InfosBekanntePersonenAusZeitschriften 'Wo informierst du dich �ber folgende Themen?'
/InfosMusikAusZeitungen 'Wo informierst du dich �ber folgende Themen?'
/InfosPolitikWeltAusZeitungen 'Wo informierst du dich �ber folgende Themen?'
/InfosModeSchoenheitAusZeitungen 'Wo informierst du dich �ber folgende Themen?'
/InfosSportErnaehrungAusZeitungen 'Wo informierst du dich �ber folgende Themen?'
/InfosBekanntePersonenAusZeitungen 'Wo informierst du dich �ber folgende Themen?'
/InfosMusikAusDemRadio 'Wo informierst du dich �ber folgende Themen?'
/InfosPolitikWeltAusDemRadio 'Wo informierst du dich �ber folgende Themen?'
/InfosModeSchoenheitAusDemRadio 'Wo informierst du dich �ber folgende Themen?'
/InfosSportErnaehrungAusDemRadio 'Wo informierst du dich �ber folgende Themen?'
/InfosBekanntePersonenAusDemRadio 'Wo informierst du dich �ber folgende Themen?'
/InfosMusikAusDemFernsehen 'Wo informierst du dich �ber folgende Themen?'
/InfosPolitikWeltAusDemFernsehen 'Wo informierst du dich �ber folgende Themen?'
/InfosModeSchoenheitAusDemFernsehen 'Wo informierst du dich �ber folgende Themen?'
/InfosSportErnaehrungAusDemFernsehen 'Wo informierst du dich �ber folgende Themen?'
/InfosBekanntePersonenAusDemFernsehen 'Wo informierst du dich �ber folgende Themen?'
/InfosMusikVonFacebook 'Wo informierst du dich �ber folgende Themen?'
/InfosPolitikWeltVonFacebook 'Wo informierst du dich �ber folgende Themen?'
/InfosModeSchoenheitVonFacebook 'Wo informierst du dich �ber folgende Themen?'
/InfosSportErnaehrungVonFacebook 'Wo informierst du dich �ber folgende Themen?'
/InfosBekanntePersonenVonFacebook 'Wo informierst du dich �ber folgende Themen?'
/InfosMusikVonInstagram 'Wo informierst du dich �ber folgende Themen?'
/InfosPolitikWeltVonInstagram 'Wo informierst du dich �ber folgende Themen?'
/InfosModeSchoenheitVonInstagram 'Wo informierst du dich �ber folgende Themen?'
/InfosSportErnaehrungVonInstagram 'Wo informierst du dich �ber folgende Themen?'
/InfosBekanntePersonenVonInstagram 'Wo informierst du dich �ber folgende Themen?'
/InfosMusikVonYoutube 'Wo informierst du dich �ber folgende Themen?'
/InfosPolitikWeltVonYoutube 'Wo informierst du dich �ber folgende Themen?'
/InfosModeSchoenheitVonYoutube 'Wo informierst du dich �ber folgende Themen?'
/InfosSportErnaehrungVonYoutube 'Wo informierst du dich �ber folgende Themen?'
/InfosBekanntePersonenVonYoutube 'Wo informierst du dich �ber folgende Themen?'
/InfosMusikVonSnapchat 'Wo informierst du dich �ber folgende Themen?'
/InfosPolitikWeltVonSnapchat 'Wo informierst du dich �ber folgende Themen?'
/InfosModeSchoenheitVonSnapchat 'Wo informierst du dich �ber folgende Themen?'
/InfosSportErnaehrungVonSnapchat 'Wo informierst du dich �ber folgende Themen?'
/InfosBekanntePersonenVonSnapchat 'Wo informierst du dich �ber folgende Themen?'.

*Frage 9.
variable labels
HaeufigkeitSozMedien_InhalteLiken 'Wie h�ufig beteiligst du dich bei den sozialen Medien?'
/HaeufigkeitSozMedien_InhalteTeilen 'Wie h�ufig beteiligst du dich bei den sozialen Medien?'
/HaeufigkeitSozMedien_InhalteKommentieren 'Wie h�ufig beteiligst du dich bei den sozialen Medien?'
/HaeufigkeitSozMedien_BilderVideoHochladen 'Wie h�ufig beteiligst du dich bei den sozialen Medien?'
/HaeufigkeitSozMedien__AnDiskussionenTeilnehmen 'Wie h�ufig beteiligst du dich bei den sozialen Medien?'
/HaeufigkeitSozMedien_AustauschInGruppenMitGleichgesinnten 'Wie h�ufig beteiligst du dich bei den sozialen Medien?'
/HaeufigkeitSozMedien_AlgorithmischVorgeschlageneSeitenOderPerson  'Wie h�ufig beteiligst du dich bei den sozialen Medien?'.

*Frage 13.
variable labels
EinschaetzungHaeufigkeitEigeneMeinungWirdVonVielenAnderenBestaet 'Denkst du, dass deine Meinung zu dem Thema von vielen Anderen best�tigt wird oder nicht?'.

*Frage 19.
variable labels
NutztHaeufigerBeiYoutube_NewsfeedVsSuchfunktion 'Bitte kreise ein was du jeweils h�ufiger nutzt bei den sozialen Medien'
NutztHaeufigerBeiInstagram_NewsfeedVsSuchfunktion 'Bitte kreise ein was du jeweils h�ufiger nutzt bei den sozialen Medien'
NutztHaeufigerBeiSnapchat_NewsfeedVsSuchfunktion 'Bitte kreise ein was du jeweils h�ufiger nutzt bei den sozialen Medien'.

* Frage 20.
variable labels
WiederholtAehnlicheThemenWerdenAngezeigt 'Werden dir immer wieder �hnliche Themen und Personen bei den sozialen Medien vorgeschlagen?'.

* Frage 23.
variable labels
UninteressanteInhalteWerdenVorgeschlagen 'Wie oft werden dir Informationen/Seiten/Personen vorgeschlagen, die dich nicht interessieren?.'.

* Frage 27.
variable labels
BegriffFilterblaseEchokammerSchonmalGehoert 'Hast du die Begriffe Filterblase und Echokammer schon einmal geh�rt?'.

SAVE OUTFILE = 'C:\Users\User\Desktop\Abgabe\AufbereiteteDaten\AufbereiteterSPSSDatensatz.sav'.
******************************************************************
***** Dateneinlese und -aufbereitung abgeschlossen ******
******************************************************************.
