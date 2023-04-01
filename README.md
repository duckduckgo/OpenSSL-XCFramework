# OpenSSL-XCFramework

## What is this?
This repository keeps OpenSSL packaged as XCFramework with [Swift Package Manager](https://swift.org/package-manager/) support. XCFramework
artifacts are copied over from [krzyzanowskim/OpenSSL](https://github.com/krzyzanowskim/OpenSSL) releases, but this repository contains
no code besides Package.swift, making it lighter and faster to clone compared to upstream.

## Version
This package follows versioning of the [upstream repository](https://github.com/krzyzanowskim/OpenSSL).

## Contributions
We do not accept contributions to this repository at this time.  However, feel free to open an issue in order to start a discussion.

## We are hiring!
DuckDuckGo is growing fast and we continue to expand our fully distributed team. We embrace diverse perspectives, and seek out passionate, self-motivated people, committed to our shared vision of raising the standard of trust online. If you are a senior software engineer capable in either iOS or Android, visit our [careers](https://duckduckgo.com/hiring/#open) page to find out more about our openings!

## Updating from upstream
Run `make_release.sh`, which:

* Creates a temporary directory.
* Checks last upstream release and compares it with local last release. Stops if new release is not available.
* Downloads the XCFramework from upstream repository and computes its checksum.
* Updates Package.swift with the new version and new XCFramework checksum.
* Commits changes, tags the commit, pushes to origin and creates GitHub release.

Once the script is done, you should create PR for macOS browser referencing the new OpenSSL version.
