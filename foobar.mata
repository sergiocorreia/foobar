// Versioning
ms_get_version foobar
assert("`package_version'" != "")
mata: string scalar foobar_version() return("`package_version'")
mata: string scalar foobar_stata_version() return("`c(stata_version)'")
mata: string scalar foobar_joint_version() return("`package_version'|`c(stata_version)'")


// Backwards compatibility for Mata functions
if (c(version) < 13) {
	cap mata: boottestVersion()
	if (c(rc)) {
		di as err "Error: Stata versions 12 or earlier require the boottest package"
		di as err "To install, from within Stata type " _c
		di as smcl "{stata ssc install boottest :ssc install boottest}"
		exit 601
	}
	loc selectindex _selectindex
	loc panelsum _panelsum
}
else {
	loc selectindex selectindex
	loc panelsum panelsum
}


// Actual code starts here
mata:

void foobar() {
	printf("{txt}Lorem ipsum ...\n")
	`selectindex'(round(runiform(10,1)))
}

end
