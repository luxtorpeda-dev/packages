# Testing Packages

When creating a package, it's best to test it locally to determine that all the necessary steps and built package artifact works as expected. A docker image is used by the automated build process, so the following steps can allow you to test locally:

* Install docker on your machine, using the appropriate instructions for your system.
* Download and run the `registry.gitlab.steamos.cloud/steamrt/sniper/sdk:0.20230405.47175` docker image
* Attach to the running docker container
* Clone the repository that you are wanting to test and make sure to get in its local directory.
* Run the following command to bypass github env need: `export GITHUB_ENV=/root/test.txt`
* Run the following command to start the build `./common/start_build.sh <enginename>`, replacing `<enginename>`.
* Run the following command to create the package `./common/package.sh <enginename>`, replacing `<enginename>`.
