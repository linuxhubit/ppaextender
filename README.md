<div align="center">
  <img src="https://raw.githubusercontent.com/linuxhubit/ppaextender/master/data/com.github.linuxhubit.ppaextender.svg" width="64">
  <h1>PPAExtender</h1>
  <p>An application to extend repo on debian/ubuntu based systems.</p>
  <small>⚠️ This application is under development.</small>
  <br />
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
* [x] Edit dialog
    - [x] ~~Type of source~~
    - [x] ~~Release chooser~~ [#15 (from old repo)](https://github.com/mirkobrombin/PPAExtender/issues/15)
    - [x] ~~Component editor~~
    - [x] ~~Disable/Enable~~ [#11 (from old repo)](https://github.com/mirkobrombin/PPAExtender/issues/11)
    - [x] ~~Source URI~~
    - [x] ~~Delete source~~
* [ ] Add dialog
    - [x] ~~Disclaimer~~
    - [ ] Save changes
    - [ ] Delete source
* [ ] Add view
    - [x] ~~PPA UI~~
    - [ ] Flatpak UI
    - [x] ~~Check for correct URI syntax~~
* [x] List view
    - [x] ~~ListStore~~
    - [x] ~~Action buttns~~
    - [x] ~~Method for sync sources~~
* [ ] Preferences
    - [x] ~~Add warning icon for **Pre-released updates**~~
* [ ] (UI) Show a message when updating cache [#13 (from old repo)](https://github.com/mirkobrombin/PPAExtender/issues/13)
* [x] ~~Core.Source.list~~
* [ ] Core.Source.add
* [ ] Core.Source.delete
* [ ] Core.Source.edit
* [ ] Settings
    - [ ] Save settings
    - [ ] Load settings
    - [ ] Make repositories filters working

# Project info
* Based on the [previous](https://github.com/mirkobrombin/PPAExtender) python version (end of life)
* Design inspired by [repoman](https://github.com/pop-os/repoman) (a fork of PPAExtender)

