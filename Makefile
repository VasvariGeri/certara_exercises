.PHONY: fmt-exercise-1 validate-exercise-1 fmt-exercise-2 validate-exercise-2 plan-exercise-2 validate-exercise-3 build-exercise-3 deploy-exercise-3 port-forward-exercise-3 run-exercise-3 smoke-test-exercise-3

fmt-exercise-1:
	terraform fmt -recursive exercise_1

validate-exercise-1:
	terraform fmt -recursive -check exercise_1
	terraform -chdir=exercise_1/examples/basic init -backend=false -input=false
	terraform -chdir=exercise_1/examples/basic validate

fmt-exercise-2:
	terraform fmt -recursive exercise_2

validate-exercise-2:
	terraform fmt -recursive -check exercise_2
	terraform -chdir=exercise_2 init -backend=false -input=false
	terraform -chdir=exercise_2 validate

plan-exercise-2:
	terraform -chdir=exercise_2 init -backend=false -input=false
	terraform -chdir=exercise_2 plan -input=false

validate-exercise-3:
	sh -n exercise_3/scripts/check-tools.sh
	sh -n exercise_3/scripts/deploy-minikube.sh
	sh -n exercise_3/scripts/port-forward.sh
	sh -n exercise_3/scripts/run-local.sh
	sh -n exercise_3/scripts/smoke-test.sh

build-exercise-3:
	docker build -t certara-rest:1.0 exercise_3

deploy-exercise-3:
	exercise_3/scripts/deploy-minikube.sh

port-forward-exercise-3:
	exercise_3/scripts/port-forward.sh

run-exercise-3:
	exercise_3/scripts/run-local.sh

smoke-test-exercise-3:
	exercise_3/scripts/smoke-test.sh
