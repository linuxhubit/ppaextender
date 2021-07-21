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
    private Gtk.Button button_add;
    private Gtk.Button button_preferences;

    public Gtk.Spinner spinner;

    private Dialogs.Add dialog_add;
    private Dialogs.Preferences dialog_preferences;
    private MainWindow mainWindow;

    // private Views.List view_preferences;

    public Headerbar(MainWindow mainWindow)
    {
        this.mainWindow = mainWindow;
    }

    construct
    {
        set_title("PPAExtender");
        // view_preferences = new Views.Preferences();

        button_add = new Gtk.Button.from_icon_name("list-add-symbolic");
        button_add.set_tooltip_text(_("Add new source"));

        button_preferences = new Gtk.Button.from_icon_name("open-menu-symbolic");
        button_preferences.set_tooltip_text(_("Preferences"));

        button_add.clicked.connect (() =>
        {
            dialog_add = new Dialogs.Add(mainWindow);
            dialog_add.show();
        });

        button_preferences.clicked.connect (() =>
        {
            dialog_preferences = new Dialogs.Preferences(mainWindow);
            dialog_preferences.show();
        });
        
        show_close_button = true;
        has_subtitle = true;

        spinner = new Gtk.Spinner ();
        spinner.stop ();

        pack_start (button_add);
        pack_end (spinner);
        pack_end (button_preferences);
    }
}
