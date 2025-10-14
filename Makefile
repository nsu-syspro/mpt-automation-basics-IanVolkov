name != jq -r .name config.json
version != jq -r .version config.json

BUILD := build/$(name)
SOURCE := src/wordcount.c
all: $(BUILD)

$(BUILD): $(SOURCE) config.json
	mkdir -p build
	gcc $(SOURCE) -D'NAME="$(name)"' -D'VERSION="$(version)"' -o $(BUILD)

check: $(BUILD) $(wildcard test/*)
	@for i in $(foreach file, $(basename $(wildcard test/*.txt)), "diff <(./$(BUILD) "$(file).txt") "$(file).expected""); do \
		bash -c "$$i" || exit 1; \
	done


clean:
	@rm -f $(BUILD) 
