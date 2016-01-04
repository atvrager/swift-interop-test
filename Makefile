SDK=`xcrun --show-sdk-path`
OBJS=test.o main.o cpp.o
DEPS=test.d main.d cpp.d

.PHONY: directories
all: directories $(OBJS) test

%.o: %.swift
	swiftc -sdk $(SDK) -import-objc-header $(<:.swift=-Bridge.h) -emit-objc-header-path gen/$(<:.swift=-swift.h) -emit-module-path gen/$(<:.swift=.swiftmodule) $<
	swiftc -sdk $(SDK) -import-objc-header $(<:.swift=-Bridge.h) -emit-library -emit-dependencies -c $< -o $@

%.o: %.m
	clang -MMD -MP -c $< -o $@

%.o: %.mm
	clang -MMD -MP -c $< -o $@

%.o: %.cc
	clang -MMD -MP -c $< -o $@

test: $(OBJS)
	swiftc $(OBJS) -o test -lc++

directories:
	@mkdir -p gen

.PHONY: clean
clean:
	rm -rf gen
	rm -rf *.d
	rm -rf *.o
	rm -f test

-include $(DEPS)
