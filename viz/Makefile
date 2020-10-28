# Authors:     Everet
# Maintainers: Everet
# Copyright:   2020, Everet, AGPL 3.0 or later
# =========================================
# DE-school-finance/viz/Makefile

HERE := $(shell git rev-parse --show-toplevel)
INDIR := $(HERE)/clean/output
OUTDIR := $(HERE)/viz/output
SRCDIR := $(HERE)/viz/src

CALL_R := Rscript --vanilla

.PHONY: all clean
all: \
		$(OUTDIR)/Aid-Doesnt-Follow-Need.html
clean:
	-rm -r $(OUTDIR)/*

OUTFILE := $(OUTDIR)/Aid-Doesnt-Follow-Need.html
INFILE := $(INDIR)/final.csv $(INDIR)/final.geojson
$(OUTFILE): \
		$(SRCDIR)/render.R \
		$(SRCDIR)/viz.Rmd \
		$(SRCDIR)/plot_utils.R \
		$(SRCDIR)/leaflet_utils.R \
		$(INFILE)
	$(CALL_R) $<
