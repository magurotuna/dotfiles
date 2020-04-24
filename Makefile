# This Makefile is written thanks to https://github.com/b4b4r07/dotfiles/blob/master/Makefile
DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
_CANDIDATES := $(wildcard .??*) .tmux.conf bin
CANDIDATES := $(shell echo $(_CANDIDATES) | tr " " "\n" | sort | uniq | tr "\n" " ") # .tmux.conf may be duplicate, so check it
EXCLUSIONS := .DS_Store .git .gitmodules .gitignore .github
DOTFILES := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help
.PHONY: list deploy init update test_ci help

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/generate_tmux_conf.sh
	@$(foreach val, $(DOTFILES), $(DOTPATH)/etc/symlink_helper.sh $(abspath $(val)) $(HOME)/$(val);)

init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init.sh

update: ## Fetch changes for this repo
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

test_ci: ## Run test scripts for CI
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/tests/apps_presence.sh

# ref: [超小技!! Makefile に help をつけて「こいつ...できる!」と言われたい - Qiita](https://qiita.com/po3rin/items/7875ef9db5ca994ff762)
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

