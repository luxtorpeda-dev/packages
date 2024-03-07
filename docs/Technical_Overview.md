# Technical Overview

These packages, when using Luxtorpeda, allow the use of open source game engines to be used directly from Steam. This repository contains all the necessary components to build these packages.

A current list of live packages can be found at https://luxtorpeda.org

The engine packages go through the following lifecycle:

* Engine folder and scripts are created and merged
* GitHub Action runs automatically
    * Determines which engine has been changed
    * Increments the version number for the engine
    * Builds the engine & creates the package
    * Uploads the package to Github Releases
    * Updates the packages.json file with the new version and publishes it to GitHub Pages.
