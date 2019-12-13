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
sudo chmod -R 777  coordinator/presto
cd coordinator/presto/
./mvnw clean install -DskipTests -Dcheckstyle.skip
```
