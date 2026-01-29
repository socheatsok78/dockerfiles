target ?= default
it: print
print:
	docker buildx bake --file docker-bake.hcl --file=${target}/docker-bake.hcl ${target} --set="*.platform=" --print
build: print
	docker buildx bake --file docker-bake.hcl --file=${target}/docker-bake.hcl ${target} --set="*.platform=" --load
buildx: print
	docker buildx bake --file docker-bake.hcl --file=${target}/docker-bake.hcl ${target}
push: print
	BUILDX_BUILDER=default-builder docker buildx bake --file docker-bake.hcl --file=${target}/docker-bake.hcl ${target} --push
