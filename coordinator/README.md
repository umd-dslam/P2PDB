# p2pdb-coordinator

This is a coordinator reference implementation for [P2PDB](https://github.com/DSLAM-UMD/P2PDB) project.

## Coordinator in Docker

1. Build, start and enter the container

```bash
$ bash start-build-env.sh  -v 0.229
$ docker exec -it p2pdb-coordinator-dev bash

# Enter the coordinator's container
[gangl@linuxkit-025000000001 ~]$ ls
anaconda-ks.cfg  coordinator  host

# List presto source code
[gangl@linuxkit-025000000001 ~]$ ls coordinator/presto/
CODE_OF_CONDUCT.md         presto-memory-context
CONTRIBUTING.md            presto-ml
LICENSE                    presto-mongodb
NOTICES                    presto-mysql
README.md                  presto-orc
mvnw                       presto-parquet
pom.xml                    presto-parser
presto-memory              src
...
```

2. Compile Source Code

```bash
$ sudo chmod -R 777  coordinator/presto
$ sudo chmod -R 777  /var/presto
$ cd coordinator/presto/
$ ./mvnw clean install -DskipTests -Dcheckstyle.skip
```

3. Run Presto

The installation directory contains the launcher script in `bin/launcher`. Presto can be started as a daemon by running the following:

```bash
$ export PRESTO_HOME=$HOME/coordinator/presto/presto-server-rpm/target/classes/presto-server-0.231-SNAPSHOT

$ cd $PRESTO_HOME
$ bin/launcher start

Started as 3397

$ jps

3397 PrestoServer
```

4. Command Line Interface

```bash
# Setup Presto cli
$ sudo cp -a $HOME/coordinator/presto/presto-cli/target/presto-cli-0.231-SNAPSHOT-executable.jar /usr/local/bin/presto-cli
$ sudo chmod -v +x /usr/local/bin/presto-cli
$ sudo cp -r $HOME/host/presto/etc $HOME/coordinator/presto/presto-server-rpm/target/classes/presto-server-0.231-SNAPSHOT/
```

5. Connect to TimescaleDB

```bash
# Start Presto server
$ presto-cli --server localhost:8080 --catalog timescaledb --schema default

presto:default> SHOW SCHEMAS FROM timescaledb;

         Schema  
-------------------------
 _timescaledb_cache  
 _timescaledb_catalog  
 _timescaledb_config  
 _timescaledb_internal  
 information_schema  
 pg_catalog  
 public  
 timescaledb_information
(8 rows)

Query 20191213_051353_00004_mg8s8, FINISHED, 1 node
Splits: 19 total, 19 done (100.00%)
0:00 [8 rows, 175B] [28 rows/s, 614B/s]


presto:default> SHOW TABLES FROM timescaledb.public;
 Table  
--------
 table1
(1 row)


presto:default> SELECT * FROM timescaledb.public.table1;
 id | field1
----+--------
 a  | aaaa  
(1 row)

Query 20191213_051627_00011_mg8s8, FINISHED, 1 node
Splits: 17 total, 17 done (100.00%)
0:00 [1 rows, 0B] [4 rows/s, 0B/s]
```
