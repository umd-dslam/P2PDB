# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

These are changes that will probably be included in the next release.

## [v0.1.0] - 2019-12-23

### Added

 *  Add Presto to P2PDB's coordinator
    *  Add TimescaleDB connector for Presto to query data from TimeScaleDB deployed on contractor
    *  Test Presto client's Go and Python API to send SQL requests from client to coordinator  
 *  Add pre-commit to check and modify the formats of P2PDB's docs and code
 *  Integrate Travis CI for continuous integration
