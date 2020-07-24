# Printit - convert your html to csv or pdf

Currently supports the following handlers:
- [PrinceXML](https://www.princexml.com/) (set by default)
- [Weasyprint](https://weasyprint.org/)

## Dev

- add a .env file at the root of the project with the currently developped
`VERSION` variable.
- copy `config/printit-example.yml` to `config/printit.yml` but do not set the
`handler` value cause it would overwrite the HANDLER environment variable
automatically set in the docker compose file.
- use the `Makefile` commands to build, launch, test, and push the software.
