# Technical Overview

These packages, when using Luxtorpeda, allow the use of open source game engines to be used directly from Steam. This repository contains all the necessary components to build these packages.

BinTray is used to host the packages. The repository can be found at https://bintray.com/luxtorpeda-dev/assets

A current list of live packages can be found at https://luxtorpeda-dev.github.io/packages.html

The engine packages go through the following lifecycle:

* Engine folder and scripts are created and merged
* GitHub Action runs automatically
    * Determines which engine has been changed
    * Increments the version number for the engine
    * Builds the engine & creates the package
    * Uploads the package to BinTray
    * Updates the packages.json file with the new version and publishes it to GitHub Pages.
