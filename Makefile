# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/31 16:08:49 by cmariot           #+#    #+#              #
#    Updated: 2022/09/01 08:39:24 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


MARIADB_VOLUME		= /home/data/mariadb
WORDPRESS_VOLUME	= /home/data/wordpress


install :
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo DRY_RUN=1 sh get-docker.sh

version :
	docker version

tutorial :
	docker run -d -p 80:80 docker/getting-started

list_process :
	docker ps -a
