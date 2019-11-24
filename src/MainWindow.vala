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

public class PPAExtender.MainWindow : Gtk.Window {

    private Views.Add view_add = new Views.Add ();
    private Views.List view_list = new Views.List ();
    private Views.Preferences view_preferences = new Views.Preferences ();

    private Gtk.HeaderBar header_bar;
    private Gtk.StackSwitcher stack_switcher;
    private Granite.ModeSwitch mode_switch;
    private Gtk.Stack stack;

    construct {
        /*
        *  set default window size
        */
        set_size_request (800, 700);

        var gtk_settings = Gtk.Settings.get_default ();

        /*
        *  create switcher for dark/light theme selection
        */
        mode_switch = new Granite.ModeSwitch.from_icon_name ("display-brightness-symbolic", "weather-clear-night-symbolic");
        mode_switch.primary_icon_tooltip_text = ("Light background");
        mode_switch.secondary_icon_tooltip_text = ("Dark background");
        mode_switch.valign = Gtk.Align.CENTER;
        mode_switch.bind_property ("active", gtk_settings, "gtk_application_prefer_dark_theme");

        /*
        *  stack layout
        */
        stack = new Gtk.Stack ();
        stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
        stack.set_transition_duration (300);
        stack.add_titled (view_add, "add", "Add PPA");
        stack.add_titled (view_list, "list", "Show all PPA");
        stack.add_titled (view_preferences, "preferences", "Preferences");
        stack.visible_child_name = "add";

        /*
        * create switcher for stack
        */
        stack_switcher = new Gtk.StackSwitcher ();
        stack_switcher.set_baseline_position (Gtk.BaselinePosition.CENTER);
        stack_switcher.set_stack (stack);

        /*
        *  create header_bar and pack buttons
        */
        header_bar = new Gtk.HeaderBar ();
        header_bar.set_custom_title (stack_switcher);
        header_bar.show_close_button = true;
        header_bar.has_subtitle = true;
        header_bar.pack_end (mode_switch);
        set_titlebar (header_bar);

        add(stack);

    }
}
