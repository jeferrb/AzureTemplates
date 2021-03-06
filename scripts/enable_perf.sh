#!/bin/bash

# https://unix.stackexchange.com/a/14256 <-- solves the problem
# https://stackoverflow.com/q/44584439/5918489 <-- no need to modify it


sudo sh -c 'echo -1 >/proc/sys/kernel/perf_event_paranoid'
sudo sh -c 'echo 0 > /proc/sys/kernel/kptr_restrict'


sudo sh -c 'echo kernel.perf_event_paranoid=-1 >> /etc/sysctl.d/local.conf'
sudo sh -c 'echo kernel.kptr_restrict=0 >> /etc/sysctl.d/local.conf'
