target ?= default
bakefiles :=
ifeq ($(target),default)
bakefiles := $(foreach dir,$(wildcard */),$(if $(wildcard $(dir)/docker-bake.hcl), --file=$(dir)/docker-bake.hcl))
else
bakefiles := --file=$(target)/docker-bake.hcl
endif

it: print
print:
	docker buildx bake --file docker-bake.hcl $(bakefiles) ${target} --set="*.platform=" --print
build: print
	docker buildx bake --file docker-bake.hcl $(bakefiles) ${target} --set="*.platform=" --load
push: print
	BUILDX_BUILDER=default-builder docker buildx bake --file docker-bake.hcl $(bakefiles) ${target} --push
