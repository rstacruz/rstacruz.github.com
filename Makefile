PORT ?= 3000

start:
	gem env
	env BUNDLE_GEMFILE=./_/Gemfile bundle exec jekyll serve --drafts --watch --port ${PORT}
