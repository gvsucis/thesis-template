DOCNAME := Thesis
OUTDIR := build

.PHONY: all
.PHONY: clean

all: $(OUTDIR)/$(DOCNAME).pdf

$(OUTDIR)/$(DOCNAME).pdf: $(DOCNAME).tex $(DOCNAME).bib
	latexmk -xelatex -outdir=$(OUTDIR) $(DOCNAME).tex

clean:
	rm -rf $(OUTDIR)
