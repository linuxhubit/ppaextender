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

        // string[] sources_builtin_list = core_sources.list_builtin ();
        core_sources.list_builtin ();
        core_sources.list_3rdparty ();

        /*
        * add list_store to store source data
        */
        list_store = new Gtk.ListStore (1, typeof (Models.Source));

        foreach(Models.Source source_row in core_sources.sources_builtin) {
            list_store.append (out iter);
            list_store.set (iter, 0, source_row);
        }

        foreach(Models.Source source_row in core_sources.sources_3rdparty) {
            list_store.append (out iter);
            list_store.set (iter, 0, source_row);
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

        Gtk.CellRendererText cell = new Gtk.CellRendererText ();
        tree_view.insert_column_with_data_func (-1, _("Name"), cell, (column, cell, model, iter) => { 
            Models.Source obj;
            model.@get (iter, 0, out obj); 
            (cell as Gtk.CellRendererText).text = obj.name;
        });
        tree_view.insert_column_with_data_func (-1, _("Source"), cell, (column, cell, model, iter) => { 
            Models.Source obj;
            model.@get (iter, 0, out obj); 
            (cell as Gtk.CellRendererText).text = obj.source;
        }); 
        tree_view.insert_column_with_data_func (-1, _("Status"), cell, (column, cell, model, iter) => { 
            Models.Source obj;
            model.@get (iter, 0, out obj); 
            (cell as Gtk.CellRendererText).text = obj.status;
        }); 
        tree_view.insert_column_with_data_func (-1, _("Type"), cell, (column, cell, model, iter) => { 
            Models.Source obj;
            model.@get (iter, 0, out obj); 
            (cell as Gtk.CellRendererText).text = obj.type_of;
        }); 

        /*
        * call Edit dialog when edit_button is clicked
        */
        edit_button.clicked.connect (() => {
            edit_dialog = new Dialogs.Edit ();
            edit_dialog.show_all ();
        });

        show_all ();
    }
}
