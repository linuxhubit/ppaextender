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

public class PPAExtender.Views.List : Gtk.Grid
{
    private Gtk.ScrolledWindow scrolled;
    private Gtk.TreeView treeView;
    private Gtk.ListStore listStore;
    private Gtk.Button buttonEdit;
    private Gtk.Button buttonSync;
    private Gtk.Box boxAction;
    private Gtk.TreeIter iter;

    private Dialogs.Edit dialogEdit;

    private Core.Sources coreSources = new Core.Sources ();

    construct
    {
        scrolled = new Gtk.ScrolledWindow (null, null);
        listStore = new Gtk.ListStore (4, typeof (string), typeof (string),
                                          typeof (string), typeof (string));

        populate_listStore ();

        // create treeView to display source data
        treeView = new Gtk.TreeView.with_model (listStore);

        scrolled.expand = true;
        scrolled.get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
        scrolled.add (treeView);

        // create button (buttonEdit) to modify source data
        buttonEdit = new Gtk.Button.from_icon_name ("edit-symbolic", Gtk.IconSize.BUTTON);
        buttonEdit.set_tooltip_text(_("Edit selected source"));
        buttonEdit.halign = Gtk.Align.END;
        buttonEdit.set_relief (Gtk.ReliefStyle.NONE);

        // create button (buttonSync) to update source data
        buttonSync = new Gtk.Button.from_icon_name ("view-refresh-symbolic", Gtk.IconSize.BUTTON);
        buttonSync.set_tooltip_text(_("Sync sources"));
        buttonSync.halign = Gtk.Align.END;
        buttonSync.set_relief (Gtk.ReliefStyle.NONE);

        // create horizontal box for action buttons
        boxAction = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        boxAction.add (buttonEdit);
        boxAction.add (buttonSync);

        attach (scrolled, 0, 0, 1, 1);
        attach (new Gtk.Separator (Gtk.Orientation.HORIZONTAL), 0, 1, 1, 1);
        attach (boxAction, 0, 2, 1, 1);

        treeView.insert_column_with_attributes (-1, _("Name"), new Gtk.CellRendererText (), "text", 0);
        treeView.insert_column_with_attributes (-1, _("Source"), new Gtk.CellRendererText (), "text", 1);
        treeView.insert_column_with_attributes (-1, _("Status"), new Gtk.CellRendererText (), "text", 2);
        treeView.insert_column_with_attributes (-1, _("Type"), new Gtk.CellRendererText (), "text", 3);

        // prompt Edit dialog on buttonEdit click
        buttonEdit.clicked.connect (() =>
        {
            Gtk.TreeSelection selection= treeView.get_selection();
            selection.set_mode(Gtk.SelectionMode.SINGLE);
            Gtk.TreeModel model;

            if (selection.get_selected (out model, out iter))
            {
                string _name, _source, _status, _typeOf;
                model.get (iter, 0, out _name, 1, out _source, 2, out _status, 3, out _typeOf);

                dialogEdit = new Dialogs.Edit (new Models.Source()
                {
                    name = _name,
                    source = _source,
                    status = _status,
                    typeOf = _typeOf
                });

                dialogEdit.show_all ();
            }
        });

        // update sources data on buttonSync click
        buttonSync.clicked.connect (() =>
        {
            listStore.clear ();
            populate_listStore ();
        });

        show_all ();
    }

    // populate listStore with sources
    private void populate_listStore ()
    {
        foreach(Models.Source source_row in coreSources.ListSources())
        {
            listStore.append (out iter);
            listStore.set (iter, 0, source_row.name, 1, source_row.source, 2, source_row.status, 3, source_row.typeOf);
        }

        foreach(Models.Source source_row in coreSources.List3rdSources())
        {
            listStore.append (out iter);
            listStore.set (iter, 0, source_row.name, 1, source_row.source, 2, source_row.status, 3, source_row.typeOf);
        }
    }
}
