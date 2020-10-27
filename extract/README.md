# Data Sources

`input/*.csv` comes from [this table](https://data.delaware.gov/Education/Student-Enrollment/6i7v-xnmf/data) with the following filters:

- School Year is 2019
- District Code is greater than 0 (No statewide stats)
- District Code is at most 40 (no charter schools)
- School Code is 0 (district-wide stats only)
- Race is "All Students"
- Gender is "All Students"
- Grade is "All Students"
- SubGroup is "English Learners" or "Low Income"
