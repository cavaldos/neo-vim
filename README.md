# Gnome 42.5 (Ubuntu 22.04) only X11

## Feature
- Gnome TopBar


<!-- ## Screenshots
> [Preview](https://raw.githubusercontent.com/phamhiep2506/dotfiles/master/preview.png) -->

![Screenshot from 2022-12-11 19-30-20](https://github.com/khanh1507/k-vim/blob/main/screenshort/1.png)
![Screenshot from 2022-12-11 19-30-03](https://github.com/khanh1507/k-vim/blob/main/screenshort/2.png)

![Screenshot from 2022-12-10 12-06-26](https://github.com/khanh1507/k-vim/blob/main/screenshort/3.png)

![Screenshot from 2022-12-10 12-06-26](https://github.com/khanh1507/k-vim/blob/main/screenshort/4.png)
![Screenshot from 2022-12-10 12-06-26](https://github.com/khanh1507/k-vim/blob/main/screenshort/5.png)


# dotfiles

## Install
:warning: Backup your configuration before installation

```bash
$ git clone https://github.com/cavaldos/k-vim
$ cd k-nvim
$ ./install-k.sh
```

## Auto install dependence
> [dependencies.txt](https://github.com/phamhiep2506/dotfiles/blob/master/dependencies.txt)
- i3wm ([config](https://github.com/phamhiep2506/dotfiles/tree/master/.config/i3))
- alacritty ([config](https://github.com/phamhiep2506/dotfiles/tree/master/.config/alacritty))
- polybar ([config](https://github.com/phamhiep2506/dotfiles/tree/master/.config/polybar))
- picom ([config](https://github.com/phamhiep2506/dotfiles/tree/master/.config/picom))
- dunst ([config](https://github.com/phamhiep2506/dotfiles/tree/master/.config/dunst))
- slock ([config](https://github.com/phamhiep2506/dotfiles/tree/master/slock))
- nvim ([config](https://github.com/phamhiep2506/dotfiles/tree/master/.config/nvim))
- rofi ([config](https://github.com/phamhiep2506/dotfiles/tree/master/.config/rofi))
- ranger ([config](https://github.com/phamhiep2506/dotfiles/tree/master/.config/ranger))
- feh
- ibus-bamboo
- Thunar
- Brave
- Discord
- Telegram
- Theme GTK-[2,3] + Icon TokyoNight
- Cursor theme Breeze
- .Net Core (option)
- Nodejs v16 LTS (option)
- Yarn (option)
- Docker (option)
- Vscode (option)
- python old version (option)

## Mount device USB, MTP,... (udisks2)
```bash
$ lsblk
$ udisksctl mount -b /dev/sdb
$ udisksctl unmount -b /dev/sdb
```

## Fix border
- Install dependence:
```bash
$ pip install pycairo
$ sudo pacman -S libwnck3
$ git clone https://github.com/deter0/xborder
$ cd xborder
$ chmod +x xborders
$ ln -s xborders ~/.local/bin
$ ./xborders --border-radius 10 --border-width 1 --border-blue 255
```

## Fix run ibus-setup
```txt
$ ibus-setup
Traceback (most recent call last):
  File "/usr/share/ibus/setup/main.py", line 33, in <module>
    from gi import require_version as gi_require_version
ModuleNotFoundError: No module named 'gi'
```
> I had the same error message and it was caused by using non-system python interpreter.

- Fix: Run python system `usr/bin/pthon`
```bash
$ /usr/bin/python /usr/share/ibus/setup/main.py
```

## Fix visudo user
```bash
$ sudo EDITOR=nvim visudo
```
> uncomment line
```config
%wheel ALL=(ALL:ALL) ALL
```
> add config
```config
%wheel ALL=(ALL:ALL) NOPASSWD: /usr/bin/systemctl poweroff,/usr/bin/systemctl reboot
```

## Fix Ly display manager
> <kbd>Esc</kbd> : Refresh ly if error show

## i3wm mapping

> :warning: mod => alt

| Key                                                  | Mapping                  |
| ---                                                  | ---                      |
| <kbd>XF86AudioRaiseVolume</kbd>                      | Volume up                |
| <kbd>XF86AudioLowerVolume</kbd>                      | Volume down              |
| <kbd>XF86AudioMute</kbd>                             | Volume mute              |
| <kbd>XF86AudioMicMute</kbd>                          | Mic mute                 |
| <kbd>XF86MonBrightnessUp</kbd>                       | Backlight up             |
| <kbd>XF86MonBrightnessDown</kbd>                     | Backlight down           |
| <kbd>Print</kbd>                                     | Screenshot use flameshot |
| <kbd>alt</kbd> + <kbd>enter</kbd>                    | Open st terminal         |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>enter</kbd> | Open alacritty terminal  |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>q</kbd>     | Kill window              |
| <kbd>alt</kbd> + <kbd>d</kbd>                        | Run rofi                 |
| <kbd>alt</kbd> + <kbd>w</kbd>                        | Run rofi window          |
| <kbd>alt</kbd> + <kbd>e</kbd>                        | Run rofi emoji           |
| <kbd>alt</kbd> + <kbd>h</kbd>                        | Focus left               |
| <kbd>alt</kbd> + <kbd>j</kbd>                        | Focus down               |
| <kbd>alt</kbd> + <kbd>k</kbd>                        | Focus up                 |
| <kbd>alt</kbd> + <kbd>l</kbd>                        | Focus right              |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>h</kbd>     | Move left                |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>j</kbd>     | Move down                |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>k</kbd>     | Move up                  |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>l</kbd>     | Move right               |
| <kbd>alt</kbd> + <kbd>x</kbd>                        | Split horizontal (ngang) |
| <kbd>alt</kbd> + <kbd>v</kbd>                        | Split vertical (doc)     |
| <kbd>alt</kbd> + <kbd>f</kbd>                        | Fullscreen toggle        |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>space</kbd> | Floating toggle          |
| <kbd>alt</kbd> + <kbd>1</kbd>                        | Go to workspace 1        |
| <kbd>alt</kbd> + <kbd>2</kbd>                        | Go to workspace 2        |
| <kbd>alt</kbd> + <kbd>3</kbd>                        | Go to workspace 3        |
| <kbd>alt</kbd> + <kbd>4</kbd>                        | Go to workspace 4        |
| <kbd>alt</kbd> + <kbd>5</kbd>                        | Go to workspace 5        |
| <kbd>alt</kbd> + <kbd>6</kbd>                        | Go to workspace 6        |
| <kbd>alt</kbd> + <kbd>7</kbd>                        | Go to workspace 7        |
| <kbd>alt</kbd> + <kbd>8</kbd>                        | Go to workspace 8        |
| <kbd>alt</kbd> + <kbd>9</kbd>                        | Go to workspace 9        |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>1</kbd>     | Move to workspace 1      |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>2</kbd>     | Move to workspace 2      |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>3</kbd>     | Move to workspace 3      |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>4</kbd>     | Move to workspace 4      |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>5</kbd>     | Move to workspace 5      |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>6</kbd>     | Move to workspace 6      |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>7</kbd>     | Move to workspace 7      |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>8</kbd>     | Move to workspace 8      |
| <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>9</kbd>     | Move to workspace 9      |
| <kbd>alt</kbd> + <kbd>i</kbd>                        | System mode (lock,suspend,shutdow, exit,...) |
| <kbd>alt</kbd> + <kbd>r</kbd>                        | Mode resize              |