all:; dapp build
test:; dapp test
clean:; rm -r out
deploy:; seth send --create 0x"`cat out/DSToken.bin`" -G 3000000
