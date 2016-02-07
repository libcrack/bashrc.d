# devnull@libcrack.so
# mar nov 18 05:51:10 CET 2014

BASHRC_HOME = ~/.bashrc.d
ESCAPED_BASHRC_HOME = $(shell sed -e 's/\//\\\//g' <<< $(BASHRC_HOME))

help:
	echo "Please use make <install|clean>"

install:
	if [[ -d $(BASHRC_HOME) ]]; then \
		echo "Already installed in $(BASHRC_HOME)"; \
		exit 1; \
	fi
	install -m 755 -d $(BASHRC_HOME)
	install -m 640 -D *.sh* $(BASHRC_HOME)
	# install -m 640 -t $(BASHRC_HOME) *.sh*
	grep -q $(BASHRC_HOME) ~/.bashrc \
		|| echo '[[ -d $(BASHRC_HOME) ]] && . $(BASHRC_HOME)/*.sh' \
		>> ~/.bashrc

clean:
	rm -rf $(BASHRC_HOME)
	sed -e '/$(ESCAPED_BASHRC_HOME)/d' -i ~/.bashrc

.SILENT: help install clean
.PHONY: help install clean
