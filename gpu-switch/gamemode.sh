if [ -z "$(xrandr | grep "Screen 0" | grep "2560 x 1440" | cat)" ]; then
    echo "Starting Gamemode"
    pkill picom
	~/.local/scripts/i3-layout save-monitor > /tmp/pre-gamemode.json
    ~/.screenlayout/single-monitor.sh
else
    echo "Stopping Gamemode"
    ~/.local/scripts/picom.sh
    ~/.screenlayout/multi-monitor.sh
	if test -t /tmp/pre-gamemode.json; then
		~/.local/scripts/i3-layout restore-monitor "$(cat /tmp/pre-gamemode.json)"
	fi
fi

