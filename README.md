[![Build Status](https://travis-ci.com/enspirit/printit.svg?branch=master)](https://travis-ci.com/enspirit/printit)

# Printit - convert your html to csv or pdf

## Dev

- add a .env file at the root of the project with a `HANDLER` variable. Its
value may be `prince` or `weasyprint`.
- copy `config/printit-example.yml` to `config/printit.yml` and set the
`handler` key accordingly.
- use the `Makefile` commands to build, launch, test the software.
