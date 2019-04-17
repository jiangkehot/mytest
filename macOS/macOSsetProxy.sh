#! /bin/bash

# Usage: networksetup -getsocksfirewallproxy <networkservice>
# Usage: networksetup -setsocksfirewallproxy <networkservice> <domain> <port number> <authenticated> <username> <password>
# Usage: networksetup -setsocksfirewallproxystate <networkservice> <on off>

# echo <password> | sudo -S networksetup -setwebproxy 'Wi-Fi' 127.0.0.1 <port> && sudo networksetup -setsecurewebproxy 'Wi-Fi' 127.0.0.1 <port>
# networksetup -setwebproxy 'Wi-Fi' 127.0.0.1 1080



function socksOn{
	# networksetup -setsocksfirewallproxystate 'Wi-Fi' 127.0.0.1 1080
	networksetup -setsocksfirewallproxystate 'Wi-Fi' on
	# networksetup -getsocksfirewallproxy 'Wi-Fi' 
}

function socksOff{
	networksetup -setsocksfirewallproxystate 'Wi-Fi' off
}

