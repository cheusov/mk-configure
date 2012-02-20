##################################################

all : presentation.pdf myprojects.pdf

.PHONY : pdf dvi rtf
pdf : presentation.pdf
ps  : presentation.ps
dvi : presentation.dvi

.SUFFIXES: .ps .eps .pdf .dvi .tex .dot

presentation.ps presentation.pdf presentation.dvi: my_prjs.eps dep_graph.eps

.ps.pdf:
	ps2pdf "$<" "$@"

#.tex.pdf:
#	pdflatex "$<" && pdflatex "$<"

.dot.eps:
	dot -Tps ${.IMPSRC} > ${.TARGET}

.dvi.ps:
	dvips $<

.tex.dvi:
	latex "${.IMPSRC}" && latex "${.IMPSRC}"

.gz:
	gzip ${.IMPSRC}

GARBAGE=	*.dvi *.aux *.vrb *.toc *.snm *.log *.nav *.out *.eps *.ps
CLEANFILES+=	${GARBAGE} *.pdf *.ps myprojects.tex

.PHONY: clean-garbage
clean-garbage:
	rm -f ${GARBAGE}

##################################################
myprojects.tex : presentation.tex
	awk '/^%%%begin-myprojects/, /^%%%end-myprojects/' \
		${.ALLSRC} > ${.TARGET}
myprojects.ps myprojects.pdf myprojects.dvi: my_prjs.eps

.include <mkc.files.mk>
