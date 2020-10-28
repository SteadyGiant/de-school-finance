# Authors:     Everet
# Maintainers: Everet
# Copyright:   2020, Everet, AGPL 3.0 or later
# =========================================
# DE-school-finance/clean/Makefile

HERE := $(shell git rev-parse --show-toplevel)
EXTRACT_DIR := $(HERE)/extract/output
INDIR := $(HERE)/clean/input
OUTDIR := $(HERE)/clean/output
SRCDIR := $(HERE)/clean/src

CALL_R := Rscript --vanilla

.PHONY: all clean
all: \
		$(OUTDIR)/enrollment_2018-19.csv \
		$(OUTDIR)/enrollment_2019-20.csv \
		$(OUTDIR)/revenue_2018-19.csv \
		$(OUTDIR)/opportunity-funding_2019-20.csv \
		$(OUTDIR)/final.geojson \
		$(OUTDIR)/final.csv
clean:
	-rm -r $(OUTDIR)/*

### Enrollment

OUTFILE := $(OUTDIR)/enrollment_2018-19.csv
INFILE := $(EXTRACT_DIR)/Student_Enrollment.csv
$(OUTFILE): \
		$(SRCDIR)/clean_enrollment_2018-19.R \
		$(INFILE)
	$(CALL_R) $<

OUTFILE := $(OUTDIR)/enrollment_2019-20.csv
INFILE := $(INDIR)/Enrollment-and-Unit-Data-Sen-Poore.xlsx
$(OUTFILE): \
		$(SRCDIR)/clean_enrollment_2019-20.R \
		$(INFILE)
	$(CALL_R) $<

### Revenue

OUTFILE := $(OUTDIR)/revenue_2018-19.csv
INFILE := $(EXTRACT_DIR)/Fiscal_district_financial_report_REGULAR_SCHOOL_V3-page-11-table-1.csv
$(OUTFILE): \
		$(SRCDIR)/clean_revenue_2018-19.R \
		$(INFILE)
	$(CALL_R) $<

OUTFILE := $(OUTDIR)/opportunity-funding_2019-20.csv
INFILE := $(EXTRACT_DIR)/Opportunity-Funding_contracttotals/*.csv
$(OUTFILE): \
		$(SRCDIR)/clean_opportunity-funding_2019-20.R \
		$(INFILE)
	$(CALL_R) $<

### Join it all together

OUTFILE := $(OUTDIR)/final.geojson $(OUTDIR)/final.csv
$(OUTFILE): \
		$(SRCDIR)/join.R \
		$(OUTDIR)/enrollment_2018-19.csv \
		$(OUTDIR)/revenue_2018-19.csv
	$(CALL_R) $<
