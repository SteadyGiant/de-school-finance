# Data Sources

## Current

[(School finance) Financial Transparency Links](https://www.doe.k12.de.us/domain/558). Includes the [Educational Statistics Report](https://www.doe.k12.de.us/site/handlers/filedownload.ashx?moduleinstanceid=11358&dataid=24493&FileName=Fiscal%20district%20financial%20report%20REGULAR%20SCHOOL_V3.pdf) with state and local funding. This is `input/Fiscal_district_financial_report_REGULAR_SCHOOL_V3.pdf`.

The [Opportunity Funding page](https://governor.delaware.gov/district-charter-spending/) has an [overview of OF received by each district](https://governor.delaware.gov/wp-content/uploads/sites/24/2020/02/Opportunity-Funding_contracttotals.pdf) in presumably 2019-20. This is `input/Opportunity-Funding_contracttotals.pdf`.

DE's [Open Data Portal (Socrata)](https://data.delaware.gov/) has enrollment, but not finance. `output/Student_Enrollment.csv` comes from [the enrollment table](https://data.delaware.gov/Education/Student-Enrollment/6i7v-xnmf/data) with the following filters:

- School Year is 2019
- District Code is greater than 0 (No statewide stats)
- District Code is at most 40 (no charter schools)
- School Code is 0 (district-wide stats only)
- Race is "All Students"
- Gender is "All Students"
- Grade is "All Students"
- SubGroup is "English Learners" or "Low Income"

`output/school-districts.geojson` comes from an [ArcGIS REST API endpoint](https://firstmap.delaware.gov/arcgis/rest/services/Boundaries/DE_SchoolDistricts/MapServer/0) linked to [this Open Data Delaware dataset](https://data.delaware.gov/Education/School-Districts-Boundaries/krpv-uu7g). See `src/get_shapefile.R` for the query used.

## Future

I'd like FY20 state and local funding per pupil, because I have 2019-20 enrollment and Opportunity Funding.

["Education Budget"](https://www.doe.k12.de.us/Page/3509) includes the Equalization Committee's [report](https://www.doe.k12.de.us/site/handlers/filedownload.ashx?moduleinstanceid=9243&dataid=24259&FileName=FY21%20Equalization%20Report.pdf) with some background, as well as the [Assessment and Tax Rate Table](https://www.doe.k12.de.us/site/handlers/filedownload.ashx?moduleinstanceid=9243&dataid=22718&FileName=FY20%20Assessment%20and%20Tax%20Rate%20Table.pdf), which looks like the data on assessed vs. "full" evaluation.
