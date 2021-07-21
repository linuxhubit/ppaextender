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

public class PPAExtender.Dialogs.Preferences : Hdy.PreferencesWindow
{
    private Gtk.CssProvider css_provider = new Gtk.CssProvider ();
    private MainWindow mainWindow;
    private Hdy.PreferencesGroup settings_appearance;

    public string source { get; construct set; }

    public Preferences(MainWindow mainWindow)
    {
        Object (
            modal: true,
            title: _("Preferences"),
            parent: mainWindow,
            transient_for: mainWindow,
            destroy_with_parent: true,
            deletable: true,
            resizable: false,
            type: Gtk.WindowType.TOPLEVEL,
            window_position: Gtk.WindowPosition.CENTER_ON_PARENT,
            type_hint: Gdk.WindowTypeHint.DIALOG
        );
        this.mainWindow = mainWindow;
    }

    construct
    {
        settings_appearance = new Hdy.PreferencesGroup();
        settings_appearance.set_title(_("Appearance"));

        add (settings_appearance);

        show_all ();
    }
}
