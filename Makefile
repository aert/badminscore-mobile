

bootstrap:
	pip install nodeenv
	nodeenv -p

runserver:
	cd build; python -m SimpleHTTPServer

deploy:
	grunt && fab h_remote deploy
