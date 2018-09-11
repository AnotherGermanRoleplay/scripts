#!/bin/sh

now=$(date)

echo "=========[DAYLIE RESTART]========="
echo "===== Running at: $now ====="

cd /home/v2/data/

## STOP SERVER
if pgrep -x "v2" > /dev/null
then
	# script /dev/null
	screen -r v2 -X kill
fi

## COMMIT SERVERSIDE CHANGES (mostyl bans)
git add .
git commit -m "AUTOMATIC COMMIT: daylie restart!"

## GET CHANGES FROM GIT (and allow automatic merge)
git fetch origin master
git merge --no-edit master
git pull

## UPLOAD TO GIT
git push

## START SERVER (with screen)
sh auto_start.sh

echo "============[FINISHED]============"