CONTAINER_NAME = nginx:alpha
IMAGE_NAME = nginx

test : build run exec

build :
	docker build --tag $(CONTAINER_NAME) .

run :
	docker run --detach --interactive --tty --name $(IMAGE_NAME) $(CONTAINER_NAME)

exec :
	docker exec --interactive --tty $(IMAGE_NAME) /bin/sh

clean :
	docker rm -f $(IMAGE_NAME)
