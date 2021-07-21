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
    private Gtk.CssProvider cssProvider = new Gtk.CssProvider ();
    private MainWindow mainWindow;

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
        add (pageGeneral ());
        add (pageSources ());

        show_all ();
    }

    private Hdy.PreferencesPage pageGeneral () {
        Hdy.PreferencesPage page = new Hdy.PreferencesPage ();
        page.set_title (_("General"));
        page.set_icon_name ("applications-system-symbolic");

        // Appearance
        Hdy.ActionRow rowDarkMode = new Hdy.ActionRow ();
        rowDarkMode.set_title (_("Theme"));

        Hdy.PreferencesGroup groupAppearance = new Hdy.PreferencesGroup ();
        groupAppearance.title = _("Appearance");
        groupAppearance.add (rowDarkMode);

        page.add (groupAppearance);
        
        return page;
    }

    private Hdy.PreferencesPage pageSources () {
        Hdy.PreferencesPage page = new Hdy.PreferencesPage ();
        page.set_title (_("Sources"));
        page.set_icon_name ("application-x-addon-symbolic");

        // Updates
        Hdy.ActionRow rowSecurity = new Hdy.ActionRow ();
        rowSecurity.set_title (_("Security updates"));

        Hdy.ActionRow rowRecommended = new Hdy.ActionRow ();
        rowRecommended.set_title (_("Recommended updates"));

        Hdy.ActionRow rowUnsupported = new Hdy.ActionRow ();
        rowUnsupported.set_title (_("Unsupported updates"));

        Hdy.ActionRow rowPrereleased = new Hdy.ActionRow ();
        rowPrereleased.set_title (_("Pre-released updates"));

        Hdy.PreferencesGroup groupUpdates = new Hdy.PreferencesGroup ();
        groupUpdates.title = _("Updates");
        groupUpdates.add (rowSecurity);
        groupUpdates.add (rowRecommended);
        groupUpdates.add (rowUnsupported);
        groupUpdates.add (rowPrereleased);

        page.add (groupUpdates);
        
        return page;
    }
}