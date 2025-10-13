name != jq -r .name config.json
version != jq -r .version config.json


all: build/$(name) 
build/$(name): src/wordcount.c config.json
	mkdir -p build
	gcc src/wordcount.c -D'NAME="$(name)"' -D'VERSION="$(version)"' -o build/$(name)
clean:
	@rm -f build/$(name)
