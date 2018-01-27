#!/bin/bash

find . -type f -print -exec sh -c "cat {} | grep 'seconds\|Running'" \;