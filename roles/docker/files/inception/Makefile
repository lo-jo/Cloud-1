SRCS_PATH = ./srcs/
YML_FILE = docker-compose.yml
COMPOSE_FILE = $(addprefix $(SRCS_PATH), $(YML_FILE))

DB_FOLDER = /data/
DB_PATH = $(addprefix $(HOME), $(DB_FOLDER))

all: header
	@if [ -f $(SRCS_PATH).env ]; then \
		echo "\n$(BOLD)$(GREEN).env file present [ ✔ ]\n$(RESET)"; \
		echo "$(YELLOW)\n. . . Launching . . .\n$(RESET)"; \
		sudo docker compose -f $(COMPOSE_FILE) up --build -d; \
		echo "\n$(BOLD)$(GREEN)Launched [ ✔ ]\n$(RESET)"; \
	else \
		echo "\n$(BOLD)$(RED).env file not found in $(SRCS_PATH) [ x ]\n$(RESET)"; \
	fi

install:
	@echo "$(YELLOW)\n. . . apt updating && upgrading . . . \n$(RESET)"
	@sudo apt-get update 
	@sudo apt-get upgrade -y
	@echo "\n$(BOLD)$(GREEN)apt update && upgrade [ ✔ ]\n$(RESET)"

start:
	@echo "$(YELLOW)\n. . . starting containers . . . \n$(RESET)";
	@if [ -n "$$(docker ps -aq)" ]; then \
		sudo docker compose -f $(COMPOSE_FILE) start; \
		echo "\n$(BOLD)$(GREEN)Containers started [ ✔ ]\n$(RESET)"; \
	else \
		echo "\n$(BOLD)$(RED)No Docker containers found.$(RESET)\n"; \
	fi

stop:
	@echo "$(YELLOW)\n. . . stopping containers . . . \n$(RESET)";
	@if [ -n "$$(docker ps -aq)" ]; then \
		sudo docker compose -f $(COMPOSE_FILE) stop; \
		echo "\n$(BOLD)$(GREEN)Containers stopped [ ✔ ]\n$(RESET)"; \
	else \
		echo "\n$(BOLD)$(RED)No Docker containers found.$(RESET)\n"; \
	fi

restart: stop start
	@if [ -n "$$(sudo docker ps -aq)" ]; then \
		echo "\n$(BOLD)$(GREEN)Containers restarted [ ✔ ]\n$(RESET)"; \
	fi

remove_containers:
	@if [ -n "$$(sudo docker ps -aq)" ]; then \
		echo "$(YELLOW)\n. . . stopping and removing docker containers . . . \n$(RESET)"; \
		sudo docker compose -f $(COMPOSE_FILE) down; \
		echo "\n$(BOLD)$(GREEN)Containers stopped and removed [ ✔ ]\n$(RESET)"; \
	else \
		echo "\n$(BOLD)$(RED)No Docker containers found.$(RESET)\n"; \
	fi

remove_volumes:
	@if [ -n "$$(sudo docker volume ls -q)" ]; then \
		echo "$(YELLOW)\n. . . removing docker volumes . . . \n$(RESET)"; \
		sudo docker compose -f $(COMPOSE_FILE) down --volumes; \
		echo "\n$(BOLD)$(GREEN)Volumes removed [ ✔ ]\n$(RESET)"; \
	else \
		echo "\n$(BOLD)$(RED)No Docker volumes found.\n$(RESET)"; \
	fi

remove_images:
	@if [ -n "$$(sudo docker images -aq)" ]; then \
		echo "$(YELLOW)\n. . . removing docker images . . . \n$(RESET)"; \
		sudo docker compose -f $(COMPOSE_FILE) down --rmi all; \
		echo "\n$(BOLD)$(GREEN)Images removed [ ✔ ]\n$(RESET)"; \
	else \
		echo "\n$(BOLD)$(RED)No Docker images found.\n$(RESET)"; \
	fi

clean: remove_containers remove_volumes remove_images
	@echo "\n$(BOLD)$(GREEN)cleaned [ ✔ ]\n$(RESET)"

fclean: clean prune
	@echo "\n$(BOLD)$(GREEN)fcleaned [ ✔ ]\n$(RESET)"

re: fclean all

prune:
	@echo "$(YELLOW)\n. . . pruning docker system . . . \n$(RESET)"
	@sudo docker system prune -fa
	@echo "\n$(BOLD)$(GREEN)Pruned [ ✔ ]\n$(RESET)"

check_status:
	@echo "\n$(YELLOW)docker ps -a $(RESET)" && docker ps -a
	@echo "\n$(YELLOW)docker volume ls $(RESET)" && docker volume ls
	@echo "\n$(YELLOW)docker images -a $(RESET)" && docker images -a
	@echo "\n$(YELLOW)docker network ls $(RESET)" && docker network ls
	@if [ -d $(DB_PATH) ]; then \
		echo "\n$(YELLOW)ls -la $(DB_PATH) $(RESET)" && ls -la $(DB_PATH); \
	else \
		echo "\n$(YELLOW)ls -la $(DB_PATH) \n$(RESET)No $(DB_PATH) found."; \
	fi

.PHONY: all install restart remove_containers remove_volumes remove_images \
		clean fclean re prune header check_status start stop \
		copy_env_file

define HEADER_PROJECT

	 _                      _   _              
	(_)                    | | (_)             
	 _ _ __   ___ ___ _ __ | |_ _  ___  _ __   
	| | '_ \ / __/ _ \ '_ \| __| |/ _ \| '_ \  
	| | | | | (_|  __/ |_) | |_| | (_) | | | | 
	|_|_| |_|\___\___| .__/ \__|_|\___/|_| |_| 
	                 | |                       
	                 |_|                       

endef
export HEADER_PROJECT

header:
	clear
	@echo "$(BOLD) $(DMAGENTA)$$HEADER_PROJECT $(RESET)"

# COLORS
RESET = \033[0m
WHITE = \033[37m
GREY = \033[90m
RED = \033[91m
DRED = \033[31m
GREEN = \033[92m
DGREEN = \033[32m
YELLOW = \033[93m
DYELLOW = \033[33m
BLUE = \033[94m
DBLUE = \033[34m
MAGENTA = \033[95m
DMAGENTA = \033[35m
CYAN = \033[96m
DCYAN = \033[36m

# FORMAT
BOLD = \033[1m
ITALIC = \033[3m
UNDERLINE = \033[4m
STRIKETHROUGH = \033[9m
