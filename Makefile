#  Github user (for user namespace)
MAKEFLAGS += --quiet
# Set the username we need

# Set variables if they are not passed from the command line
# Variable?=Value


all:
	chmod +x $(shell pwd)/*.sh
	ln -s $(shell pwd)/*.sh ${HOME}/.local/bin/

# .PHONY: $(TARGETS)
# $(TARGETS):
# 	echo "$@"
# 	ln -s $(shell pwd)/$@.sh ${HOME}/.local/bin/
# 
