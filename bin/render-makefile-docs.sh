#!/bin/bash

# render Makefile targets docs

make > .makefile.docs

# remove terminal color codes
sed -i 's/\x1b\[[0-9;]*m//g' .makefile.docs

# remove make header (first line)
sed -i '1d' .makefile.docs

# remove make footer (last line)
sed -i '$d' .makefile.docs
