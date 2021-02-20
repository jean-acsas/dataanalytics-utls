## Some helpful commands as well as legacy scripts I of previous data analysis projects (see attachments)

### SPSS

#### Working with files

##### Reading files

Example: reading in a csv, where
- the delimiter is ","
- each entry is surrounded by double quotes.
- Ignore the first row/case (variable names) start at case 2.
- We have three variables, which we will name v1-v3, giving them a partical format each.
- Bring the newly created data set (DataSet1) to the front.

```SPSS
GET DATA
  /TYPE=TXT
  /FILE="C:\path\to\theFile.csv"
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
CACHE.
EXECUTE.
DATASET NAME DataSet1 WINDOW=FRONT.
```

#### Writing files

Save a file as a sav.
```SPSS
SAVE OUTFILE='C:\path\to\theFile.sav'
  /COMPRESSED.
EXECUTE.
```
