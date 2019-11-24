/*
* Copyright (c) 2019 brombinmirko (https://linuxhub.it)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: brombinmirko <https://linuxhub.it>
*/

public class PPAExtender.Widgets.Headerbar : Gtk.HeaderBar {

    private Granite.ModeSwitch mode_switch;

    construct {

        var gtk_settings = Gtk.Settings.get_default ();

        /*
        *  create switcher for dark/light theme selection
        */
        mode_switch = new Granite.ModeSwitch.from_icon_name ("display-brightness-symbolic", "weather-clear-night-symbolic");
        mode_switch.primary_icon_tooltip_text = ("Light background");
        mode_switch.secondary_icon_tooltip_text = ("Dark background");
        mode_switch.valign = Gtk.Align.CENTER;
        mode_switch.bind_property ("active", gtk_settings, "gtk_application_prefer_dark_theme");
        pack_end (mode_switch);

        show_close_button = true;
        has_subtitle = true;
    }
}
