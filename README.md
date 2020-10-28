# Delaware School Finance Report

I built a simple report demonstrating the inequity of Delaware's school funding formula.

The final output is `viz/output/Aid-Doesnt-Follow-Need.html`; open it in a web browser. It contains both static charts and interactive HTML widgets.

See `extract/README.md` for an overview of data sources.

## Licensing

All code is licensed under the [GNU Affero General Public License version 3.0](https://www.gnu.org/licenses/agpl-3.0.html) or later. See [`LICENSE.txt`](LICENSE.txt).

All other content is licensed under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Build

To rebuild the report, run these commands in a shell, starting at the project root:

```sh
cd viz
make clean
make
```

To rebuild everything, data and reports, run these, starting at the project root:

```sh
cd extract
make clean
make
cd ../clean
make clean
make
cd ../viz
make clean
make
```
