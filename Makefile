target ?= default
target_bake_file := $(if $(wildcard ${target}/docker-bake.hcl),--file=${target}/docker-bake.hcl,)
docker_buildx_cmd := docker buildx bake --file docker-bake.hcl ${target_bake_file} ${target}
it:
	$(docker_buildx_cmd) --set="*.platform=" --print 2>/dev/null | jq -r '.target | keys'
print:
	$(docker_buildx_cmd) --set="*.platform=" --print 2>/dev/null
build: print
	$(docker_buildx_cmd) --set="*.platform=" --load
buildx: print
	$(docker_buildx_cmd)
push: print
	BUILDX_BUILDER=default-builder $(docker_buildx_cmd) --push
