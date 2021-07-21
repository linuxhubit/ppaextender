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

public class PPAExtender.Views.ConfirmAdd : Gtk.Box
{
    private Gtk.CssProvider cssProvider = new Gtk.CssProvider ();

    private Gtk.Button buttonCancel;
    private Gtk.Button buttonSave;
    private static Dialogs.Add dialogAdd;

    public ConfirmAdd (Dialogs.Add dialog)
    {
        this.dialogAdd = dialog;
        GLib.Object
        (
            orientation: Gtk.Orientation.VERTICAL,
            spacing: 40,
            margin: 20
        );
    }

    construct
    {
        var cssProvider = new Gtk.CssProvider ();

        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (), 
            cssProvider, 
            Gtk.STYLE_PROVIDER_PRIORITY_USER
        );

        // define labels
        var labelInfo = new Gtk.Label (
            _("Confirming, you will add this repository to your system."));
        var labelDisclaimer = new Gtk.Label (
            _("Remember that third-party repositories can compromise your system\nmaking it unstable and (sometimes) unusable."));

        // define action buttons
        buttonCancel = new Gtk.Button.with_label (_("Cancel"));
        buttonCancel.get_style_context ().add_class ("suggested-action");

        buttonSave = new Gtk.Button.with_label (_("Save changes"));
        buttonSave.get_style_context ().add_class ("destructive-action");

        // create grid (gridAction) for action buttons
        var gridAction = new Gtk.Grid ();
        gridAction.set_margin_top (24);
        gridAction.set_column_spacing (12);
        gridAction.set_halign (Gtk.Align.CENTER);

        // add widgets to grid (gridAction)
        gridAction.attach (buttonCancel, 0, 0, 1, 1);
        gridAction.attach (buttonSave, 1, 0, 1, 1);

        pack_start (labelInfo);
        pack_start (labelDisclaimer);

        pack_end (gridAction, true, true, 0);

        // add ppa if user confirm action
        buttonSave.clicked.connect (() =>
        {
            dialogAdd.hide ();
            // Posix.system ();
        });

        // user cancel action
        buttonCancel.clicked.connect (() =>
        {
            dialogAdd.stack.set_visible_child_name ("add");
        });

        show_all ();
    }

}
