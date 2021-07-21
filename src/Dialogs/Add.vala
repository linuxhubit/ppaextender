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
    private Views.Add viewAdd;
    private Views.ConfirmAdd viewConfirm;
    private MainWindow mainWindow;
    
    private Gtk.CssProvider cssProvider = new Gtk.CssProvider ();
    private Gtk.Box box;
    public Hdy.HeaderBar headerBar;
    public Gtk.Button buttonNext;
    public Gtk.Stack stack;

    public string ppa { get; set; }

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
        headerBar = new Hdy.HeaderBar ();
        buttonNext = new Gtk.Button ();
        viewAdd = new Views.Add (this);
        viewConfirm = new Views.ConfirmAdd (this);

        box.set_homogeneous (false);
        buttonNext.set_label (_("Next"));

        headerBar.set_title (_("Add new source"));
        headerBar.show_close_button = true;
        headerBar.pack_end (buttonNext);

        stack.add_titled (viewAdd, "add", _("Add new"));
        stack.add_titled (viewConfirm, "confirm", _("Confirm"));

        box.add (headerBar);
        box.add (stack);
        
        buttonNext.clicked.connect (() =>
        {
            stack.set_visible_child_name ("confirm");
            buttonNext.set_visible (false);
        });

        add (box);
        show_all ();

        buttonNext.set_visible (false);
    }
}
