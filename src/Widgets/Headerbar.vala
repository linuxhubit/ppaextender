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

public class PPAExtender.Widgets.Headerbar : Hdy.HeaderBar
{
    private Gtk.Button buttonAdd;
    private Gtk.Button buttonSync;
    private Gtk.Button buttonPreferences;

    private Dialogs.Add dialogAdd;
    private Dialogs.Preferences dialogPreferences;
    private MainWindow mainWindow;

    // private Views.List view_preferences;

    public Headerbar(MainWindow mainWindow)
    {
        Object (
            title: _("PPAExtender"),
            show_close_button: true,
            has_subtitle: false
        );
        this.mainWindow = mainWindow;
    }

    construct
    {
        buttonAdd = new Gtk.Button.from_icon_name("list-add-symbolic");
        buttonAdd.set_tooltip_text(_("Add new source"));

        buttonPreferences = new Gtk.Button.from_icon_name("open-menu-symbolic");
        buttonPreferences.set_tooltip_text(_("Preferences"));

        buttonSync = new Gtk.Button.from_icon_name ("view-refresh-symbolic");
        buttonAdd.set_tooltip_text(_("Refresh sources"));

        buttonAdd.clicked.connect (() =>
        {
            dialogAdd = new Dialogs.Add(mainWindow);
            dialogAdd.show();
        });

        buttonPreferences.clicked.connect (() =>
        {
            dialogPreferences = new Dialogs.Preferences(mainWindow);
            dialogPreferences.show();
        });


        buttonSync.clicked.connect (() =>
        {
        });

        pack_start (buttonAdd);
        pack_start (buttonSync);
        pack_end (buttonPreferences);
    }
}
