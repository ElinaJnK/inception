# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: abenamar <abenamar@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/09 12:36:15 by abenamar          #+#    #+#              #
#    Updated: 2024/10/23 17:21:29 by abenamar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := srcs/docker-compose.yml

include $(CURDIR)/srcs/.env

DATA := /home/$(LOGIN)/data

RM := rm -f

all: up

build:
	docker compose -f $(NAME) build

up:
	docker compose -f $(NAME) up --build

down:
	docker compose -f $(NAME) down

clean: down
	sudo $(RM) -r $(DATA)/mariadb && sudo mkdir $(DATA)/mariadb
	sudo $(RM) -r $(DATA)/wordpress && sudo mkdir $(DATA)/wordpress

fclean: clean
	docker volume rm inception_mariadb
	docker volume rm inception_wordpress

re: fclean all

.PHONY: re down fclean clean up build all