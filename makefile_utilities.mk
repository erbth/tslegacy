remove_trailing_slash = $(patsubst %/,%,$(1))
date_today = "$(shell LANG=POSIX date +"%d %B, %Y")"

read_version = $(shell if test -f $(PACKAGING_BASE)/packaging_location/$(1)/version;\
	then cat $(PACKAGING_BASE)/packaging_location/$(1)/version; else echo -n 0.0.0; fi)
bigger_equal_dep = $(1)>=$(call read_version,$(1))
equal_dep = $(1)=$(call read_version,$(1))
