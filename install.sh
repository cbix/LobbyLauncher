#!/bin/sh
which zenity > /dev/null || (echo "please install zenity first" && exit 1)
PNAME="`zenity --entry --text="tantrix.com user name:"`"
zenity --question --text="Will you keep these files inside `pwd`/ ??" || (echo "move this directory somewhere else and start the installer again" && exit 0)
LDIR="$HOME/.local/share/applications"
STARTER="`pwd`/tantrix"
ICON="`pwd`/tantrix.png"
chmod +x "$STARTER"
mkdir -p "$LDIR"
cat > "$LDIR/tantrix.desktop" << __END_OF_LAUNCHER__
[Desktop Entry]
Type=Application
Version=1.0
Encoding=UTF-8
Name=Tantrix
GenericName=Online Board Game
Comment=start the tantrix.com Lobby as $PNAME
Exec=$STARTER $PNAME
Icon=$ICON
Terminal=false
Categories=Game;BoardGame;StrategyGame;
OnlyShowIn=Unity;GNOME;KDE;Xfce;LXDE;
TargetEnvironment=Unity
StartupWMClass=sun-applet-Main
__END_OF_LAUNCHER__
test -e "$LDIR/tantrix.desktop" || (zenity --error --text="Could not write to $LDIR/tantrix.desktop" && exit 1)
zenity --info --text="Successfully installed"
