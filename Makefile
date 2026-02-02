target ?= default
docker_buildx_cmd := docker buildx bake --file docker-bake.hcl --file=${target}/docker-bake.hcl ${target}
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
