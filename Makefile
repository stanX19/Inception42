# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: myeow <myeow@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/14 15:00:00 by myeow             #+#    #+#              #
#    Updated: 2026/06/14 15:00:00 by myeow            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: up

up:
	@mkdir -p /home/myeow/data/wordpress
	@mkdir -p /home/myeow/data/mariadb
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

clean: down
	@docker system prune -a --force

fclean: clean
	@sudo rm -rf /home/myeow/data

re: fclean all

.PHONY: all up down clean fclean re
