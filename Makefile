FPC = fpc -Fu./lib/linenoise -FE./gen -gl

targets:
	@echo 'targets:'
	@echo '  lysp   : build the lysp interpreter'
	@echo '  run    : make lysp and run'
	@echo '  subs   : fetch the latest code'
	@echo '  clean  : clean up junk files'

subs:
	@git submodule init
	@git submodule update


clean:
	@rm -f gen

gen:
	mkdir -p gen
lysp: gen
	$(FPC) lysp

run: lysp
	gen/lysp
