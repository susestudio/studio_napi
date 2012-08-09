# make check is funneled through npm test to make sure
# mocha(1) is in $PATH even if it's only installed locally
# (npm adds <package_dir>/node_modules/.bin to $PATH)

RST2HTML ?=	$(call first_in_path,rst2html.py rst2html)

htmlfiles =	README.html NOTES.html examples.html reference.html

html: $(htmlfiles)

%.html: %.rest
	$(RST2HTML) $< $@

check:
	npm test

do-check:
	mocha -C --compilers t.coffee:coffee-script \
	  $$(find tests/lo -name \*.t.coffee | sort) \
	  $$(find tests/hi -name \*.t.coffee | sort)

define first_in_path
  $(firstword $(wildcard \
    $(foreach p,$(1),$(addsuffix /$(p),$(subst :, ,$(PATH)))) \
  ))
endef

MAKEFLAGS =	--no-print-directory \
		--no-builtin-rules \
		--no-builtin-variables

.PHONY: check do-check html

# vim: ts=8 noet sw=2 sts=2
