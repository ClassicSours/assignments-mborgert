report.pdf: gap.Rmd
	Rscript -e 'rmarkdown::render("$<")'