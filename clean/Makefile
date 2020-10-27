# Authors:     Everet
# Maintainers: Everet
# Copyright:   2020, Everet, AGPL 3.0 or later
# =========================================
# DE-school-finance/clean/Makefile

CALL_R := Rscript --vanilla
EXTRACT_DIR := ../extract/output
INDIR := input
OUTDIR := output

.PHONY: all clean
all: \
		$(OUTDIR)/enrollment_2018-19.csv \
		$(OUTDIR)/enrollment_2019-20.csv \
		$(OUTDIR)/revenue_2018-19.csv \
		$(OUTDIR)/final.geojson \
		$(OUTDIR)/final.csv
clean: -rm -r $(OUTDIR)/*

### Enrollment

OUTFILE := $(OUTDIR)/enrollment_2018-19.csv
INFILE := $(EXTRACT_DIR)/Student_Enrollment.csv
$(OUTFILE): \
		src/clean_enrollment_OLD.R \
		$(INFILE)
	$(CALL_R) $<

OUTFILE := $(OUTDIR)/enrollment_2019-20.csv
INFILE := $(INDIR)/Enrollment-and-Unit-Data-Sen-Poore.xlsx
$(OUTFILE): \
		src/clean_enrollment.R \
		$(INFILE)
	$(CALL_R) $<

### Revenue

OUTFILE := $(OUTDIR)/revenue_2018-19.csv
INFILE := $(EXTRACT_DIR)/Fiscal_district_financial_report_REGULAR_SCHOOL_V3-page-11-table-1.csv
$(OUTFILE): \
		src/clean_revenue.R \
		$(INFILE)
	$(CALL_R) $<

### Join it all together

OUTFILE := $(OUTDIR)/final.geojson $(OUTDIR)/final.csv
$(OUTFILE): \
		src/join.R \
		$(OUTDIR)/enrollment_2018-19.csv \
		$(OUTDIR)/revenue_2018-19.csv
	$(CALL_R) $<
