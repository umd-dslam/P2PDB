# P2PDB

[![License](https://img.shields.io/badge/license-Apache%202-blue.svg)](LICENSE) [![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)


Peer-to-Peer Database (P2PDB) is a secure, scalable, decentralized data sharing and management platform for data publishing, sharing, and querying of data which enables an unlimited number of independent participants to publish and access the contents of datasets stored across the participants.

P2PDB consists of five core components:

- **Publisher**: Produce and ship its structure data to contractors for storage and queryable access, and receive a reward every time the data that they contributed participates in a query result.
- **Client**: Produce static or continuous SQL queries and consume the results.
- **Coordinator**: Receive SQL queries, parse, plan, optimize  and coordinate their parallel execution across potentially many contractors.
- **Contractor**: provide an interface to locally stored data for queries sent from coordinators.
- **Blockchain**: Maintain the configuration and bookkeeping info of the global state of sytem.    

## Contribution

We strictly follow the below stype guides for adding human and machine readable meaning to source code and commit messages.

- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- [Google Style Guides](http://google.github.io/styleguide/)
- [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html)

## Feedback

Your feedback is our motivation to move on. Please let us know your questions, concerns, and issues by [filing Github Issues](https://github.com/DSLAM-UMD/P2PDB/issues).

## Publication

- AnyLog: a Grand Unification of the Internet of Things. **Daniel Abadi**, Owen Arden, Faisal Nawab and Moshe Shadmon. [CIDR'2020](http://cidrdb.org/cidr2020/program.html)

## License

[Apache License 2.0](https://github.com/DSLAM-UMD/P2PDB/blob/master/LICENSE)
