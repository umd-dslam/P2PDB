# P2PDB

[![Build Status](https://travis-ci.org/DSLAM-UMD/P2PDB.svg?branch=develop)](https://travis-ci.org/DSLAM-UMD/P2PDB)
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

## Contribution

We strictly follow the below style guides for adding human and machine readable meaning to source code and commit messages.

- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- [Google Style Guides](http://google.github.io/styleguide/)
- [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html)


### Reach out in Slack

Within the Slack group, you can reach out to us via the `#p2pdb` channel.

For more information on getting the most out of our Slack workspace, see our [Slack welcome page](https://app.slack.com/client/TRK6MGWD7/CRVEFPCS1).

For technical support questions related to Slack, please contact [Slack support](https://slack.com/help).

### Feedback

Your feedback is our motivation to move on. Please let us know your questions, concerns, and issues by [filing Github Issues](https://github.com/DSLAM-UMD/P2PDB/issues).

### Email

Please contact us if you have some IoT data you can contribute our research prototype.

`email: coming@soon`


This email is accessible by P2PDB's executive team and board members.

## Publication

[1] [AnyLog: a Grand Unification of the Internet of Things](http://www.cs.umd.edu/~abadi/papers/anylogAbadiEtAl.pdf). Daniel Abadi, Owen Arden, Faisal Nawab and Moshe Shadmon. [CIDR'2020](http://cidrdb.org/cidr2020/program.html)

[2] [It's time to rethink how we share data on the Web](https://dbmsmusings.blogspot.com/2019/12/its-time-to-rethink-how-we-share-data.html). Daniel Abadi. In DBMS Musings. December 18, 2019.

## License

[Apache License 2.0](https://github.com/DSLAM-UMD/P2PDB/blob/master/LICENSE)
