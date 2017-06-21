# Demo: Including Mata with Stata packages

This package shows a way to automatically compile Mata libraries as part of a Stata package.
It's based on [David Roodman's](https://www.statalist.org/forums/forum/general-stata-discussion/mata/1319628-making-mata-libraries-for-multiple-stata-versions-gracefully) work and uses the
[ftools](https://github.com/sergiocorreia/ftools/) package (due to two files: `ms_compile_mata.ado` and `ms_get_version.ado`). 

Note: if you don't need to expose your Mata functions outside your ado files, then you don't really need a Mata library (`.mlib` file),
and should just include the Mata code at the end of the do-file.

# How this works

- Ado files usually start with a version line: `*! foobar 0.0.3 20jun2017`.
- Within the Stata program, we run `ms_get_version` (part of `ftools`), which reads this line and stores it in a local.
- Next, we run `ms_compile_mata, package(foobar) version(`package_version')`
- This will try to run the Mata functions `foobar_version()` and `foobar_stata_version()`. If they are not found or return different values, it wil then run `do foobar.mata` and create a `lfoobar.mlib` file.
- The key trick is that the `.mata` file also runs `ms_get_version` and has functions that depend on the locals created. So if the version of Stata or of the package differ than the ones used to compile the `mlib`, the library will be created again.

## Advantages

- It can also be used as a pre-compiler. So we can e.g. replace `selectindex()` and `panelsum()` with alternatives when using older versions of Stata that don't have these Mata functions.
- You only set the version once, at the top of the ado file
- You don't have to open Stata 11 to compile the file; and you can rely on potential compiler improvements on newer versions of Stata
- If you have two versions of Stata on the same computer, you don't get mlib conflicts
- You don't have to distribute large mlib files, and users don't have to download opaque binaries.

## Disadvantages

- You have to rely on another package (`ftools`). But to solve that you can just copy-paste the two ados listed above into your own package (and rename them).
