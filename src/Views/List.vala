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

public class PPAExtender.Views.List : Gtk.ScrolledWindow
{
    private Hdy.Clamp clamp;
    private Gtk.CssProvider cssProvider = new Gtk.CssProvider ();
    
    private MainWindow mainWindow;
    private Dialogs.Edit dialogEdit;

    private Core.Sources coreSources = new Core.Sources ();

    public List(MainWindow mainWindow)
    {
        Object (
            expand: true
        );
        this.mainWindow = mainWindow;
    }

    construct
    {
        Gtk.ListBox sourcesListBox = SourcesListBox ();
        clamp = new Hdy.Clamp ();

        clamp.set_maximum_size (600);
        clamp.set_tightening_threshold (600);

        cssProvider.load_from_data(""
            + ".disabled { opacity: 0.5}"
        );

        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (), 
            cssProvider, 
            Gtk.STYLE_PROVIDER_PRIORITY_USER
        );

        foreach(Models.Source source_row in coreSources.ListSources())
        {
            sourcesListBox.add (SourceEntry (
                source_row.name,
                source_row.source,
                source_row.status,
                source_row.typeOf
            ));
        }

        foreach(Models.Source source_row in coreSources.List3rdSources())
        {
            sourcesListBox.add (SourceEntry (
                source_row.name,
                source_row.source,
                source_row.status,
                source_row.typeOf
            ));
        }

        clamp.add (sourcesListBox);
        add (clamp);
        show_all ();
    }

    private Hdy.ActionRow SourceEntry (string name, string source, bool status, string typeOf)
    {
        Hdy.ActionRow row = new Hdy.ActionRow ();
        row.set_title(name);
        row.set_subtitle(source);
        if (!status)
            row.get_style_context().add_class("disabled");

        Gtk.Button buttonEdit = new Gtk.Button.from_icon_name ("edit-symbolic", Gtk.IconSize.BUTTON);
        buttonEdit.set_tooltip_text(_("Edit selected source"));
        buttonEdit.get_style_context ().add_class ("circular");
        buttonEdit.halign = Gtk.Align.END;
        buttonEdit.valign = Gtk.Align.CENTER;

        row.add (buttonEdit);
        buttonEdit.clicked.connect (() =>
        {
            dialogEdit = new Dialogs.Edit (
                mainWindow,
                new Models.Source()
                {
                    name = name,
                    source = source,
                    status = status,
                    typeOf = typeOf
                }
            );

            dialogEdit.show_all ();
        });

        return row;
    }

    private Gtk.ListBox SourcesListBox ()
    {
        Gtk.ListBox listBox = new Gtk.ListBox ();
        listBox.get_style_context ().add_class ("content");
        listBox.set_margin_top (20);
        listBox.set_margin_bottom (20);

        return listBox;
    }
}
