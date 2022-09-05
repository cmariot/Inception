CONTAINER_NAME = mariadb:alpha
IMAGE_NAME = mariadb

test : build run exec

build :
	docker build --tag $(CONTAINER_NAME) .

run :
	docker run -p 443:443 --detach --interactive --tty --name $(IMAGE_NAME) $(CONTAINER_NAME)

exec :
	docker exec --interactive --tty $(IMAGE_NAME) /bin/sh

clean :
	docker rm -f $(IMAGE_NAME)
