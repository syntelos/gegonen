


gegonen-%.pdf: gegonen-%.ps
	ps2pdf gegonen-%.ps

gegonen-%.ps: gegonen-%.dvi
	dvips gegonen-%.dvi

gegonen-%.dvi: gegonen-%.tex
	tex gegonen-%.tex

# .PHONY: clean again
# 
# clean:
# 	$(RM) *.pdf *.ps *.dvi
# 
# again: clean
# 	$(MAKE)
# 

