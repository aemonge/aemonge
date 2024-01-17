#!/usr/bin/expect

set timeout -1
set command [lindex $argv 0]

# Fetch the password from KWallet
set password [exec kwallet-query -f "Secret Service" -r "pcloud" "kdewallet"]

spawn pcloudcc -k
expect ">"

if {$command == "start"} {
    send "startcrypto $password\r"
} else {
    send "stopcrypto\r"
}

expect ">"
send "quit\r"
