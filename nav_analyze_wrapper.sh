#!/bin/sh
# Wrapper for nav_analyze
NAV_FILE=${1?Missing file}
NAV_FILE_EDITOR="source-engine-nav-tool"
AREA_COUNT=$("$NAV_FILE_EDITOR" file "$NAV_FILE" info | awk -P '/^area_count:/ { print $2 }')
SUBVERSION=$("$NAV_FILE_EDITOR" file "$NAV_FILE" info | awk -P '/^subversion:/ { print $2 }')
# Create temp file.
TEMP_NAV_FILE=$(tempfile)
cp -f "$NAV_FILE" "$TEMP_NAV_FILE"
if [ ! "$SUBVERSION" -eq 1 ]
then
	for AreaIndex in $(seq 0 $((AREA_COUNT-1)))
	do
		vramsteg --min 0 --max $((AREA_COUNT-1)) --current $((AreaIndex)) --label "Removing encounter paths for area[$((AreaIndex))]" --style text --percentage
		# Remove all encounter paths, if it's not a CS mesh since they are not used in TF2.
		ENCOUNTER_PATH_COUNT=$("$NAV_FILE_EDITOR" file "$TEMP_NAV_FILE" area $AreaIndex info | awk -P '/encounter_path_count:/ { print $2 }')
		if [ "$((ENCOUNTER_PATH_COUNT))" -gt 0 ]
		then
#			for ePathIndex in $(seq 0 $((ENCOUNTER_PATH_COUNT-1)))
#			do
#				vramsteg --min 0 --max $((ENCOUNTER_PATH_COUNT-1)) --current $((ePathIndex)) --label "$(((ENCOUNTER_PATH_COUNT-1)-ePathIndex)) e-paths remaining." --style text
				#pv "$TEMP_NAV_FILE" -F "Removing $((ENCOUNTER_PATH_COUNT)) encounter paths for area[$((AreaIndex))] ($((ENCOUNTER_PATH_COUNT-ePathIndex)) encounter paths remaining.) %p %I" | tr '\n' '\r'
				"$NAV_FILE_EDITOR" -i file "$TEMP_NAV_FILE" area $((AreaIndex)) encounter-path 0 delete $((ENCOUNTER_PATH_COUNT))
				STATUS=$?
				if [ ! "$((STATUS))" -eq 0 ]
				then
					exit 1
				fi
				sleep 0.0005s
#			done
		fi
		sleep "0.1s"
	done
fi
cp -f "$TEMP_NAV_FILE" "$NAV_FILE"
sudo rm "$TEMP_NAV_FILE"
