#!/bin/bash

cd q2pro

LD_LIBRARY_PATH="./:$LD_LIBRARY_PATH" ./q2pro "$@"
