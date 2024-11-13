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
PREIMAGE='\includegraphics[width=\textwidth]{'$IMAGES'/'
PREIMAGELT='\includegraphics[width=0.75\textwidth]{'$IMAGES'/'
PREIMAGETINY='\includegraphics[height=5cm]{'$IMAGES'/'
POSTIMAGE='}'
PREHEADER='\section{'
#PREHEADER=' \newline\vspace{-1cm}{\color{white}\bf \Large  '
POSTHEADER='}'
echo $PREAMBLE > $OUTPUT
for IMG in $FILES
do
	IMGSIMPLE=$(echo $IMG | sed s":\.jpg::")
	IMGNAME=$(echo $IMG |sed s':\.jpg::' | sed s":\_: :g")
	IMGNAMEREAL=$(echo $IMG |sed s':\_:\\_:g' )
	TEXFILE=$IMAGES'/Annotated/'$IMGSIMPLE'.tex'
	PRETEX='{\footnotesize\color{white}'
	POSTEX='}\ \\'
	printf "\nFound image $IMGNAME\n"
	
	#
	# OSC Image with caption
	#
 echo $PREHEADER$IMGNAME$POSTHEADER>>$OUTPUT 
 echo $PREIMAGE'Original/'$IMG$POSTIMAGE >> $OUTPUT
 
 #
 # Description
 #
 echo $PRETEX >> $OUTPUT
 if [ -f $TEXFILE ]
 then
 		printf "\tFound latex description\n"
 		cat $TEXFILE >> $OUTPUT
 		else
 		echo "" >> $OUTPUT
 fi
 echo $POSTEX >> $OUTPUT
 
 #
 # Grayscale
 #
 if [ -f $IMAGES/Grayscale/$IMG ]
 then
 		printf "\tFound GRAYSCALE version\n"
 echo $PREIMAGE'Grayscale/'$IMG$POSTIMAGE >> $OUTPUT
 fi
 #
 # Anntations
 #
 	echo '\begin{center}' >> $OUTPUT
  if [ -f $IMAGES/Annotated/$IMGSIMPLE'_Annotated.jpg' ]
  then
  	echo " \ \newpage" >>$OUTPUT
  	 echo $PREIMAGELT'Annotated/'$IMGSIMPLE'_Annotated'$POSTIMAGE >> $OUTPUT
  	 echo "" >> $OUTPUT
  	fi
  	
	  if [ -f $IMAGES/Annotated/$IMGSIMPLE'_Globe.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Globe'$POSTIMAGE >> $OUTPUT
  	 
		 fi
 	  if [ -f $IMAGES/Annotated/$IMGSIMPLE'_Close.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Close.jpg'$POSTIMAGE >> $OUTPUT
  	 
		 fi
 	  if [ -f $IMAGES/Annotated/$IMGSIMPLE'_Closer.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Closer.jpg'$POSTIMAGE >> $OUTPUT
  	 
		 fi
 	echo '\end{center}' >> $OUTPUT
 
done
echo $CLOSING >> $OUTPUT
cd -
