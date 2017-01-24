# Import the environment variables
-include .env

LIBRARY_NAME=playground

NODE_MODULES=./node_modules
SCRIPTS_FOLDER=./.tasks

WEBPACK=$(NODE_MODULES)/.bin/webpack
POSTCSS=$(NODE_MODULES)/.bin/postcss
ESLINT=$(NODE_MODULES)/.bin/eslint
BROWSERSYNC=$(NODE_MODULES)/.bin/browser-sync

WEBPACK_CONFIG=./webpack.config.js
POSTCSS_CONFIG=./postcss.config.js
BROWSERSYNC_CONFIG=./bsync.config.js

SOURCE_PATH=./src
LIBRARY_PATH=./lib
ASSETS_PATH=./assets

DEV_PATH=./demo
DEV_CSS_PATH=$(DEV_PATH)/css
DEV_JS_PATH=$(DEV_PATH)/js


build: js js-minified css

test:
	# check soruce with eslint
	@ $(ESLINT) $(SOURCE_PATH)

js:
	@ LIBRARY_NAME=$(LIBRARY_NAME) \
		LIBRARY_PATH=$(LIBRARY_PATH) \
		SOURCE_PATH=$(SOURCE_PATH) \
		$(WEBPACK) --config $(WEBPACK_CONFIG) \
		--progress --colors --display-error-details

js-minified:
	@ LIBRARY_NAME=$(LIBRARY_NAME) \
		LIBRARY_PATH=$(LIBRARY_PATH) \
		SOURCE_PATH=$(SOURCE_PATH) \
		$(WEBPACK) --config $(WEBPACK_CONFIG) \
		--progress --colors --display-error-details --env.mode=minified

jsdoc:
	# generate js documentation
	@ jsdoc -r \
		-d docs \
		-R README.md \
		src

css: sass postcss

sass:
	# compile the sass files
	@ scss -I $(NODE_MODULES) \
		$(SOURCE_PATH)/style.scss:$(SOURCE_PATH)/style.scss.css \
		-r sass-json-vars

postcss:
	# modify the normal css with postcss
	@ ASSETS_PATH=$(ASSETS_PATH) \
		$(POSTCSS) --config $(POSTCSS_CONFIG) \
		$(SOURCE_PATH)/style.scss.css -o $(LIBRARY_PATH)/$(LIBRARY_NAME).css



dev:
	@ $(SCRIPTS_FOLDER)/utils/parallel \
		"make dev-sync" \
		"make dev-js" \
		"make dev-css"

dev-sync:
	# starting browser sync server for demo
	@ DEV_PATH=$(DEV_PATH) \
		DEV_JS_PATH=$(DEV_JS_PATH) \
		DEV_CSS_PATH=$(DEV_CSS_PATH) \
		BROWSER=$(BROWSERSYNC_BROWSER) \
		PORT=$(BROWSERSYNC_PORT) \
		$(BROWSERSYNC) start \
		--config $(BROWSERSYNC_CONFIG)

dev-js:
	# watch demo js
	@ LIBRARY_NAME=$(LIBRARY_NAME) \
		LIBRARY_PATH=$(LIBRARY_PATH) \
		SOURCE_PATH=$(SOURCE_PATH) \
		DEV_PATH=$(DEV_PATH) \
		DEV_JS_PATH=$(DEV_JS_PATH) \
		$(WEBPACK) --config $(WEBPACK_CONFIG) \
		--progress --colors --watch --display-error-details --env.mode=dev

dev-css:
	# watch demo sass
	@ $(SCRIPTS_FOLDER)/utils/parallel \
		"make dev-sass" \
		"make dev-postcss"

dev-sass:
	# watch the sass files
	@ scss -I $(NODE_MODULES) \
		$(DEV_PATH)/demo.scss:$(DEV_CSS_PATH)/demo.scss.css \
		-r sass-json-vars \
		--watch

dev-postcss:
	# watch generated css file with postcss
	@ ASSETS_PATH=$(ASSETS_PATH) \
	  $(POSTCSS) --config $(POSTCSS_CONFIG) \
		$(DEV_CSS_PATH)/demo.scss.css -o $(DEV_CSS_PATH)/demo.css \
		--watch
