# make check is funneled through npm test to make sure
# mocha(1) is in $PATH even if it's only installed locally
# (npm adds <package_dir>/node_modules/.bin to $PATH)

check:
	npm test

do-check:
	mocha -C --recursive --compilers t.coffee:coffee-script tests

MAKEFLAGS =	--no-print-directory \
		--no-builtin-rules \
		--no-builtin-variables

.PHONY: check do-check

# vim: ts=8 noet sw=2 sts=2
