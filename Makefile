ERL_LIB = `erl -noshell -eval 'io:format([code:lib_dir()]).' -s erlang halt`
ERLYWEB_ROOT = $(ERL_LIB)/erlyweb-0.7.3

all:
	sh make.sh
	
app: src/erlang-psql-driver/psql.app.src	
	(cd src/erlang-psql-driver && sed "s|Modules|`ls -x -m *.erl | sed 's|.erl||g' | tr \\\n ' '`|g" `basename $<` > ../../ebin/`basename $< .src`)

docs:
	erl -pa `pwd`/ebin \
	-noshell
	-run edoc_run application "'ErlyWeb'" '"."' '[no_packages]'

install:
	cp -r . $(ERLYWEB_ROOT)
	chmod +x $(ERLYWEB_ROOT)/scripts/create_app.sh
	ln -sf $(ERLYWEB_ROOT)/scripts/create_app.sh $(ERL_LIB)/../bin/create_erlyweb_app.sh

clean:
	rm ebin/*.beam
	
cleanapp:
	rm -fv ebin/*.app

cleandocs:
	rm -fv doc/*.html
	rm -fv doc/edoc-info
	rm -fv doc/*.css