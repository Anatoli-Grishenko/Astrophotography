#/bin/bash
ROOT=..
EXEC=./bin/
IMAGES=$ROOT/Imaging/
TEXTS=$ROOT/Reports/
MARKDS=$ROOT/Markdown/
INDEX=$IMAGES/Original
cd $EXEC$INDEX
FILES=$(ls *.jpg | sort)
cd -

OUTPUT=$EXEC$TEXTS/collection.tex
OUTPUTMD=$EXEC$MARKDS/index.md
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
 echo "# "$IMGNAMEMD > $EXEC$FILEMD
# echo "* "$IMGNAMEMD >> $OUTPUTMD
 echo "* ["$IMGNAMEMD"]("$FILEMD")" >> $OUTPUTMD
  echo "!""[IMG]("$INDEX/$IMG")">> $EXEC$FILEMD
  printf "\n!""[IMG](../Imaging/Original/"$IMG" =256x)\n">> $OUTPUTMD
 echo "" >> $OUTPUTMD
  echo "">> $EXEC$FILEMD
 #
 # Description
 #
 echo $PRETEX >> $OUTPUT
 if [ -f $EXEC$TEXFILE ]
 then
 		printf "\tFound description\n"
 		cat $EXEC$TEXFILE >> $OUTPUT
 		printf "$(cat $EXEC$TEXFILE)" >> $OUTPUTMD
 		cat $EXEC$TEXFILE >> $EXEC$FILEMD
fi
 		echo "" >> $OUTPUT
 		echo "" >> $OUTPUTMD
 		echo "" >> $EXEC$FILEMD

 if [ -f $EXEC$LINKFILE ]
 then
 		printf "\tFound link\n"
 		printf "[Read more]("$(cat $EXEC$LINKFILE)")\n" >> $EXEC$FILEMD
fi
 		echo "" >> $OUTPUT
 		echo "" >> $OUTPUTMD
 		echo "" >> $EXEC$FILEMD

 echo $POSTEX >> $OUTPUT
 
 #
 # Grayscale
 #
 if [ -f $EXEC$IMAGES/Grayscale/$IMG ]
 then
 		printf "\tFound GRAYSCALE version\n"
 echo $PREIMAGE'Grayscale/'$IMG$POSTIMAGE >> $OUTPUT
  echo "!""[IMG]("$IMAGES/Grayscale/$IMG")">> $EXEC$FILEMD
		  echo "">> $EXEC$FILEMD
 fi
 #
 # Anntations
 #
 	echo '\begin{center}' >> $OUTPUT
  if [ -f $EXEC$IMAGES/Annotated/$IMGSIMPLE'_Annotated.jpg' ]
  then
  	echo " \ \newpage" >>$OUTPUT
  	 echo $PREIMAGELT'Annotated/'$IMGSIMPLE'_Annotated.jpg'$POSTIMAGE >> $OUTPUT
  	 echo "" >> $OUTPUT
		  echo "!""[IMG]("$IMAGES/Annotated/$IMGSIMPLE"_Annotated.jpg)">> $EXEC$FILEMD
		  echo "">> $EXEC$FILEMD
 fi
		  printf "| Globe | Close | Very close |\n">> $EXEC$FILEMD
		  printf "| ----- | ----- | ----- |\n">> $EXEC$FILEMD
  	
	  if [ -f $EXEC$IMAGES/Annotated/$IMGSIMPLE'_Hist.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Hist'$POSTIMAGE >> $OUTPUT
		 fi
		 
	  if [ -f $EXEC$IMAGES/Annotated/$IMGSIMPLE'_Globe.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Globe.jpg'$POSTIMAGE >> $OUTPUT
		  printf "|!""[IMG]("$IMAGES/Annotated/$IMGSIMPLE"_Globe.jpg) |">> $EXEC$FILEMD
  	 
		 fi
 	  if [ -f $EXEC$IMAGES/Annotated/$IMGSIMPLE'_Close.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Close.jpg'$POSTIMAGE >> $OUTPUT
		  printf "!""[IMG]("$IMAGES/Annotated/$IMGSIMPLE"_Close.jpg) |">> $EXEC$FILEMD
		 fi
		 
 	  if [ -f $EXEC$IMAGES/Annotated/$IMGSIMPLE'_Closer.jpg' ]
	  then
	  	 echo $PREIMAGETINY'Annotated/'$IMGSIMPLE'_Closer.jpg'$POSTIMAGE >> $OUTPUT
		  printf "!""[IMG]("$IMAGES/Annotated/$IMGSIMPLE"_Closer.jpg) |">> $EXEC$FILEMD
  	 
		 fi
 	echo '\end{center}' >> $OUTPUT
 
done
echo $CLOSING >> $OUTPUT
cd -
