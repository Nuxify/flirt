# set default shell
SHELL = bash -e -o pipefail

default: run

.PHONY:	install
install:
	fvm flutter pub get

.PHONY:	lint
lint:
	fvm flutter analyze

.PHONY:	test
test:
	echo "TODO: test"

.PHONY:	clean
clean:
	fvm flutter clean

.PHONY:	run
run:
	fvm flutter run

.PHONY:	build-json
build-json:
	fvm flutter pub run build_runner build