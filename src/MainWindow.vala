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

public class PPAExtender.MainWindow : Hdy.Window
{
    private Gtk.Box box;
    private Views.List view_list;
    private Widgets.StackSwitcher stack_switcher = new Widgets.StackSwitcher ();

    public Widgets.Headerbar header_bar;

    public MainWindow ()
    {
        GLib.Object
        (
            width_request: 960,
            height_request: 700,
            window_position: Gtk.WindowPosition.CENTER
        );
    }

    construct
    {
        Hdy.init ();
        
        header_bar = new Widgets.Headerbar (this);

        box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        view_list = new Views.List ();

        box.pack_start (header_bar, false, false, 0);
        box.pack_end (view_list, true, true, 0);

        add(box);
    }
}
