.PHONY: clean

export UID := $(shell id -u)
export GID := $(shell id -g)

run: prepare
	docker compose up

daemon: prepare
	docker compose up -d

stop:
	docker compose stop

clean:
	docker compose down --remove-orphans
	git clean -fxd data/
	rm -f .env

.env:
	@echo UID=$(UID) > $@
	@echo GID=$(GID) >> $@

reset: clean .env

prepare: .env
