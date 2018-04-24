remove_trailing_slash = $(patsubst %/,%,$(1))
date_today = "$(shell LANG=POSIX date +"%d %B, %Y")"