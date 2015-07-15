#!/bin/bash
#install kali and ubuntu
#---------------------------------------
txtund=$(tput sgr 0 1)          
txtbld=$(tput bold)             
green=$(tput setaf 2)
bldred=${txtbld}$(tput setaf 1)
red_color=$(tput setaf 1) 
color_y=$(tput setaf 3)
bldblu=${txtbld}$(tput setaf 4) 
bldwht=${txtbld}$(tput setaf 7)
txtrst=$(tput sgr0)             
info=${bldwht}*${txtrst}       
pass=${bldblu}*${txtrst}
warn=${bldred}*${txtrst}
ques=${bldblu}?${txtrst}
#---------------------------------------
requeries=true
func_Banner(){
	clear
	echo '   ============================='
	echo "   |$bldblu PEH-wifi-attack Installer$txtrst|"
	echo '   ============================='
	echo "          Version: $(tput setaf 5)0.6.0 $txtrst"
}


install_repo(){
	dist=$(tr -s ' \011' '\012' < /etc/issue | head -n 1)
	if [ $dist = "Ubuntu" ]; then
	    sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
        File="/etc/apt/sources.list"
        if ! grep -q 'deb http://http.kali.org/kali kali main non-free contrib' $File;then
            echo "#PEHinstall" >> /etc/apt/sources.list
		    echo "deb http://http.kali.org/kali kali main non-free contrib" >> /etc/apt/sources.list
		    echo "deb http://security.kali.org/kali-security kali/updates main contrib non-free" >> /etc/apt/sources.list
		    sudo apt-get update
		fi
	fi
}

usage(){
	echo "usage: ./install.sh --install | --uninstall"
}

func_check_install(){
	if which $1 >/dev/null; then
		echo "----[$green✔$txtrst]----[$green+$txtrst] $1 Installed"
	else
		echo "----[$red_color✘$txtrst]----[$red_color-$txtrst] $1 not Installed "
		nome="$1"
		requeries=$nome
	fi
}

function program_is_installed {
	local return_=1
	type $1 >/dev/null 2>&1 || { local return_=0; }
	echo "$return_"
} 

func_install(){
	func_Banner
	if [ "$(id -u)" != "0" ]; then
		echo -e "$(tput setaf 6)[-] This script must be run as root$(tput sgr0)" 1>&2
		exit 1
	fi
	install_repo
	sudo apt-get install python-qt4 -y
	sudo apt-get install ettercap-graphical -y
	sudo apt-get install xterm -y
	sudo apt-get install python-scapy -y
	sudo apt-get install sslstrip -y
	sudo apt-get install nmap -y 
	sudo apt-get install aircrack-ng -y
	sudo apt-get install php5-cli -y
	sudo pip install BeautifulSoup -y
	sudo apt-get install python-nmap
	sudo apt-get install mdk3 -y
	sudo apt-get install wifite -y
	sudo apt-get install theharvester -y
	sudo apt-get install fierce -y
	sudo apt-get install ping -y
	sudo apt-get install whois -y
	sudo apt-get install host -y
	sudo apt-get install tcptraceroute -y
	sudo apt-get install dnsenum -y
	sudo apt-get install dsnmap -y
	sudo apt-get install dsntracer -y
	sudo apt-get install whatweb -y
	sudo apt-get install wafw00f -y
	sudo apt-get install amap -y
	sudo apt-get install tor -y
	sudo apt-get install vidalia -y

    File="/etc/apt/sources.list"
    if  grep -q '#PEH-wifi-attack' $File;then
	    sudo cp /etc/apt/sources.list.backup /etc/apt/sources.list
	    rm /etc/apt/sources.list.backup
    fi
	echo "----------------------------------------"
	echo "[=]$bldblu checking dependencies $txtrst "
	func_check_install "ettercap"
	func_check_install "xterm"
	func_check_install "nmap"
	func_check_install "sslstrip"
	func_check_install "dhcpd"
	func_check_install "aircrack-ng"
	func_check_install "php"
	func_check_install "mdk3"
	func_check_install "wifite"
	func_check_install "theharvester"
	func_check_install "fierce"
	func_check_install "ping"
	func_check_install "whois"
	func_check_install "host"
	func_check_install "tcptraceroute"
	func_check_install "dnsenum"
	func_check_install "dsnmap"
	func_check_install "dsntracer"
	func_check_install "whatweb"
	func_check_install "wafw00f"
	func_check_install "amap"
	func_check_install "tor"
	func_check_install "vidalia"
	echo "----------------------------------------"
	dist=$(tr -s ' \011' '\012' < /etc/issue | head -n 1)
	echo "[$green+$txtrst] Distribution Name: $dist"
	if which dhcpd >/dev/null; then
		echo -e ""
	else
		echo "[$green+$txtrst] dhcpd installer Distribution"
		if [ "$dist" = "Ubuntu" ]; then
			check_dhcp=$(program_is_installed dhcpd)
			if [ $check_dhcp = 0 ]; then
				sudo apt-get install isc-dhcp-server -y
				func_check_install "dhcpd"
			fi
		elif [ "$dist" = "Kali" ]; then
			check_dhcp=$(program_is_installed dhcpd)
			if [ $check_dhcp = 0 ]; then
				sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
				File="/etc/apt/sources.list"
                if ! grep -q 'deb http://ftp.de.debian.org/debian wheezy main' $File;then
				    echo "deb http://ftp.de.debian.org/debian wheezy main" >> /etc/apt/sources.list
				    apt-get update
				    apt-get install isc-dhcp-server -y
				    sudo cp /etc/apt/sources.list.backup /etc/apt/sources.list
				    rm /etc/apt/sources.list.backup
				    func_check_install "dhcpd"
                fi
			fi
		fi
	fi
	echo "----------------------------------------"
	echo "[$color_y=$txtrst]] $bldblu Install PEH-wifi-attack$txtrst"
	if [ ! -d "$DIRECTORY" ]; then
		mkdir $DIRECTORY
		cp -r $path_install /usr/share/PEH-wifi-attack/
		bin_install
		echo "[$green✔$txtrst] PEH-wifi-attack installed with success"
		echo "[$green✔$txtrst] execute $bldred PEH-wifi-attack$txtrst in terminal" 
	else
		rm -r $DIRECTORY
		mkdir $DIRECTORY
		cp -r $path_install /usr/share/PEH-wifi-attack/
		bin_install
		echo "[$green✔$txtrst] PEH-wifi-attack installed with success"
		echo "[$green✔$txtrst] execute $bldred PEH-wifi-attack$txtrst in terminal"
	fi
	echo "[$bldblu+$txtrst]$color_y Edited by Portuguese Ethical Hacker Academy"
	echo "[$bldblu+$txtrst]$color_y P0cL4bs Team CopyRight 2015$txtrst"
	echo "[$bldblu+$txtrst]$bldblu We hope you enjoy this tool!! xD $txtrst"
	echo "[$bldblu+$txtrst]$bldblu By $txtrst $bldred h@ck3rb0lt freelancer$txtrst $bldblu have fun!! $txtrst"
}

bin_install(){
	if [ ! -f "/usr/bin/PEH-wifi-attack" ]; then
		echo "'/usr/share/PEH-wifi-attack/PEH-wifi-attack.py'" >> /usr/bin/PEH-wifi-attack
		chmod +x /usr/bin/PEH-wifi-attack
	fi

	if [ ! -f "/usr/bin/facebook" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./facebook.sh "$@"" >> /usr/bin/facebook
		chmod +x /usr/bin/facebook
	fi

	if [ ! -f "/usr/bin/APF" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./APF.sh "$@"" >> /usr/bin/APF
		chmod +x /usr/bin/APF
	fi

	if [ ! -f "/usr/bin/dork3r" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./dork3r.sh "$@"" >> /usr/bin/dork3r
		chmod +x /usr/bin/dork3r
	fi

	if [ ! -f "/usr/bin/ping" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./ping.sh "$@"" >> /usr/bin/ping
		chmod +x /usr/bin/ping
	fi
	if [ ! -f "/usr/bin/tutorial" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./Tutorial-about.sh "$@"" >> /usr/bin/tutorial
		chmod +x /usr/bin/tutorial
	fi
	if [ ! -f "/usr/bin/PEHsqlmap" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./sqlmap.sh "$@"" >> /usr/bin/PEHsqlmap
		chmod +x /usr/bin/PEHsqlmap
	fi
	if [ ! -f "/usr/bin/PEHwhois" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./whois.sh "$@"" >> /usr/bin/PEHwhois
		chmod +x /usr/bin/PEHwhois
	fi
	if [ ! -f "/usr/bin/PEHnmap" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./nmap.sh "$@"" >> /usr/bin/PEHnmap
		chmod +x /usr/bin/PEHnmap
	fi
	if [ ! -f "/usr/bin/PEHfierce" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./fierce.sh "$@"" >> /usr/bin/PEHfierce
		chmod +x /usr/bin/PEHfierce
	fi
	if [ ! -f "/usr/bin/PEHtheharvester" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./theharvester.sh "$@"" >> /usr/bin/PEHtheharvester
		chmod +x /usr/bin/PEHtheharvester
	fi

	if [ ! -f "/usr/bin/footprint" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./footprint.sh "$@"" >> /usr/bin/footprint
		chmod +x /usr/bin/footprint
	fi
	if [ ! -f "/usr/bin/xerxes" ]; then
		echo "cd /usr/share/PEH-wifi-attack/PEH-toolkit/ && ./xerxes.sh "$@"" >> /usr/bin/xerxes
		chmod +x /usr/bin/xerxes
	fi
}

uninstall(){
	if [ "$(id -u)" != "0" ]; then
		echo -e "$(tput setaf 6)[-] This script must be run as root$(tput sgr0)" 1>&2
		exit 1
	fi
	if [  -d "$DIRECTORY" ]; then
		echo "[$green+$txtrst] delete Path: $DIRECTORY"
		rm -r $path_uninstall
		echo "[$green+$txtrst] delete with success"
		if [ -f "/usr/bin/PEH-wifi-attack" ]; then
			rm /usr/bin/PEH-wifi-attack
			echo "[$red_color-$txtrst] PEH-wifi-attack bin deleted"
		fi

		if [ -f "/usr/bin/facebook" ]; then
			rm /usr/bin/facebook
			echo "[$red_color-$txtrst] facebook bin deleted"
		fi

		if [ -f "/usr/bin/APF" ]; then
			rm /usr/bin/APF
			echo "[$red_color-$txtrst] APF bin deleted"
		fi

		if [ -f "/usr/bin/dork3r" ]; then
			rm /usr/bin/dork3r
			echo "[$red_color-$txtrst] dork3r bin deleted"
		fi

		if [ -f "/usr/bin/ping" ]; then
			rm /usr/bin/ping
			echo "[$red_color-$txtrst] ping bin deleted"
		fi

		if [ -f "/usr/bin/tutorial" ]; then
			rm /usr/bin/tutorial
			echo "[$red_color-$txtrst] tutorial bin deleted"
		fi

		if [ -f "/usr/bin/PEHsqlmap" ]; then
			rm /usr/bin/PEHsqlmap
			echo "[$red_color-$txtrst] sqlmap bin deleted"
		fi

		if [ -f "/usr/bin/PEHwhois" ]; then
			rm /usr/bin/PEHwhois
			echo "[$red_color-$txtrst] whois bin deleted"
		fi

		if [ -f "/usr/bin/PEHnmap" ]; then
			rm /usr/bin/PEHnmap
			echo "[$red_color-$txtrst] nmap bin deleted"
		fi

		if [ -f "/usr/bin/PEHfierce" ]; then
			rm /usr/bin/PEHfierce
			echo "[$red_color-$txtrst] fierce bin deleted"
		fi

		if [ -f "/usr/bin/PEHtheharvester" ]; then
			rm /usr/bin/PEHtheharvester
			echo "[$red_color-$txtrst] theharvester bin deleted"
		fi

		if [ -f "/usr/bin/footprint" ]; then
			rm /usr/bin/footprint
			echo "[$red_color-$txtrst] Ultimate footprint bin deleted"
		fi

		if [ -f "/usr/bin/xerxes" ]; then
			rm /usr/bin/xerxes
			echo "[$red_color-$txtrst] xerxes bin deleted"
		fi

	else
		echo "[$red_color✘$txtrst] PEH-wifi-attack not Installed"
		echo "[$red_color✘$txtrst] facebook not Installed"
		echo "[$red_color✘$txtrst] APF not Installed"
		echo "[$red_color✘$txtrst] dork3r not Installed"
		echo "[$red_color✘$txtrst] ping not Installed"
		echo "[$red_color✘$txtrst] tutorial not Installed"
		echo "[$red_color✘$txtrst] sqlmap not Installed"
		echo "[$red_color✘$txtrst] whois not Installed"
		echo "[$red_color✘$txtrst] nmap not Installed"
		echo "[$red_color✘$txtrst] fierce Installed"
		echo "[$red_color✘$txtrst] theharvester not Installed"
		echo "[$red_color✘$txtrst] Ultimate footprint Installed"
		echo "[$red_color✘$txtrst] xerxes not Installed"
	fi
}
func_Banner
DIRECTORY="/usr/share/PEH-wifi-attack"
Dir_isntall=$(pwd)
path_install=$Dir_isntall"/*"
path_uninstall=$DIRECTORY"/"
while [ "$1" != "" ]; do
    case $1 in
        --install )           shift
                                func_install
                                ;;
        --uninstall )    		uninstall
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

#tools installed you just need on the Terminal:
#echo "[$green✔$txtrst] execute $bldred facebook$txtrst in terminal"
