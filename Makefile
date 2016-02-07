# devnull@libcrack.so
# mar nov 18 05:51:10 CET 2014

BASHRC_HOME = ~/.bashrc.d

help:
	echo "Please use make <install|clean>"

install:
	if [ -d $(BASHRC_HOME) ]; then \
		echo "Already installed in $(BASHRC_HOME)"; \
		exit 1; \
	fi
	install -m 755 -d $(BASHRC_HOME)
	install -m 640 -D *.sh* $(BASHRC_HOME)
	grep -q $(BASHRC_HOME) ~/.bashrc \
		|| echo 'for f in $(BASHRC_HOME)/*.sh; do . "$f"; done' \
		>> ~/.bashrc

clean:
	rm -rf $(BASHRC_HOME)
	sed -e 's|^.*$(BASHRC_HOME).*\$||g' -i ~/.bashrc

.SILENT: help install clean
.PHONY: help install clean
