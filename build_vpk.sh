#!/bin/sh
# POSIX baby!
LAUNCH_OPS="${*}"
BINDIR=$(dirname "$(readlink -fn "$0")")
# Configuration
VPK_EXEC="vpk -M"
# Get every nav mesh from the game folder and link them.
# $1 - game folder..
get_meshes() {
	Game=$1
	for NavFile in $(find ./src/"$Game" | sort | grep .nav$)
	do
		ln -s "$(readlink -f "$NavFile")" "$BINDIR/amics_nav_meshes/maps" 2> /dev/null
	done
}

show_help() {
	echo "Usage: $0"
	echo "	-game-<game>	Compile <game> nav meshes into a vpk. <game> is the short hand name of a Source Engine game (e.g tf2 or csgo)."
}

# Launch options.
parse_launchops() {
	for LaunchOP in $LAUNCH_OPS
	do
		case "${LaunchOP?Missing launch option!}" in
			-game-*) get_meshes "${LaunchOP#-game-}";;
			*) printf "Unknown launch option \"%s\"!" "$LaunchOP";;
		esac
	done
}

main() {
	# Help.
	if [ -z "$LAUNCH_OPS" ]
	then
		show_help;
		exit
	fi
	# Needed folder for vpk.
	mkdir -p amics_nav_meshes/maps
	parse_launchops
	$VPK_EXEC amics_nav_meshes
	rm -rf amics_nav_meshes
}

main
