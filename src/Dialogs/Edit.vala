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

public class PPAExtender.Dialogs.Edit : Gtk.Dialog {

    private Gtk.CssProvider css_provider = new Gtk.CssProvider ();
    private Gtk.Button remove_button;
    private Gtk.Button save_button;
    private Gtk.ComboBoxText type_box;
    private Gtk.Entry uri_entry;
    private Gtk.Entry component_entry;
    private Gtk.Entry release_entry;
    private Gtk.Switch status_switch;

    construct {
        var css_provider = new Gtk.CssProvider ();

        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);

        height_request = 500;
        width_request = 600;

        /*
        * create grid for labels and values
        */
        var edit_grid = new Gtk.Grid ();
        edit_grid.set_margin_top (24);
        edit_grid.set_margin_left (24);
        edit_grid.set_margin_right (24);
        edit_grid.set_margin_bottom (24);
        edit_grid.set_column_spacing (12);
        edit_grid.set_row_spacing (12);
        edit_grid.set_halign (Gtk.Align.CENTER);

        /*
        * define the edit labels
        */
        var type_label = new Gtk.Label (_("Type:"));
        type_label.set_halign (Gtk.Align.END);

        var release_label = new Gtk.Label (_("Release:"));
        release_label.set_halign (Gtk.Align.END);

        var component_label = new Gtk.Label (_("Component:"));
        component_label.set_halign (Gtk.Align.END);

        var enabled_label = new Gtk.Label (_("Status:"));
        enabled_label.set_halign (Gtk.Align.END);

        var uri_label = new Gtk.Label (_("URI:"));
        uri_label.set_halign (Gtk.Align.END);


        /*
        * define value fields
        */
        type_box = new Gtk.ComboBoxText ();
        type_box.append ("deb", _("Binary"));
        type_box.append ("deb-src", _("Source code"));
        type_box.set_active_id ("deb");
        edit_grid.attach (type_box, 1, 0, 1, 1);

        component_entry = new Gtk.Entry ();
        component_entry.set_placeholder_text ("artful");
        component_entry.set_text ("artful");
        component_entry.set_activates_default (false);
        edit_grid.attach (component_entry, 1, 1, 1, 1);

        release_entry = new Gtk.Entry ();
        release_entry.set_placeholder_text ("main");
        release_entry.set_text ("main");
        release_entry.set_activates_default (false);
        edit_grid.attach (release_entry, 1, 2, 1, 1);

        status_switch = new Gtk.Switch ();
        status_switch.set_halign (Gtk.Align.START);
        status_switch.set_active (true);
        edit_grid.attach (status_switch, 1, 3, 1, 1);

        uri_entry = new Gtk.Entry ();
        uri_entry.set_placeholder_text ("https://ppa.launchpad.net/...");
        uri_entry.set_text ("ppa:mirkobrombin/ppa");
        uri_entry.set_activates_default (false);
        uri_entry.set_width_chars (40);
        edit_grid.attach (uri_entry, 1,4, 1, 1);

        /*
        *  populate the edit_grid
        */
        edit_grid.attach (type_label, 0, 0, 1, 1);
        edit_grid.attach (release_label, 0, 1, 1, 1);
        edit_grid.attach (component_label, 0, 2, 1, 1);
        edit_grid.attach (enabled_label, 0, 3, 1, 1);
        edit_grid.attach (uri_label, 0, 4, 1, 1);

        get_content_area ().pack_start (edit_grid, true, true, 0);

        /*
        *  define the action buttons
        */
        remove_button = new Gtk.Button.with_label (_("Remove Source"));
        remove_button.get_style_context ().add_class ("destructive-action");

        save_button = new Gtk.Button.with_label (_("Save"));
        save_button.get_style_context ().add_class ("suggested-action");

        /*
        * create grid for action buttons
        */
        var action_grid = new Gtk.Grid ();
        action_grid.set_margin_top (24);
        action_grid.set_column_spacing (12);
        action_grid.set_halign (Gtk.Align.CENTER);

        /*
        *  populate the action_grid
        */
        action_grid.attach (remove_button, 0, 0, 1, 1);
        action_grid.attach (save_button, 1, 0, 1, 1);

        get_content_area ().pack_end (action_grid, true, true, 0);

        show_all ();
    }
}
