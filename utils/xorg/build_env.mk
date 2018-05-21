# I took the general configure paramters for Xorg and the technique of putting
# them into a variable from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.

ifndef utils_xorg_build_env_included
utils_xorg_build_env_included := 1

export XORG_PREFIX := /usr
export XORG_CONFIG := " \
	--prefix=$(XORG_PREFIX) \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-static"

endif
