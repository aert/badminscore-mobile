

bootstrap:
	pip install nodeenv
	nodeenv -p

runserver:
	cd build; python -m SimpleHTTPServer

deploy:
	fab h_remote deploy
