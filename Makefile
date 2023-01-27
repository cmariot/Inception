# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/31 16:08:49 by cmariot           #+#    #+#              #
#    Updated: 2022/09/27 15:06:15 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

PROJECT_NAME 				= inception

DOCKER_COMPOSE_FILE			= srcs/docker-compose.yml

HOME_PATH					= /home/cmariot

DOCKER_COMPOSE_COMMAND		= docker compose \
							  -f ${DOCKER_COMPOSE_FILE} \
							  -p ${PROJECT_NAME}
up: create_directories
	${DOCKER_COMPOSE_COMMAND} up --detach --pull never --build

clean: stop
	docker system prune -a --force

fclean: stop rm_directories
	docker system prune -a --force --volumes
	docker volume rm -f inception_mariadb_volume inception_wordpress_volume inception_static_website_volume

re: fclean up

sh_nginx:
	${DOCKER_COMPOSE_COMMAND} exec nginx sh

sh_mariadb:
	${DOCKER_COMPOSE_COMMAND} exec mariadb sh

sh_wordpress:
	${DOCKER_COMPOSE_COMMAND} exec wordpress sh

ps:
	${DOCKER_COMPOSE_COMMAND} ps

list:
	@printf "CONTAINERS LIST :\n"
	@docker container ls
	@printf "\nIMAGES LIST :\n"
	@docker image ls
	@printf "\nVOLUMES LIST :\n"
	@docker volume ls
	@printf "\nNETWORKS LIST :\n"
	@docker network ls

image:
	${DOCKER_COMPOSE_COMMAND} images

pause:
	${DOCKER_COMPOSE_COMMAND} pause

unpause:
	${DOCKER_COMPOSE_COMMAND} unpause

start:
	${DOCKER_COMPOSE_COMMAND} start

stop:
	${DOCKER_COMPOSE_COMMAND} stop

restart:
	${DOCKER_COMPOSE_COMMAND} restart

create_directories:
	mkdir -p ${HOME_PATH}/data/mariadb\
		${HOME_PATH}/data/wordpress\
		${HOME_PATH}/data/static_website

rm_directories:
	sudo rm -rf ${HOME_PATH}/data/mariadb\
		${HOME_PATH}/data/wordpress\
		${HOME_PATH}/data/static_website
