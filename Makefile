

bootstrap:
	pip install nodeenv
	nodeenv -p

make runserver:
	cd build; python -m SimpleHTTPServer
