#
# CED - back
#
# Jose Paulo - 05-2022
#

include VERSION

COMMIT   := $(shell git log --pretty="%h" -1)

DST_DEV  := aws_docker
DST_QA   := $(DST_DEV)
DST_HML  := $(DST_DEV)
DST_PRD  := $(DST_DEV)

RGY_DEV  := kvm4:5000
RGY_QA   := $(RGY_DEV)
RGY_HML  := $(RGY_DEV)
RGY_PRD  := $(RGY_DEV)

PROJECT  := ced_back
DCK_IMG  := ced/$(PROJECT):$(VERSION)
RUN_SCR  := run_CED_back

#
# Build
#
build:
	@echo
	@echo "Build .Net"
	cd Api.application \
	dotnet restore \
	dotnet publish -c Release -o out

#
# Build da imagem docker 
#
build_image:
	@echo
	@echo "Building Docker Image"
	docker build --rm \
		--build-arg ARG_VERSION="$(VERSION)" \
		--build-arg ARG_BUILD="$(COMMIT)" \
		-t "$(DCK_IMG)"  .
	docker images | grep $(PROJECT)
	@echo Build completed!

#
# Push da imagem no ambiente de Dev
#
push_dev:
	@echo
	@echo Push
	docker tag $(DCK_IMG) $(RGY_DEV)/$(DCK_IMG)
	docker push $(RGY_DEV)/$(DCK_IMG)
	docker rmi $(DCK_IMG)
	@echo Push done!

#
# Executa o container no ambiente de Dev
#
run_cnt_dev:
	@echo
	@echo Executing container in Dev...
	ssh $(DST_DEV) bin/$(RUN_SCR)_dev.sh
	@echo Done!

#
# Deploy da imagem no ambiente de QA
#
push_qa:
	@echo
	@echo Push
	docker tag $(DCK_IMG) $(RGY_QA)/$(DCK_IMG)
	docker push $(RGY_QA)/$(DCK_IMG)
	docker rmi $(DCK_IMG)
	@echo Push done!

#
# Executa o container no ambiente de QA
#
run_cnt_qa:
	@echo
	@echo Executing container in QA...
	ssh $(DST_QA) bin/$(RUN_SCR)_qa.sh
	@echo Done!

#
# Deploy da imagem no ambiente de Homolog
#
push_hml:
	@echo
	@echo Push
	docker tag $(DCK_IMG) $(RGY_HML)/$(DCK_IMG)
	docker push $(RGY_HML)/$(DCK_IMG)
	docker rmi $(DCK_IMG)
	@echo Push done!

#
# Executa o container no ambiente de Homolog
#
run_cnt_hml:
	@echo
	@echo Executing container in Homolog...
	ssh $(DST_HML) bin/$(RUN_SCR)_hml.sh $(VERSION)
	@echo Done!

#
# Deploy da imagem no ambiente de Produção
#
push_prd:
	@echo
	@echo Push
	docker tag $(DCK_IMG) $(RGY_PRD)/$(DCK_IMG)
	docker push $(RGY_PRD)/$(DCK_IMG)
	docker rmi $(DCK_IMG)
	@echo Push done!

#
# Executa o container no ambiente de Produção
#
run_cnt_prd:
	@echo
	@echo Executing container in Production...
	ssh $(DST_PRD) bin/$(RUN_SCR)_prd.sh $(VERSION)
	@echo Done!

