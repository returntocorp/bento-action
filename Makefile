release:
	@echo "Releasing bento-action"
	git tag --force v1
	git push --tags --force
