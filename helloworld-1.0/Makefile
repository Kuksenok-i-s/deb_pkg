#!/bin/bash
build:
	g++ hello_world.cpp -o hello_world
	echo "Build succeed"
install:
	mkdir -p /opt/hello_world/bin
	mv hello_world /opt/hello_world/bin/hello_world
	ln /opt/hello_world/bin/hello_world /usr/bin/hello_world
uninstall:
	unlink /usr/bin/hello_world
	rm -rf /opt/hello_world
clean:
	rm -f hello_world
