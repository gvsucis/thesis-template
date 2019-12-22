DOCNAME := Thesis
OUTDIR := build

SOURCES := $(wildcard *.tex) $(wildcard *.bib) $(wildcard Forms/*.pdf) gvsuthesis.cls
LATEX_OPTS := -xelatex -bibtex -outdir=$(OUTDIR) -halt-on-error -file-line-error

.PHONY: all
.PHONY: clean

all: $(OUTDIR)/$(DOCNAME).pdf

$(OUTDIR)/$(DOCNAME).pdf: $(SOURCES)
	latexmk $(LATEX_OPTS) $(DOCNAME)

clean:
	rm -rf $(OUTDIR)
