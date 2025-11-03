name != jq -r .name config.json
version != jq -r .version config.json

.PHONY: clean check all

BUILD := build/$(name)
SOURCE := src/wordcount.c
TESTS := $(basename $(wildcard test/*.txt))

all: $(BUILD)

$(BUILD): $(SOURCE) config.json
	mkdir -p build
	gcc $(SOURCE) -D'NAME="$(name)"' -D'VERSION="$(version)"' -o $(BUILD)

check: $(TESTS)
$(TESTS): $(BUILD)
	@bash -c "diff <(./$(BUILD) "$@.txt") "$@.expected" || exit 1"


clean:
	@rm -f $(BUILD)
