.PHONY: fmt-exercise-1 validate-exercise-1

fmt-exercise-1:
	terraform fmt -recursive exercise_1

validate-exercise-1:
	terraform fmt -recursive -check exercise_1
	terraform -chdir=exercise_1/examples/basic init -backend=false -input=false
	terraform -chdir=exercise_1/examples/basic validate
