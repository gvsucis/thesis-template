DOCNAME := Thesis
OUTDIR := build

SOURCES := $(wildcard *.tex) $(wildcard *.bib) gvsuthesis.cls

.PHONY: all
.PHONY: clean

all: $(OUTDIR)/$(DOCNAME).pdf

$(OUTDIR)/$(DOCNAME).pdf: $(SOURCES)
	latexmk -halt-on-error -xelatex -outdir=$(OUTDIR) $(DOCNAME).tex

clean:
	rm -rf $(OUTDIR)
