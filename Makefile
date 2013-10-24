all: pdf

clean:
	rm -rf *.{aux,log,nav,out,snm,toc,vrb}

pdf:
	pdflatex git
	# pdflatex qual 
	# pdflatex qual 
	# bibtex qual 
	# pdflatex qual 

