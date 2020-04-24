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

public class PPAExtender.Views.List : Gtk.Grid {

    private Gtk.ScrolledWindow scrolled;
    private Gtk.TreeView tree_view;
    private Gtk.ListStore list_store;
    private Gtk.Button edit_button;
    private Gtk.TreeIter iter;

    private Dialogs.Edit edit_dialog;
    private Core.Sources core_sources = new Core.Sources ();

    construct {
        scrolled = new Gtk.ScrolledWindow (null, null);

        /*
        * add list_store to store source data
        */
        list_store = new Gtk.ListStore (4, typeof (string), typeof (string),
                                          typeof (string), typeof (string));

        foreach(Models.Source source_row in core_sources.list()) {
            list_store.append (out iter);
            list_store.set (iter, 0, source_row.name, 1, source_row.source, 2, source_row.status, 3, source_row.type_of);
        }

        foreach(Models.Source source_row in core_sources.list_3rdparty()) {
            list_store.append (out iter);
            list_store.set (iter, 0, source_row.name, 1, source_row.source, 2, source_row.status, 3, source_row.type_of);
        }

        /*
        * add tree_view to display source data
        */
        tree_view = new Gtk.TreeView.with_model (list_store);

        scrolled.expand = true;
        scrolled.get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
        scrolled.add (tree_view);

        /*
        * create edit_button to modify source data
        */
        edit_button = new Gtk.Button.from_icon_name ("edit-symbolic", Gtk.IconSize.BUTTON);
        edit_button.set_tooltip_text(_("Edit selected source"));
        edit_button.halign = Gtk.Align.END;

        attach (scrolled, 0, 0, 1, 1);
        attach (new Gtk.Separator (Gtk.Orientation.HORIZONTAL), 0, 1, 1, 1);
        attach (edit_button, 0, 2, 1, 1);

        tree_view.insert_column_with_attributes (-1, _("Name"), new Gtk.CellRendererText (), "text", 0);
        tree_view.insert_column_with_attributes (-1, _("Source"), new Gtk.CellRendererText (), "text", 1);
        tree_view.insert_column_with_attributes (-1, _("Status"), new Gtk.CellRendererText (), "text", 2);
        tree_view.insert_column_with_attributes (-1, _("Type"), new Gtk.CellRendererText (), "text", 3);

        /*
        * call Edit dialog when edit_button is clicked
        */
        edit_button.clicked.connect (() => {
            Gtk.TreeSelection selection= tree_view.get_selection();
	        selection.set_mode(Gtk.SelectionMode.SINGLE);
	        Gtk.TreeModel model;

	        if (selection.get_selected (out model, out iter))  {
		        string _name, _source, _status, _type_of;
                model.get (iter, 0, out _name, 1, out _source, 2, out _status, 3, out _type_of);
                /*
                * TODO: 
                * - get type/component/release from source
                * - pass clean source as uri
                * - pass status as bool
                */
               stdout.printf(_name);
                edit_dialog = new Dialogs.Edit (new Models.Source(){
                    name = _name,
                    source = _source,
                    status = _status,
                    type_of = _type_of
                });
                edit_dialog.show_all ();
            }
        });

        show_all ();
    }
}

