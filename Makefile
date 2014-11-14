

bootstrap:
	pip install nodeenv fabric
	nodeenv -p

bootstrap_end:
	npm install
	bower-exec install
	grunt

runserver:
	cd build; python -m SimpleHTTPServer

deploy:
	grunt && fab h_remote deploy
