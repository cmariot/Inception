# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/31 16:08:49 by cmariot           #+#    #+#              #
#    Updated: 2022/09/08 12:37:33 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE_PATH = srcs/docker-compose.yml

start:
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	docker-compose --verbose -f $(DOCKER_COMPOSE_PATH) up -d

restart:
	docker-compose --verbose -f $(DOCKER_COMPOSE_PATH) restart

stop:
	docker-compose --verbose -f $(DOCKER_COMPOSE_PATH) stop

sh_nginx:
	docker-compose -f $(DOCKER_COMPOSE_PATH) exec nginx sh

sh_mariadb:
	docker-compose -f $(DOCKER_COMPOSE_PATH) exec mariadb sh

sh_wordpress:
	docker-compose -f $(DOCKER_COMPOSE_PATH) exec wordpress sh

list:
	@printf "CONTAINERS LIST :\n"
	@docker container ls
	@printf "\nIMAGES LIST :\n"
	@docker image ls
	@printf "\nVOLUMES LIST :\n"
	@docker volume ls
	@printf "\nNETWORKS LIST :\n"
	@docker network ls

clean: stop
	docker container prune
	docker image prune -a
	docker volume prune
	docker network prune
