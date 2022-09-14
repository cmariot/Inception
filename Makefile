# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/31 16:08:49 by cmariot           #+#    #+#              #
#    Updated: 2022/09/15 00:19:06 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

PROJECT_NAME 				= inception

DOCKER_COMPOSE_FILE			= srcs/docker-compose.yml

DOCKER_COMPOSE_COMMAND		= sudo docker compose \
							  -f ${DOCKER_COMPOSE_FILE} \
							  -p ${PROJECT_NAME}

# **************************************************************************** #
#                                                                              #
#   Makefile rules :                                                           #
#                                                                              #
# - up :		Create and start containers                                    #
# - clean :		Stop and remove containers, networks, and images               #
# - fclean :	Stop and remove containers, networks, images, and volumes      #
# - re :		fclean up                                                      #
#                                                                              #
# - sh_nginx / sh_wordpress / sh_mariadb :		Launch a shell in containers   #
# - log_nginx / log_wordpress / log_mariadb :	View output from containers    #
# - top_nginx / top_wordpress / top_mariadb :	Display the running processes  #
#                                                                              #
# - ps :		List containers                                                #
# - image :		List images                                                    #
# - list :		List containers, networks, images, and volumes                 #
#                                                                              #
# - pause :		Pause services                                                 #
# - unpause :	Unpause services                                               #
#                                                                              #
# - start :		Start services                                                 #
# - stop :		Stop services                                                  #
# - restart :	Restart services                                               #
#                                                                              #
# **************************************************************************** #


up: create_directories
	${DOCKER_COMPOSE_COMMAND} up --detach --pull never --build

clean: stop
	sudo docker system prune -a --force

fclean: stop rm_directories
	sudo docker system prune -a --force --volumes
	sudo docker volume rm -f inception_mariadb_volume inception_wordpress_volume

re: fclean up

sh_nginx:
	${DOCKER_COMPOSE_COMMAND} exec nginx sh

sh_mariadb:
	${DOCKER_COMPOSE_COMMAND} exec mariadb sh

sh_wordpress:
	${DOCKER_COMPOSE_COMMAND} exec wordpress sh

log_nginx:
	${DOCKER_COMPOSE_COMMAND} logs --follow nginx
	
log_mariadb:
	${DOCKER_COMPOSE_COMMAND} logs --follow mariadb

log_wordpress:
	${DOCKER_COMPOSE_COMMAND} logs --follow wordpress

top_nginx:
	sudo docker top nginx

top_mariadb:
	sudo docker top mariadb

top_wordpress:
	sudo docker top wordpress

ps:
	${DOCKER_COMPOSE_COMMAND} ps

list:
	@printf "CONTAINERS LIST :\n"
	@sudo docker container ls
	@printf "\nIMAGES LIST :\n"
	@sudo docker image ls
	@printf "\nVOLUMES LIST :\n"
	@sudo docker volume ls
	@printf "\nNETWORKS LIST :\n"
	@sudo docker network ls

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
	mkdir -p ~/data/mariadb ~/data/wordpress

rm_directories:
	rm -rf ~/data/mariadb ~/data/wordpress
