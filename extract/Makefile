# Authors:     Everet
# Maintainers: Everet
# Copyright:   2020, Everet, AGPL 3.0 or later
# =========================================
# DE-school-finance/extract/Makefile

HERE := $(shell git rev-parse --show-toplevel)
OUTDIR := $(HERE)/extract/output
SRCDIR := $(HERE)/extract/src

CALL_R := Rscript --vanilla

.PHONY: all clean
all: $(OUTDIR)/school-districts.geojson
clean:
		-rm -r $(OUTDIR)/school-districts.geojson

$(OUTDIR)/school-districts.geojson: \
		$(SRCDIR)/get_shapefile.R
	$(CALL_R) $<
