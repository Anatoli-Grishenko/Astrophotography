#/bin/bash
ROOT=$(pwd)
IMAGES=$ROOT/Imaging
TEXTS=$ROOT/Reports
INDEX=$IMAGES/Original
cd $INDEX
FILES=$(ls *.jpg | sort)
cd -

OUTPUT=$TEXTS/collection.tex
PREAMBLE='\newpage\pagecolor{black}\color{white}'
#PREAMBLE='\newpage\begin{longtable}{p{\textwidth}}\pagecolor{black}\color{white}'
CLOSING=''
PREIMAGE='\includegraphics[width=\textwidth]{'$IMAGES'/Original/'
POSTIMAGE='}'
PRECAPTION='\section{'
#PRECAPTION=' \newline\vspace{-1cm}{\color{white}\bf \Large  '
POSTCAPTION='}'
echo $PREAMBLE > $OUTPUT
for IMG in $FILES
do
	IMGSIMPLE=$(echo $IMG | sed s":\.jpg::")
	IMGNAME=$(echo $IMG |sed s':\.jpg::' | sed s":\_: :g")
	IMGNAMEREAL=$(echo $IMG |sed s':\_:\\_:g' )
	TEXFILE=$IMAGES'/Annotated/'$IMGSIMPLE'.tex'
	PRETEX='{\footnotesize\color{white}'
	POSTEX='}'
	echo "Found ""$IMGNAME"
	
	#
	# OSC Image with caption
	#
 echo $PRECAPTION$IMGNAME$POSTCAPTION>>$OUTPUT 
 echo $PREIMAGE$IMG$POSTIMAGE >> $OUTPUT
 
 #
 # Description
 #
 echo $PRETEX >> $OUTPUT
 if [ -f $TEXFILE ]
 then
 		echo "Found description"
 		cat $TEXFILE >> $OUTPUT
 else
 		echo "Missing description"
 		echo "" >> $OUTPUT
 fi
 echo $POSTEX >> $OUTPUT
done
echo $CLOSING >> $OUTPUT
cd -
