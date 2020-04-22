# PPAExtender
An application to extend repo on debian/ubuntu based systems.

⚠️ This application is under development.

<div align="center">
  <img src="https://raw.githubusercontent.com/linuxhubit/ppaextender/master/data/screenshot.png" width="300">
  <img src="https://raw.githubusercontent.com/linuxhubit/ppaextender/master/data/screenshot-1.png" width="300">
  <img src="https://raw.githubusercontent.com/linuxhubit/ppaextender/master/data/screenshot-2.png" width="300">
  <img src="https://raw.githubusercontent.com/linuxhubit/ppaextender/master/data/screenshot-3.png" width="300">
  <img src="https://raw.githubusercontent.com/linuxhubit/ppaextender/master/data/screenshot-4.png" width="300">
</div>

## Warning
Modifying system repositories can compromise the functioning of your distribution.

The developers of ppaextender and your distribution are not responsible for any problems.

## Setup
⚠️ This application is still under development, use it with care and only for development purposes.
```
meson build --prefix=/usr
cd build
ninja
sudo ninja install
```

## TODO
* UI Edit dialog
    - ~~Type of source~~
    - ~~Release chooser~~ [#15 (from old repo)](https://github.com/mirkobrombin/PPAExtender/issues/15)
    - ~~Component editor~~
    - ~~Disable/Enable~~ [#11 (from old repo)](https://github.com/mirkobrombin/PPAExtender/issues/11)
    - ~~Source URI~~
    - ~~Delete source~~
* UI Add dialog
    - ~~Disclaimer~~
* UI Add view
    - ~~PPA UI~~
    - Flatpak UI
    - ~~Check for correct URI syntax~~
* UI Preferences
    - ~~Add warning icon for **Pre-released updates**~~
* UI Show a message when updating cache [#13 (from old repo)](https://github.com/mirkobrombin/PPAExtender/issues/13)
* ~~Core.Source.list~~
* Core.Source.add
* Core.Source.delete
* Core.Source.edit
* Core.Source.update

# Project info
* Based on the [previous](https://github.com/mirkobrombin/PPAExtender) python version (end of life)
* Design inspired by [repoman](https://github.com/pop-os/repoman) (a fork of PPAExtender)
