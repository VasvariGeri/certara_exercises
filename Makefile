.PHONY: fmt-exercise-1 validate-exercise-1 fmt-exercise-2 validate-exercise-2 plan-exercise-2

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
