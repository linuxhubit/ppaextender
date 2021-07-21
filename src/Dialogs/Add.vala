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

public class PPAExtender.Dialogs.Add : Hdy.Window
{
    private Gtk.CssProvider css_provider = new Gtk.CssProvider ();
    private Views.Add view_add;
    private Views.ConfirmAdd view_confirm;
    private MainWindow mainWindow;
    private Gtk.Box box;

    public Hdy.HeaderBar header_bar;
    public Gtk.Button button_next;
    public Gtk.Stack stack;

    public string source { get; construct set; }

    public Add(MainWindow mainWindow)
    {
        Object (
            modal: true,
            title: _("Add new source"),
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
        stack = new Gtk.Stack ();
        box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        header_bar = new Hdy.HeaderBar ();
        button_next = new Gtk.Button ();
        view_add = new Views.Add (this);
        view_confirm = new Views.ConfirmAdd (this);

        box.set_homogeneous (false);
        button_next.set_label (_("Next"));

        header_bar.set_title (_("Add new source"));
        header_bar.show_close_button = true;
        header_bar.pack_end (button_next);

        stack.add_titled (view_add, "add", _("Add new"));
        stack.add_titled (view_confirm, "confirm", _("Confirm"));

        box.add (header_bar);
        box.add (stack);
        
        button_next.clicked.connect (() =>
        {
            stack.set_visible_child_name ("confirm");
            button_next.set_visible (false);
        });

        add (box);
        show_all ();

        button_next.set_visible (false);
    }
}
