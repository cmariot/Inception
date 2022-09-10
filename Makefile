# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/31 16:08:49 by cmariot           #+#    #+#              #
#    Updated: 2022/09/06 23:12:13 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE_PATH = srcs/docker-compose.yml

start:
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	sudo docker-compose --verbose  -f $(DOCKER_COMPOSE_PATH) up -d
	sudo docker-compose -f $(DOCKER_COMPOSE_PATH) logs --tail 5 wordpress

restart:
	sudo docker-compose --verbose -f $(DOCKER_COMPOSE_PATH) restart

stop:
	sudo docker-compose --verbose -f $(DOCKER_COMPOSE_PATH) stop

sh_nginx:
	sudo docker-compose -f $(DOCKER_COMPOSE_PATH) exec nginx sh

sh_mariadb:
	sudo docker-compose -f $(DOCKER_COMPOSE_PATH) exec mariadb sh

sh_wordpress:
	sudo docker-compose -f $(DOCKER_COMPOSE_PATH) exec wordpress sh

list:
	@printf "CONTAINERS LIST :\n"
	@sudo docker container ls
	@printf "\nIMAGES LIST :\n"
	@sudo docker image ls
	@printf "\nVOLUMES LIST :\n"
	@sudo docker volume ls
	@printf "\nNETWORKS LIST :\n"
	@sudo docker network ls

clean: stop
	sudo docker system prune -a
