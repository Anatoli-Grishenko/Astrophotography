#/bin/bash
if [ ! $1 ] 
then
   echo "ERROR"; echo
   echo "Use album <folder>"
   echo
   exit
fi

ROOT=$(pwd)
IMAGES=$ROOT/Imaging
cd $IMAGES/$1
echo Exploring album $1
OUTPUT=./$1.tex
PREAMBLE='\\begin{figure}[phbt]\n\t\includegraphics[width=\\textwidth]{'$IMAGES/$1/
CLOSING='\\end{figure}'
echo "Regenerating album "$1
echo '\section{Album '$1'}' > $OUTPUT
if [  $(ls *.jpg | wc -l) -eq "0" ] 
then
	echo "No images found" >> $OUTPUT
	exit 0
fi
for IMG in $(ls *.jpg | sort)
do
#	echo "Found "$IMG
	IMGNAME=$(echo $IMG |sed s':\.jpg::' | sed s":\_: :g")
	IMGNAMEREAL=$(echo $IMG |sed s':\_:\\_:g' )
	echo "Found ""$IMGNAME"
	echo "$PREAMBLE$IMGNAMEREAL}" >> $OUTPUT
	echo "\n\t"'\\vspace{-1cm}{\\color{white}\\bf \Large '"$IMGNAME}" >> $OUTPUT
	echo "\n$CLOSING" >> $OUTPUT	
	echo '\\newpage' >> $OUTPUT
done
cd -
