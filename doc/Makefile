##################################################

.PHONE : all
all : presentation.pdf

.PHONY : pdf dvi rtf
pdf : presentation.pdf
ps  : presentation.ps
dvi : presentation.dvi

.SUFFIXES: .ps .pdf .dvi .tex

#.ps.pdf:
#	ps2pdf "$<" "$@"

.tex.pdf:
	pdflatex "$<" && pdflatex "$<"

.dvi.ps:
	dvips $<

.tex.dvi:
	latex "${.IMPSRC}" && latex "${.IMPSRC}"

CLEANFILES+=	*.pdf *.ps *.dvi *.aux *.vrb *.toc *.snm *.log *.nav *.out

##################################################
