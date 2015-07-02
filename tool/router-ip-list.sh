#! /bin/zsh
curl -s http://admin:admin@192.168.0.1/userRpm/AssignedIpAddrListRpm.htm | iconv -f gb2312 | grep -E -B2 '192.*,'
