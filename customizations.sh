username=$(id -u -n 1000)

# Customizations
nala install xserver-xorg-core x11-xserver-utils psmisc
nala install dunst nitrogen openbox rofi rxvt-unicode tint2 picom libgtk3-perl 
nala install pulseaudio mpd mpc ncmpcpp
nala install alsa-utils brightnessctl imagemagick scrot w3m-img wireless-tools xclip xsettingsd xss-lock
nala install thunar thunar-archive-plugin thunar-volman ffmpegthumbnailer tumbler
#obmenu-generator
echo 'deb http://download.opensuse.org/repositories/home:/Head_on_a_Stick:/obmenu-generator/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/home:Head_on_a_Stick:obmenu-generator.list
curl -fsSL https://download.opensuse.org/repositories/home:Head_on_a_Stick:obmenu-generator/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_Head_on_a_Stick_obmenu-generator.gpg > /dev/null
nala update
nala install obmenu-generator

# Fonts
mkdir -pv ~/.fonts/{Cantarell,Comfortaa,IcoMoon-Custom,Nerd-Patched,Unifont}
wget --no-hsts -cN https://download-fallback.gnome.org/sources/cantarell-fonts/0.303/cantarell-fonts-0.303.1.tar.xz
wget --no-hsts -cNP ~/.fonts/Unifont/ https://unifoundry.com/pub/unifont/unifont-14.0.02/font-builds/unifont-14.0.02.ttf
wget --no-hsts -cNP ~/.fonts/Nerd-Patched/ https://github.com/owl4ce/dotfiles/releases/download/ng/{M+.1mn,Iosevka}.Nerd.Font.Complete.Mono.ttf
wget --no-hsts -cNP ~/.fonts/Nerd-Patched/ https://github.com/owl4ce/dotfiles/releases/download/ng/M+.1mn.Nerd.Font.Complete.mono.ttf
wget --no-hsts -cNP ~/.fonts/IcoMoon-Custom/ https://github.com/owl4ce/dotfiles/releases/download/ng/{Feather,Material}.ttf
wget --no-hsts -cNP ~/.fonts/Comfortaa/ https://raw.githubusercontent.com/googlefonts/comfortaa/main/fonts/OTF/Comfortaa-{Bold,Regular}.otf
tar -xvf cantarell*.tar.xz --strip-components 2 --wildcards -C ~/.fonts/Cantarell/ \*/\*/Cantarell-VF.otf

nala install fonts-font-awesome fonts-noto
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d ~/.fonts
mv dotfonts/fontawesome/otfs/*.otf ~/.fonts/
chown $username:$username ~/.fonts/*
# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# Icons
mkdir -pv ~/.icons
wget --no-hsts -cN https://github.com/owl4ce/dotfiles/releases/download/ng/{Gladient_JfD,Papirus{,-Dark}-Custom}.tar.xz
tar -xf Gladient_JfD.tar.xz -C ~/.icons/
tar -xf Papirus-Custom.tar.xz -C ~/.icons/
tar -xf Papirus-Dark-Custom.tar.xz -C ~/.icons/
sudo ln -vs ~/.icons/Papirus-Custom /usr/share/icons/
sudo ln -vs ~/.icons/Papirus-Dark-Custom /usr/share/icons/
rm {Gladient_JfD.tar.xz,Papirus-Custom.tar.xz,Papirus-Dark-Custom.tar.xz}

# wallpaper
mkdir -pv ~/.wallpapers/{mechanical,eyecandy}
wget -P ~/.wallpaper/mechanical/ https://github.com/owl4ce/depfiles/raw/3.2/.wallpaper/mechanical/mechanical-key_2K.jpg

# Extensions
mkdir -pv ~/.urxvt/ext
(cd ~/.urxvt/ext/; curl -LO https://raw.githubusercontent.com/simmel/urxvt-resize-font/master/resize-font)
(cd ~/.urxvt/ext/; curl -LO https://raw.githubusercontent.com/mina86/urxvt-tabbedex/master/tabbedex)

# Sync
cd ~/Documents/
git clone --depth 1 --recurse-submodules https://github.com/owl4ce/dotfiles.git
rsync -avxHAXP --exclude-from=- dotfiles/. ~/ << "EXCLUDE".git*LICENSE*.mdEXTRA_JOYFULEXCLUDE