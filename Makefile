# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/31 16:08:49 by cmariot           #+#    #+#              #
#    Updated: 2022/08/31 18:40:04 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


DATABASE_VOLUME		= /var/lib/mysql

WORDPRESS_VOLUME	= /var/www/html


install :
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo DRY_RUN=1 sh get-docker.sh

version :
	docker version

tutorial :
	docker run -d -p 80:80 docker/getting-started

list_process :
	docker ps -a
