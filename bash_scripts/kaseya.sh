#!/bin/bash
# NOTE: I have not coded the feature of removing packages that were installed as part of dependency and no longer needed. 

RECORD_STORE="/tmp/dependency_records"


usage()
{
	echo "USAGE: ./${0##*/}"
	echo "DEPEND PACKAGE_NAME DEPENDENCY_1 [DEPENDENCY_2] ... [DEPENDENCY_N]"
	echo "INSTALL PACKAGE_NAME"
	echo "REMOVE PACKAGE_NAME"
	echo "LIST"
	echo "HELP"
	exit 0
}



END()
{
	if [ "$1" = "END" ]; then 
		echo "Exiting upon user request"
		echo "Cleaning up existing record"
		rm -f $RECORD_STORE
		exit 1
	fi
}

LIST()
{
	if [ ! -f  $RECORD_STORE ]; then 
	echo "No record found"
	else
	while read line; do 
		status=`echo $line | grep INSTALL | wc -l`
		if [ $status -eq 1 ]; then
			pkg_name=`echo $line | cut -d : -f 1 | awk '{print $1}'`
			echo "$pkg_name is INSTALLED"
		fi
	done < $RECORD_STORE
	fi

}


DEPEND()

{
	[ ! -f $RECORD_STORE ] && touch $RECORD_STORE
	[ $# -ge 2 ] && echo $@ >> $RECORD_STORE
}


INSTALL ()
{
	if [ $# -ne 1 ]; then
		echo "Either Package name not entered."
		echo "Or too many package name entered."
	else
		touch $RECORD_STORE
		entry=`grep ^$1 $RECORD_STORE`
		if [ -z "$entry" ]; then
			echo "$1 successfully installed"
			echo "$1 : INSTALLED" >> $RECORD_STORE 
		else
			entry_installed=`grep ^$1 $RECORD_STORE | grep INSTALLED`
			if [ -z "$entry_installed" ]; then
				dep_lst=`echo $entry | cut -d " " -f2-`
				for pkg in $(echo $dep_lst); do
					INSTALL $pkg
				done
				echo "$1 successfully installed"
				sed -i -e "/^$1/ s/$/ : INSTALLED/" $RECORD_STORE
			else
				echo "Package $1 is already installed"
			fi
		fi
	fi
}

REMOVE ()
{
	if [ $# -ne 1 ]; then
                echo "Either Package name not entered."
                echo "Or too many package name entered."
        
	else
		if [ ! -f $RECORD_STORE ]; then 
			echo "Record Store not found. Try installing $1 before removing."
		else
			entry=`grep ^$1 $RECORD_STORE | grep INSTALLED`
			if [ -z "$entry" ]; then
				echo "Package $1 has not been installed yet"
			else
				pkg_need_by=`cat $RECORD_STORE | grep $1 | grep -v ^$1 | grep -v TBR | grep INSTALLED | awk '{print $1}'`
				if [ ! -z "$pkg_need_by" ]; then 
					echo "Can't remove $1. $1 is required by following packages"
					echo "$pkg_need_by"
				else
					echo "Package $1 removed successfully"
                               		sed -i -e "/^$1/ d" $RECORD_STORE
				fi
			fi
		fi
	fi
}

[ $# -ne 0 ] && usage
read -a input

case ${input[0]} in 

END )
	END ${input[0]}
	;;

HELP )
	usage
	;;
DEPEND )
	DEPEND ${input[@]:1} 	
	;;
INSTALL )
	INSTALL ${input[1]}
	;;
REMOVE )
	REMOVE ${input[1]}
	;;
LIST )
	LIST
	;;
* )
	echo "ACTION not recognized"
	usage
	;;
esac

sh  ./$0
