# lab42_html

<!--
DO NOT EDIT THIS FILE
It has been generated from the template `README.md.eex` by Extractly (https://github.com/RobertDober/extractly.git)
and any changes you make in this file will most likely be lost
-->

[![Build Status](https://travis-ci.org/RobertDober/lab42_html.svg?branch=master)](https://travis-ci.org/RobertDober/lab42_html)
[![Coverage Status](https://coveralls.io/repos/github/RobertDober/lab42_html/badge.svg?branch=master)](https://coveralls.io/github/RobertDober/lab42_html?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/lab42_html.svg)](https://hex.pm/packages/lab42_html)
[![Hex.pm](https://img.shields.io/hexpm/dw/lab42_html.svg)](https://hex.pm/packages/lab42_html)
[![Hex.pm](https://img.shields.io/hexpm/dt/lab42_html.svg)](https://hex.pm/packages/lab42_html)


## Synopsis

An isolated HTML generator. Inspired in its simplicity by Dave Thomas' keynote, condensed here https://pragdave.me/blog/2018/06/02/project-structure.html

### Lab42.Html.gen_table/2


      iex(0)> data = [
      ...(0)>   ["header1", "header2"],
      ...(0)>   ["cell1", "cell2"]]
      ...(0)> gen_table(data)
      {:ok, "<table>\n<thead>\n<tr>\n<th>\nheader1\n</th>\n<th>\nheader2\n</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>\ncell1\n</td>\n<td>\ncell2\n</td>\n</tr>\n</tbody>\n</table>\n", []}

Headers can, but probably shall not, be avoided, also we expose `Lab42.Html.Table.gen/2` as `gen_table/2`

      iex(1)> data = [
      ...(1)>  ~w(no_header no_header),
      ...(1)>  ~w(cell21 cell22)]
      ...(1)> gen_table(data, false)
      {:ok,
      "<table>\n<tbody>\n<tr>\n<td>\nno_header\n</td>\n<td>\nno_header\n</td>\n</tr>\n<tr>\n<td>\ncell21\n</td>\n<td>\ncell22\n</td>\n</tr>\n</tbody>\n</table>\n",
      []}



## Author

Copyright © 2019 Robert Dober, mailto:robert.dober@gmail.com

## License

[Apache-2.0](LICENSE)
<!-- SPDX-License-Identifier: Apache-2.0 -->
