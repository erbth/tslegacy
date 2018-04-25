remove_trailing_slash = $(patsubst %/,%,$(1))
date_today = "$(shell LANG=POSIX date +"%d %B, %Y")"

read_version = $(shell cat $(PACKAGING_LOCATION)/$(1)/version)
bigger_equal_dep = $(1)>=$(call read_version,$(1))
