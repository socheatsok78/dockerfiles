target ?= default
targets := $(foreach f,$(wildcard **/docker-bake.hcl),$(patsubst %/,%,$(dir $(f))))
docker_buildx_bake_files := $(if $(wildcard ${target}/docker-bake.hcl),--file=${target}/docker-bake.hcl,$(foreach f,$(wildcard **/docker-bake.hcl),--file=$(f)))
docker_buildx_build_cmd := docker buildx bake --file docker-bake.hcl ${docker_buildx_bake_files} ${target}

it:
	@$(MAKE) print | jq -r '.target | keys'
print:
	@$(docker_buildx_build_cmd) --print 2>/dev/null
build: print
	@$(docker_buildx_build_cmd) --load --set="*.platform="
buildx: print
	@$(docker_buildx_build_cmd)
push: print
	@BUILDX_BUILDER=default-builder $(docker_buildx_build_cmd) --push

.PHONY: $(targets)
$(targets):
	@$(MAKE) target=$@ build
