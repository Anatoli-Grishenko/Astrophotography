ROOT=$(shell pwd)
REPORTS=$(ROOT)/Reports/
IMAGES=$(ROOT)/Imaging/
WORKFLOW=$(REPORTS)/Workflow/

rebuild	: clean all

clean	: 
	touch $(IMAGES)/*/*.tex
	
all	:	variables preamble albums workflow

preamble	:
	@echo "Processing projects"

variables: 

albums	: 
	bash $(ROOT)/bin/collection.sh
	
workflow	: 
	@cd $(WORKFLOW)
	@pdflatex -output-directory $(WORKFLOW) Workflow.tex
	@cd $(ROOT)
	
albums	: Greyscale


#Greyscale	: $(IMAGES)/Greyscale/Greyscale.tex
Greyscale	: $(IMAGES)/Greyscale/Greyscale.tex


#$(IMAGES)/Greyscale/Greyscale.tex	: $(wildcard $($(IMAGES)/Grayscale/*.jpg))
$(IMAGES)/Greyscale/Greyscale.tex	: 
	@echo "Checking for updates on album "$@
	$(ROOT)/bin/album.sh Grayscale
