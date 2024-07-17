.PHONY: help ps build build-prod start fresh fresh-prod stop restart destroy \
	cache cache-clear migrate migrate migrate-fresh tests tests-html

CONTAINER_PHP=php #api
CONTAINER_REDIS=redis
CONTAINER_DATABASE=mysql #database

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

auth: #authentification avec aws
	aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 975050020416.dkr.ecr.us-east-2.amazonaws.com
build: # build the prod image
	docker build -t prod-laravel-api-base-image .
push: # push to prod
	docker tag prod-laravel-api-base-image:latest 975050020416.dkr.ecr.us-east-2.amazonaws.com/prod-laravel-api-base-image:latest
	docker push 975050020416.dkr.ecr.us-east-2.amazonaws.com/prod-laravel-api-base-image:latest
build-push:
	make build
	make push