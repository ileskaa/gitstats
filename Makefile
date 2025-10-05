install:
	@chmod +x gitstats.sh
	@cp gitstats.sh $(HOME)/.local/bin/gitstats
	@echo "gitstats was installed."
	@echo -e "Use it by running \033[1mgitstats\033[0m within a project directory."

uninstall:
	@rm $(HOME)/.local/bin/gitstats
	@echo "gitstats was uninstalled."