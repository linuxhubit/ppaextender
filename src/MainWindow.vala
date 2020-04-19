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

public class PPAExtender.MainWindow : Gtk.Window {

    private Widgets.Headerbar header_bar = new Widgets.Headerbar ();
    private Widgets.Stack stack = new Widgets.Stack ();
    private Widgets.StackSwitcher stack_switcher = new Widgets.StackSwitcher ();

    private Views.Add view_add = new Views.Add ();
    private Views.List view_list = new Views.List ();
    private Views.Preferences view_preferences = new Views.Preferences ();

    construct {
        /*
        *  set default window size
        */
        set_size_request (960, 740);
        set_position(Gtk.WindowPosition.CENTER);

        /*
        *  set stack (index) to stack_switcher
        */
        stack_switcher.set_stack (stack);

        /*
        *  add stack_switcher to header_bar title position
        */
        header_bar.set_custom_title (stack_switcher);

        /*
        *  set header_bar as window titlebar
        */
        set_titlebar (header_bar);

        add(stack);

    }
}
