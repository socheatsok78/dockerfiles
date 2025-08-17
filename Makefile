target ?= default
it:
	docker buildx bake ${target} --set="*.platform=" --no-cache --print
build:
	docker buildx bake ${target} --set="*.platform=" --no-cache --load
