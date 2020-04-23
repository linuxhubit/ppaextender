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

public class PPAExtender.Dialogs.Add : Gtk.Dialog {

    private Gtk.CssProvider css_provider = new Gtk.CssProvider ();
    private Gtk.Button cancel_button;
    private Gtk.Button save_button;

    public string source { get; construct set; }

    public Add (string source) {
        Object (resizable: false, deletable: true, skip_taskbar_hint: true, source: source);
    }

    construct {
        var css_provider = new Gtk.CssProvider ();

        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);

        height_request = 300;
        width_request = 600;

        /*
        * define the add labels
        */
        var info_label = new Gtk.Label (_("Confirming, you will add this repository to your system."));
        var disclaimer_label = new Gtk.Label (_("Remember that third-party repositories can compromise your system\nmaking it unstable and (sometimes) unusable."));

        /*
        * add labels to the content area
        */
        get_content_area ().pack_start (info_label, true, true, 0);
        get_content_area ().pack_start (disclaimer_label, true, true, 0);

        /*
        *  define the action buttons
        */
        cancel_button = new Gtk.Button.with_label (_("Cancel"));
        cancel_button.get_style_context ().add_class ("suggested-action");

        save_button = new Gtk.Button.with_label (_("Save changes"));
        save_button.get_style_context ().add_class ("destructive-action");

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
        action_grid.attach (cancel_button, 0, 0, 1, 1);
        action_grid.attach (save_button, 1, 0, 1, 1);

        get_content_area ().pack_end (action_grid, true, true, 0);

        /*
        * add ppa if user confirm action
        */
        save_button.clicked.connect (() => {
            stdout.printf ("ADD_PPA");
            // Posix.system ();
        });

        /*
        * user cancel action
        */
        cancel_button.clicked.connect (() => {
            hide ();
        });

        show_all ();
    }
}
