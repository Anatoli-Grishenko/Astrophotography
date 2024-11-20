#/bin/bash
ROOT=$(pwd)
IMAGES=$ROOT/Imaging
TEXTS=$ROOT/Reports
MARKDS=$ROOT/Markdown
INDEX=$IMAGES/Original
cd $INDEX
FILES=$(ls *.jpg | sort)
cd -

OUTPUT=$TEXTS/collection.tex
OUTPUTMD=$MARKDS/index.md
PREAMBLE='\newpage\pagecolor{black}\color{white}'
#PREAMBLE='\newpage\begin{longtable}{p{\textwidth}}\pagecolor{black}\color{white}'
CLOSING=''
PREIMAGE='\includegraphics[width=\textwidth]{'$IMAGES'/'
PREIMAGELT='\includegraphics[width=0.75\textwidth]{'$IMAGES'/'
PREIMAGETINY='\includegraphics[height=4cm]{'$IMAGES'/'
POSTIMAGE='}'
PREHEADER='\ \\\section{'
#PREHEADER=' \newline\vspace{-1cm}{\color{white}\bf \Large  '
POSTHEADER='}'
echo $PREAMBLE > $OUTPUT
echo "# Targets" > $OUTPUTMD 
for IMG in $FILES
do
	IMGSIMPLE=$(echo $IMG | sed s":\.jpg::")
	IMGNAME=$(echo $IMG |sed s':\.jpg::' | sed s":\_: :g")
	IMGNAMEMD=$(echo $IMG |sed s':\.jpg::' | sed s":_: :g")
	IMGNAMEREAL=$(echo $IMG |sed s':\_:\\_:g' )
	TEXFILE=$IMAGES'/Annotated/'$IMGSIMPLE'.tex'
	LINKFILE=$IMAGES'/Annotated/'$IMGSIMPLE'_Link.txt'
	FILEMD=$MARKDS/$IMGSIMPLE".md"
	PRETEX='{\footnotesize\color{white}'
	POSTEX='}\ \\'
	printf "\nFound image $IMGNAME\n"
	
	#
	# OSC Image with caption
	#
 echo $PREHEADER$IMGNAME$POSTHEADER>>$OUTPUT 
 echo $PREIMAGE'Original/'$IMG$POSTIMAGE >> $OUTPUT
 echo "# "$IMGNAMEMD > $FILEMD
# echo "* "$IMGNAMEMD >> $OUTPUTMD
 echo "* ["$IMGNAMEMD"]("$FILEMD")" >> $OUTPUTMD
  echo "!""[IMG]("$INDEX/$IMG")">> $FILEMD
  printf "\n!""[IMG]("$INDEX/$IMG" =256x)\n">> $OUTPUTMD
 echo "" >> $OUTPUTMD
  echo "">> $FILEMD
 #
 # Description
 #
 echo $PRETEX >> $OUTPUT
 if [ -f $TEXFILE ]
 then
 		printf "\tFound description\n"
 		cat $TEXFILE >> $OUTPUT
 		printf "$(cat $TEXFILE)" >> $OUTPUTMD
 		cat $TEXFILE >> $FILEMD
fi
 		echo "" >> $OUTPUT
 		echo "" >> $OUTPUTMD
 		echo "" >> $FILEMD

 if [ -f $LINKFILE ]
 then
 		printf "\tFound link\n"
 		printf "[Read more]("$(cat $LINKFILE)")\n" >> $FILEMD
fi
 		echo "" >> $OUTPUT
 		echo "" >> $OUTPUTMD
 		echo "" >> $FILEMD

 echo $POSTEX >> $OUTPUT
 
 #
 # Grayscale
 #
 if [ -f $IMAGES/Grayscale/$IMG ]
 then
 		printf "\tFound GRAYSCALE version\n"
 echo $PREIMAGE'Grayscale/'$IMG$POSTIMAGE >> $OUTPUT
  echo "!""[IMG]("$IMAGES/Grayscale/$IMG")">> $FILEMD
		  echo "">> $FILEMD
 fi
 #
 # Anntations
 #
 	echo '\begin{center}' >> $OUTPUT
  if [ -f $IMAGES/Annotated/$IMGSIMPLE'_Annotated.jpg' ]
  then
  	echo " \ \newpage" >>$OUTPUT
  	 echo $PREIMAGELT'Annotated/'$IMGSIMPLE'_Annotated.jpg'$POSTIMAGE >> $OUTPUT
  	 echo "" >> $OUTPUT
		  echo "!""[IMG]("$IMAGES/Annotated/$IMGSIMPLE"_Annotated.jpg)">> $FILEMD
		  echo "">> $FILEMD
 fi
		  printf "| Globe | Close | Very close |\n">> $FILEMD
		  printf "| ----- | ----- | ----- |\n">> $FILEMD
  	
	  if [ -f $IMAGES/Annotated/$IMGSIMPLE'_Hist.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Hist'$POSTIMAGE >> $OUTPUT
		 fi
		 
	  if [ -f $IMAGES/Annotated/$IMGSIMPLE'_Globe.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Globe.jpg'$POSTIMAGE >> $OUTPUT
		  printf "|!""[IMG]("$IMAGES/Annotated/$IMGSIMPLE"_Globe.jpg) |">> $FILEMD
  	 
		 fi
 	  if [ -f $IMAGES/Annotated/$IMGSIMPLE'_Close.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Close.jpg'$POSTIMAGE >> $OUTPUT
		  printf "!""[IMG]("$IMAGES/Annotated/$IMGSIMPLE"_Close.jpg) |">> $FILEMD
		 fi
		 
 	  if [ -f $IMAGES/Annotated/$IMGSIMPLE'_Closer.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Closer.jpg'$POSTIMAGE >> $OUTPUT
		  printf "!""[IMG]("$IMAGES/Annotated/$IMGSIMPLE"_Closer.jpg) |">> $FILEMD
  	 
		 fi
 	echo '\end{center}' >> $OUTPUT
 
done
echo $CLOSING >> $OUTPUT
cd -
