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
        this.mainWindow = mainWindow;
    }

    construct
    {
        set_modal (true);
        set_resizable (false);
        set_deletable (true);
        set_destroy_with_parent (true);
        set_size_request (400, 600);
        set_transient_for (mainWindow);
        set_title (_("Add new source"));
        
        stack = new Gtk.Stack ();
        box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        header_bar = new Hdy.HeaderBar ();
        button_next = new Gtk.Button ();

        box.set_homogeneous (false);

        button_next.set_label (_("Next"));

        header_bar.set_title (_("Add new source"));
        header_bar.show_close_button = true;
        header_bar.pack_end (button_next);

        view_add = new Views.Add (this);
        view_confirm = new Views.ConfirmAdd ();
        stack.add_titled (view_add, "add", _("Add new"));
        stack.add_titled (view_confirm, "confirm", _("Confirm"));

        // connect stack signal to notify::visible-child
        stack.connect ("notify::visible-child", OnStackChildChanged);
        button_next.connect ("clicked", GoNextPage);

        box.add (header_bar);
        box.add (stack);
        
        add (box);
        show_all ();

        button_next.set_visible (false);
    }

    private void OnStackChildChanged (Gtk.Stack stack, string a)
    {
        if (a == "confirm") {
            button_next.set_visible (false);
        }
        else {
            button_next.set_visible (true);
        }
    }

    private void GoNextPage (Gtk.Button button)
    {
        stack.set_visible_child_name ("confirm");
    }
}
