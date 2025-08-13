BODYBOARD_VERSION_REQUESTED=$1

mount -o rw,remount,exec /data

echo "Installing $BODYBOARD_VERSION_REQUESTED bodyboard firmware onto your bot"

mkdir -p /data/bodyboard-firmware-changer
echo "Grabbing dfu program"
curl -o /data/bodyboard-firmware-changer/dfu http://modder.my.to:81/vector-bodyboard/dfu
chmod +rwx /data/bodyboard-firmware-changer/dfu

echo "Grabbing $BODYBOARD_VERSION_REQUESTED bodyboard dfu"
curl -o /data/bodyboard-firmware-changer/$BODYBOARD_VERSION_REQUESTED.dfu http://modder.my.to:81/vector-bodyboard/prod-direct/$BODYBOARD_VERSION_REQUESTED.dfu

echo "Stopping robot processes (Could take a while)"
systemctl stop anki-robot.target
systemctl stop mm-anki-camera
systemctl stop mm-qcamera-daemon
sleep 7
sh /data/bodyboard-firmware-changer/dfu /data/bodyboard-firmware-changer/$BODYBOARD_VERSION_REQUESTED.dfu -f

echo "Sleeping for 5 seconds to be sure all robot processes are stopped"
sleep 5

echo "Starting mm-qcamera-daemon"
systemctl start mm-qcamera-daemon
sleep 2
echo "Starting mm-anki-camera"
systemctl start mm-anki-camera
sleep 2 
echo "Starting robot processes"
systemctl start anki-robot.target

echo "Removing temp files"
rm -rf /data/bodyboard-firmware-changer/