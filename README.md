# PPAExtender
An application to extend repo on debian/ubuntu based systems.

⚠️ This application is under development.

<div align="center">
  <img src="https://raw.githubusercontent.com/linuxhubit/ppaextender/master/data/screenshot.png">
</div>

## Warning
Edit, delete and add, repository to the system. It may damage and / or corrupt your data.

Neither you nor the developers of your distribution are responsible for what you do with this application.

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
    - Type of source
    - Release chooser [#15 (from old repo)](https://github.com/mirkobrombin/PPAExtender/issues/15)
    - Component editor
    - Disable/Enable [#11 (from old repo)](https://github.com/mirkobrombin/PPAExtender/issues/11)
    - Source URI
    - Delete source
* UI Add dialog
    - Check for correct URI syntax
* UI Preferences
    - Add warning icon for **Pre-released updates**
* UI Show a message when updating cache [#13 (from old repo)](https://github.com/mirkobrombin/PPAExtender/issues/13)
* Core.Sources.list
* Core.Sources.add
* Core.Sources.delete
* Core.Sources.update
