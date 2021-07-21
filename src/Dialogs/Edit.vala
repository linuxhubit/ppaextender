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

public class PPAExtender.Dialogs.Edit : Gtk.Dialog
{
    private Gtk.CssProvider cssProvider = new Gtk.CssProvider ();
    private Gtk.Button buttonRemove;
    private Gtk.Button buttonSave;
    private Gtk.ComboBoxText boxType;
    private Gtk.Entry entryUri;
    private Gtk.Entry entryComponent;
    private Gtk.Entry entryRelease;
    private Gtk.Switch switchStatus;

    private static Models.Source _source;

    public Edit (Models.Source source)
    {
        _source = source;
        Object (
            resizable: false, 
            deletable: true, 
            skip_taskbar_hint: true,
            width_request: 500,
            height_request: 600
        );
    }

    construct
    {
        var cssProvider = new Gtk.CssProvider ();

        set_title (_("Editing %s".printf(_source.source)));

        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), cssProvider, Gtk.STYLE_PROVIDER_PRIORITY_USER);

        // create grid (gridEdit) for labels and values
        var gridEdit = new Gtk.Grid ();
        gridEdit.set_margin_top (24);
        gridEdit.set_margin_left (24);
        gridEdit.set_margin_right (24);
        gridEdit.set_margin_bottom (24);
        gridEdit.set_column_spacing (12);
        gridEdit.set_row_spacing (12);
        gridEdit.set_halign (Gtk.Align.CENTER);

        // define the edit labels
        var labelType = new Gtk.Label (_("Type:"));
        labelType.set_halign (Gtk.Align.END);

        var labelRelease = new Gtk.Label (_("Release:"));
        labelRelease.set_halign (Gtk.Align.END);

        var labelComponent = new Gtk.Label (_("Component:"));
        labelComponent.set_halign (Gtk.Align.END);

        var labelEnabled = new Gtk.Label (_("Status:"));
        labelEnabled.set_halign (Gtk.Align.END);

        var labelUri = new Gtk.Label (_("URI:"));
        labelUri.set_halign (Gtk.Align.END);


        // remove comment if present
        if(_source.source.substring (0, 7) == "deb-src")
            _source.source = _source.source.substring (7, _source.source.length -7);

        // get properties of source string
        string[] subParams = _source.source.split(" ");

        // set value fields
        boxType = new Gtk.ComboBoxText ();
        boxType.append ("deb", _("Binary"));
        boxType.append ("deb-src", _("Source code"));
        boxType.set_active_id (_source.source.substring (0, 3) == "deb" ? "deb" : "deb-src");
        gridEdit.attach (boxType, 1, 0, 1, 1);

        entryComponent = new Gtk.Entry ();
        entryComponent.set_placeholder_text ("artful");
        entryComponent.set_text (subParams[2]);
        entryComponent.set_activates_default (false);
        gridEdit.attach (entryComponent, 1, 1, 1, 1);

        entryRelease = new Gtk.Entry ();
        entryRelease.set_placeholder_text ("main");
        entryRelease.set_text (subParams[3]);
        entryRelease.set_activates_default (false);
        gridEdit.attach (entryRelease, 1, 2, 1, 1);

        switchStatus = new Gtk.Switch ();
        switchStatus.set_halign (Gtk.Align.START);
        switchStatus.set_active (_source.status == _("Enabled"));
        gridEdit.attach (switchStatus, 1, 3, 1, 1);

        entryUri = new Gtk.Entry ();
        entryUri.set_placeholder_text (_("https://ppa.launchpad.net/…"));
        entryUri.set_text (subParams[1]);
        entryUri.set_activates_default (false);
        entryUri.set_width_chars (40);
        gridEdit.attach (entryUri, 1,4, 1, 1);

        // populate the grid (gridEdit)
        gridEdit.attach (labelType, 0, 0, 1, 1);
        gridEdit.attach (labelRelease, 0, 1, 1, 1);
        gridEdit.attach (labelComponent, 0, 2, 1, 1);
        gridEdit.attach (labelEnabled, 0, 3, 1, 1);
        gridEdit.attach (labelUri, 0, 4, 1, 1);

        get_content_area ().pack_start (gridEdit, true, true, 0);

        // define action buttons
        buttonRemove = new Gtk.Button.with_label (_("Remove Source"));
        buttonRemove.get_style_context ().add_class ("destructive-action");

        buttonSave = new Gtk.Button.with_label (_("Save"));
        buttonSave.get_style_context ().add_class ("suggested-action");

        // create grid (gridAction) for action buttons
        var gridAction = new Gtk.Grid ();
        gridAction.set_margin_top (24);
        gridAction.set_column_spacing (12);
        gridAction.set_halign (Gtk.Align.CENTER);

        // populate grid (gridAction)
        gridAction.attach (buttonRemove, 0, 0, 1, 1);
        gridAction.attach (buttonSave, 1, 0, 1, 1);

        get_content_area ().pack_end (gridAction, true, true, 0);

        // edit ppa
        buttonSave.clicked.connect (() =>
        {
            // Core.Sources.edit ();
            hide ();
        });

        // remove ppa
        buttonRemove.clicked.connect (() =>
        {
            // Core.Sources.remove ();
            hide ();
        });

        show_all ();
    }
}
