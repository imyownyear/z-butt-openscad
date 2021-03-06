SHELL := /bin/bash


# SIZES := 1 1.25 1.5 1.75 2 2.25 2.75 3 4 6 6.25 7
SIZES := 1 2


STL_MX_MASTER_BASE := $(foreach xu,$(SIZES),stl/z-butt-$(xu)u-mx-master-base.stl)
STL_MX_SCULPT_BASE := $(foreach xu,$(SIZES),stl/z-butt-$(xu)u-mx-sculpt-base.stl)
STL_MX_STEM_CAVITY := $(foreach xu,$(SIZES),stl/z-butt-$(xu)u-mx-stem-cavity.stl)
STL_CONTAINER := $(foreach xu,$(SIZES),stl/z-butt-$(xu)u-container.stl)


all : \
	img/z-butt-1u-2u-photo.png \
	img/z-butt-family-photo.png \
	$(STL_MX_MASTER_BASE) \
	$(STL_MX_SCULPT_BASE) \
	$(STL_MX_STEM_CAVITY) \
	$(STL_CONTAINER)

clean :
	rm -rf \
	  img/z-butt-1u-2u-photo.png \
	  img/z-butt-family-photo.png \
	  stl

stl/%.stl : %.scad z-butt.scad
	@mkdir -p stl
	openscad -o /tmp/$*.stl $<
	mv /tmp/$*.stl $@

img/%.png : %.scad z-butt.scad
	openscad \
	  --imgsize=870,870 \
	  -o /tmp/$*.png $<
	mv /tmp/$*.png $@

z-butt-%u-mx-master-base.scad :
	echo -e "include <z-butt.scad>\n\n\nmx_master_base(xu=$*);\n" > /tmp/$@
	mv /tmp/$@ $@

z-butt-%u-mx-sculpt-base.scad :
	echo -e "include <z-butt.scad>\n\n\nmx_sculpt_base(xu=$*);\n" > /tmp/$@
	mv /tmp/$@ $@

z-butt-%u-mx-stem-cavity.scad :
	echo -e "include <z-butt.scad>\n\n\nrotate([180, 0, 0]){mx_stem_cavity(xu=$*);}\n" > /tmp/$@
	mv /tmp/$@ $@

z-butt-%u-container.scad :
	echo -e "include <z-butt.scad>\n\n\nrotate([0, 0, 0]){container(xu=$*);}\n" > /tmp/$@
	mv /tmp/$@ $@
