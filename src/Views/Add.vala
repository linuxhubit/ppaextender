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

public class PPAExtender.Views.Add : Gtk.Box {

    private Dialogs.Add add_dialog;

    public MainWindow window { get; construct; }
    private Gtk.CssProvider css_provider = new Gtk.CssProvider ();

    public Add () {
        GLib.Object (
            orientation: Gtk.Orientation.VERTICAL,
            spacing: 150
        );
    }

    construct {
        var gtk_settings = Gtk.Settings.get_default ();
        var css_provider = new Gtk.CssProvider ();

        css_provider.load_from_data("
            .source-entry { min-width: 300px; font-size: 15px;}
            .source-validation--waiting { color: grey; }
            .source-validation--success { color: green; }
            .source-validation--failed { color: red; }
        ");

        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);

        var grid = new Gtk.Grid ();
        grid.column_spacing = 12;
        grid.row_spacing = 6;

        grid.halign = Gtk.Align.CENTER;
        grid.valign = Gtk.Align.CENTER;

        var warning_label = new Gtk.Label (_("Be careful. Modifying repositories can damage your system."));
        var warning_infobar = new Gtk.InfoBar ();
        var warning_infobar_content = warning_infobar.get_content_area ();
        warning_infobar_content.add (warning_label);
        warning_infobar.set_message_type (Gtk.MessageType.WARNING);

        var source_label = new Gtk.Label (_("Add new source"));
        source_label.get_style_context ().add_class (Granite.STYLE_CLASS_PRIMARY_LABEL);
        source_label.halign = Gtk.Align.CENTER;
        source_label.xalign = 0;

        var source_description_label = new Gtk.Label (_("Enter the complete PPA URI and press enter."));
        source_description_label.halign = Gtk.Align.CENTER;
        source_description_label.xalign = 0;

        var source_entry = new Gtk.Entry ();
        source_entry.get_style_context ().add_class ("source-entry");
        source_entry.placeholder_text = _("ex: ppa:mirkobrombin/ppa");
        source_entry.set_tooltip_text(_("ex: ppa:mirkobrombin/ppa"));
        source_entry.halign = Gtk.Align.CENTER;

        /* 
        * css classes for source_validation_label:
        * .source-validation--waiting
        * .source-validation--success
        * .source-validation--failed
        */
        var source_validation_label = new Gtk.Label (_("Waiting for PPA to be entered."));
        source_validation_label.get_style_context ().add_class ("source-validation--waiting");
        source_validation_label.halign = Gtk.Align.CENTER;
        source_validation_label.xalign = 0;

        /*
        *  populate grid
        */
        grid.attach (source_label, 0, 0, 1, 1);
        grid.attach (source_description_label, 0, 1, 1, 1);
        grid.attach (source_entry, 0, 2, 1, 1);
        grid.attach (source_validation_label, 0, 3, 1, 1);

        add (warning_infobar);
        add (grid);

        /*
        * validate uri when stop typing in source_entry
        */
        source_entry.key_release_event.connect (() => {

            /*
            * reset source_validation_label style
            */
            source_validation_label.get_style_context ().remove_class ("source-validation--waiting");
            source_validation_label.get_style_context ().remove_class ("source-validation--success");
            source_validation_label.get_style_context ().remove_class ("source-validation--failed");

            /*
             * TODO: perform pattern check for best validation results
            */
            if (source_entry.get_text ().substring (0, 4) == "ppa:" &
                source_entry.get_text ().split("/").length > 1) {
                source_validation_label.get_style_context ().add_class ("source-validation--success");
                source_validation_label.set_text (_("Valid PPA found."));
            } else {
                source_validation_label.get_style_context ().add_class ("source-validation--failed");
                source_validation_label.set_text (_("This PPA doesn't look good."));
            }
        });

        /*
        * add new ppa when hit enter in source_entry
        */
        source_entry.activate.connect (() => {
            stdout.printf ("activate");
            add_dialog = new Dialogs.Add ("a");
            add_dialog.show_all ();
        });

        show_all ();
    }
}

