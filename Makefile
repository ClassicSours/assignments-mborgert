all: gap

gapminder:
	Rscript -e "knitr::knit('gap.Rmd');/
  rmarkdown::render('gap.Rmd','html_document')"

clean:
	rm -rf *.md
	rm -rf *.html