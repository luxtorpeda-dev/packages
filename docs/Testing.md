# Testing Packages

When creating a package, it's best to test it locally to determine that all the necessary steps and built package artifact works as expected. A docker image is used by the automated build process, so the following steps can allow you to test locally:

* Install docker on your machine, using the appropriate instructions for your system.
* Download and run the `registry.gitlab.steamos.cloud/steamrt/sniper/sdk:3.0.20250210.116596` docker image
* Attach to the running docker container
* Clone the repository that you are wanting to test and make sure to get in its local directory.
* Run the following command to bypass github env need: `export GITHUB_ENV=/root/test.txt`
* Run the following command to start the build `./common/start_build.sh <enginename>`, replacing `<enginename>`.
* Run the following command to create the package `./common/package.sh <enginename>`, replacing `<enginename>`.

Once you're able to build it, if it's successfully that's a great first step.

If you want to try the build out with luxtorpeda, the easiest way to do that is to launch the game once with luxtorpeda and let it download and play. Then copy the archive you created with the package command above to the proper cache folder in ~/.cache/luxtorpeda, updating the latest file there. That should cause it to use your file instead of the latest on luxtorpeda.
