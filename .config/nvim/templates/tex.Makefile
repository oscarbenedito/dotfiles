all: main

.PHONY: main reload

main:
	latexmk -pdf main.tex

reload:
	latexmk -pdf -pvc -interaction=nonstopmode main.tex

clean:
	latexmk -C
	rm -f *.bbl *.run.xml
