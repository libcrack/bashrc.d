# devnull@libcrack.so
# mar nov 18 05:51:10 CET 2014

# RELATIVE TO $HOME
BASHRC_HOME = .bashrc.d
INSTALL_DIR = ~/$(BASHRC_HOME)

help:
	echo "Please use make <install|clean>"

install:
	if [ -d $(INSTALL_DIR) ]; then \
		printf "\e[31mERROR: Already installed in $(INSTALL_DIR)\e[0m\n"; \
		exit 1; \
	fi
	install -m 755 -d $(INSTALL_DIR)
	install -m 640 -D *.sh* $(INSTALL_DIR)
	grep -q $(BASHRC_HOME) ~/.bashrc \
		|| echo 'for f in $(BASHRC_HOME)/*.sh; do . $$f; done' \
		>> ~/.bashrc
	printf "\e[32mInstalled at $(BASHRC_HOME)\e[0m\n"

clean:
	rm -rf $(INSTALL_DIR)
	sed -e '/$(BASHRC_HOME)/d' -i ~/.bashrc

.SILENT: help install clean
.PHONY: help install clean
