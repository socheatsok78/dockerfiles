target ?= default
it: print
print:
	docker buildx bake ${target} --set="*.platform=" --print
build: print
	docker buildx bake ${target} --set="*.platform=" --load
