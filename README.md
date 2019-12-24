# P2PDB

[![Build Status](https://travis-ci.org/DSLAM-UMD/P2PDB.svg?branch=develop)](https://travis-ci.org/DSLAM-UMD/P2PDB)
[![Join the chat at https://gitter.im/DSLAM-UMD/P2PDB](https://badges.gitter.im/DSLAM-UMD/P2PDB.svg)](https://gitter.im/DSLAM-UMD/P2PDB?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
<a href="https://cla-assistant.io/DSLAM-UMD/P2PDB"><img src="https://cla-assistant.io/readme/badge/DSLAM-UMD/P2PDB" alt="CLA assistant" /></a>
[![Go Report Card](https://goreportcard.com/badge/github.com/DSLAM-UMD/P2PDB)](https://goreportcard.com/report/github.com/DSLAM-UMD/P2PDB) [![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![License](https://img.shields.io/badge/license-Apache%202-blue.svg)](LICENSE)

Peer-to-Peer Database (P2PDB) is a secure, scalable, decentralized data sharing and management platform for data publishing, sharing, and querying of data which enables an unlimited number of independent participants to publish and access the contents of datasets stored across the participants.

P2PDB consists of five core components: Client, Publisher, Coordinator, Contractor and Blockchain.

- [Client](/client)
    - Produce static or continuous SQL queries and consume the results.
- [Publisher](/publisher)
    - Produce and ship its structure data to contractors for storage and queryable access, and receive a reward every time the data that they contributed participates in a query result.
- [Coordinator](/coordinator)
    - Receive SQL queries, parse, plan, optimize  and coordinate their parallel execution across potentially many contractors.
- [Contractor](/contractor)
    - Provide an interface to locally stored data for queries sent from coordinators.
- [Blockchain](/blockchain)
    - Maintain the configuration and bookkeeping info of the global state of system.


## Publication

[1] [It's time to rethink how we share data on the Web](https://dbmsmusings.blogspot.com/2019/12/its-time-to-rethink-how-we-share-data.html). Daniel Abadi. In DBMS Musings. December 18, 2019.

[2] [AnyLog: a Grand Unification of the Internet of Things](http://www.cs.umd.edu/~abadi/papers/anylogAbadiEtAl.pdf). Daniel Abadi, Owen Arden, Faisal Nawab and Moshe Shadmon. CIDR'2020


## Contributing

If you wish to make contributions to this project, please refer to [Contributor Instructions](CONTRIBUTING.md) for more information.

If you have some IoT data you can contribute our research prototype, please contact us by `coming@soon`. This email is only accessible by P2PDB's executive team and board members.


## License

P2PDB resources in this repository are released under the [Apache License 2.0](https://github.com/DSLAM-UMD/P2PDB/blob/master/LICENSE)
