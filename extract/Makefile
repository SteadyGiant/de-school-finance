# Authors:     Everet
# Maintainers: Everet
# Copyright:   2020, Everet, AGPL 3.0 or later
# =========================================
# DE-school-finance/extract/Makefile

CALL_R := Rscript --vanilla
OUTDIR := extract/output

.PHONY: all clean
all: $(OUTDIR)/school-districts.geojson
clean: -rm -r $(OUTDIR)/*

$(OUTDIR)/school-districts.geojson: \
		src/get_shapefile.R
	$(CALL_R) $<
