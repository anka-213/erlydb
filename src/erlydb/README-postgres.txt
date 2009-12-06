Testing Erlydb Postgres
=======================

These are the quick and dirty details on how to test ErlyDB works with Postgres.

Please note in order to compile you must have installed Yaws. On Ubuntu 9.10
simply "sudo apt-get install yaws" and the following will work. Alternatively,
just use "make-erlydb.sh" instead of "make all" as it only compiles ErlyDB.

Edit src/erlang-psql-driver/psql.app.src so the 'env' section contains DB details:

  {env, [{erlydb_psql, {"localhost", 5432, "username", "password", "dbname"}},

Now "make app" to build ebin/psql.app from src/erlang-psql-driver/psql.app.src.
You must now "make all" to do the compile.

Execute against these SQL scripts against the database nominated above:

test/erlyweb/music_psql.sql
test/erlydb/erlydb_psql.sql

Load "erl" from the root of the checkout then:

cd("test").
make:all([load]).
cd("..").
code:add_path("ebin").
application:start(crypto).
application:start(psql).
erlydb_test:test(psql).

TROUBLESHOOTING
===============

* Tests will fail if the database has any contents other than that provided by
  the aforementioned SQL statements. So re-execute the SQL if tests fail!

* There are two musician.erl files, one in test/eryldb and the other in the
  examples directory. The above instructions only compile the musician.erl from
  test/erlydb. Tests require musician.beam came from test/erlydb/musician.erl.

* erlydb:code_gen/4 can only recompile a .beam file once. This is because when
  it recompiles a .beam file it loses the original .erl source location. This
  prevents subsequent recompilation. Simply "make clean" then from within erl
  use "make:all([load])." and re-run the above commands.

* If application:start(psql) appears to lock and eventually returns 
  {connection_failed,econnrefused} ensure your pg_hba.conf applicable for the
  connection contains "md5" as the method (not "trust").

