/*
* Copyright (c) 2019 Mirko Brombin <send@mirko.pm>
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
* Authored by: Mirko Brombin <https://linuxhub.it>
*/

public class PPAExtender.Views.Preferences : Gtk.Grid
{
    private Gtk.Switch lights_switch;
    private Gtk.Switch security_switch;
    private Gtk.Switch recommended_switch;
    private Gtk.Switch unsupported_switch;
    private Gtk.Switch prereleased_switch;
    private Gtk.Settings gtk_settings = null;

    construct
    {
        if(gtk_settings == null)
            gtk_settings = Gtk.Settings.get_default ();

        column_spacing = 12;
        row_spacing = 6;

        halign = Gtk.Align.CENTER;
        valign = Gtk.Align.CENTER;

        // define labels
        var appearance_label = new Gtk.Label (_("Appearance"));
        appearance_label.get_style_context ().add_class (Gtk.STYLE_CLASS_LABEL);
        appearance_label.xalign = 0;

        var appearance_description_label = new Gtk.Label (_("Change the look of this application."));
        appearance_description_label.get_style_context ().add_class (Gtk.STYLE_CLASS_TITLE);
        appearance_description_label.xalign = 0;

        var selected_mode_label = new Gtk.Label (_("Turn off the lights:"));
        selected_mode_label.xalign = 0;

        var updates_label = new Gtk.Label (_("Updates"));
        updates_label.get_style_context ().add_class (Gtk.STYLE_CLASS_LABEL);
        updates_label.margin_top = 20;
        updates_label.xalign = 0;

        var updates_description_label = new Gtk.Label (_("Choose which updates the system should receive."));
        updates_description_label.get_style_context ().add_class (Gtk.STYLE_CLASS_TITLE);
        updates_description_label.xalign = 0;

        var security_updates_label = new Gtk.Label (_("Security updates:"));
        security_updates_label.xalign = 0;

        var recommended_updates_label = new Gtk.Label (_("Recommended updates:"));
        recommended_updates_label.xalign = 0;

        var unsupported_updates_label = new Gtk.Label (_("Unsupported updates:"));
        unsupported_updates_label.xalign = 0;

        var prereleased_updates_label = new Gtk.Label (_("⚠️ Pre-released updates:"));
        prereleased_updates_label.xalign = 0;

        // define switches
        lights_switch = new Gtk.Switch ();
        lights_switch.halign = Gtk.Align.END;
        lights_switch.valign = Gtk.Align.CENTER;
        lights_switch.hexpand = true;

        security_switch = new Gtk.Switch ();
        security_switch.halign = Gtk.Align.END;
        security_switch.valign = Gtk.Align.CENTER;
        security_switch.hexpand = true;

        recommended_switch = new Gtk.Switch ();
        recommended_switch.halign = Gtk.Align.END;
        recommended_switch.valign = Gtk.Align.CENTER;
        recommended_switch.hexpand = true;

        unsupported_switch = new Gtk.Switch ();
        unsupported_switch.halign = Gtk.Align.END;
        unsupported_switch.valign = Gtk.Align.CENTER;
        unsupported_switch.hexpand = true;

        prereleased_switch = new Gtk.Switch ();
        prereleased_switch.halign = Gtk.Align.END;
        prereleased_switch.valign = Gtk.Align.CENTER;
        prereleased_switch.hexpand = true;

        // populate grid
        attach (appearance_label, 0, 0, 1, 1);
        attach (appearance_description_label, 0, 1, 1, 1);
        attach (selected_mode_label, 0, 2, 1, 1);
        attach (lights_switch, 1, 2, 1, 1);

        attach (updates_label, 0, 3, 1, 1);
        attach (updates_description_label, 0, 4, 1, 1);
        attach (security_updates_label, 0, 5, 1, 1);
        attach (security_switch, 1, 5, 1, 1);
        attach (recommended_updates_label, 0, 6, 1, 1);
        attach (recommended_switch, 1, 6, 1, 1);
        attach (unsupported_updates_label, 0, 7, 1, 1);
        attach (unsupported_switch, 1, 7, 1, 1);
        attach (prereleased_updates_label, 0, 8, 1, 1);
        attach (prereleased_switch, 1, 8, 1, 1);


        lights_switch.state_set.connect (() =>
        {
            toggle_lights ();
        });

        show_all ();
    }

    public void toggle_lights ()
    {
        if(gtk_settings == null)
            return;

        gtk_settings.set_property("gtk-application-prefer-dark-theme", !lights_switch.get_state ());
    }
}
