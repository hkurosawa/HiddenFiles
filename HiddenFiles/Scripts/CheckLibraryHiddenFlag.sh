#!/bin/sh

#  CheckLibraryHiddenFlag.sh
#  HiddenFiles
#
#  Created by hiroyukik on 2014/03/17.
#  Copyright (c) 2014年 Hiroyuki Kurosawa. All rights reserved.
/bin/ls -dlO ~/Library/|grep "hidden"|wc -l