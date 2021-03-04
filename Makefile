# set default shell
SHELL = bash -e -o pipefail

default: run

.PHONY:	install
install:
	flutter pub get

.PHONY:	lint
lint:
	flutter analyze

.PHONY:	test
test:
	echo "TODO: test"

.PHONY:	clean
clean:
	flutter clean

.PHONY:	run
run:
	flutter run

.PHONY:	build-json
build-json:
	flutter pub run build_runner build