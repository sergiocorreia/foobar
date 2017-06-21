*! foobar 0.0.3 20jun2017
program define foobar
	di as text "This is a demo of how to compile mlib files on the fly; requires ftools"
	
	ms_get_version foobar
	ms_compile_mata, package(foobar) version(`package_version') verbose force
	// verbose: show where the mlib file was created
	// force: force recompilation

	mata: foobar()
	display "... dolor sit amet"
end
