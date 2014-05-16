

bootstrap:
	pip install nodeenv
	nodeenv -p

make runserver:
	python -m SimpleHTTPServer
