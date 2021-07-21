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

public class PPAExtender.Dialogs.Edit : Hdy.Window
{
    private MainWindow mainWindow;

    private Gtk.CssProvider cssProvider = new Gtk.CssProvider ();
    private Gtk.Button buttonRemove;
    private Gtk.Button buttonSave;
    private Gtk.ComboBoxText comboType;
    private Gtk.Entry entryUri;
    private Gtk.Entry entryComponent;
    private Gtk.Entry entryRelease;
    private Gtk.Switch switchStatus;
    private Gtk.Box boxActions;
    private Gtk.Box box;
    private Gtk.Grid gridEdit;
    public Hdy.HeaderBar headerBar;

    private static Models.Source _source;

    public Edit (MainWindow mainWindow, Models.Source source)
    {
        this._source = source;

        Object (
            modal: true,
            title: _("Editing %s".printf(_source.source)),
            parent: mainWindow,
            transient_for: mainWindow,
            destroy_with_parent: true,
            deletable: true,
            resizable: false,
            type: Gtk.WindowType.TOPLEVEL,
            window_position: Gtk.WindowPosition.CENTER_ON_PARENT,
            type_hint: Gdk.WindowTypeHint.DIALOG
        );
    }

    construct
    {
        headerBar = new Hdy.HeaderBar ();
        box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        boxActions = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 20);
        gridEdit = EditGrid ();

        headerBar.set_title (_("Edit source"));
        headerBar.show_close_button = true;

        box.add (headerBar);

        // create grid (gridEdit) for labels and values

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

        if(_source.source.substring (0, 7) == "deb-src")
            _source.source = _source.source.substring (7, _source.source.length -7);

        // get properties of source string
        string[] subParams = _source.source.split(" ");

        // set value fields
        comboType = new Gtk.ComboBoxText ();
        comboType.append ("deb", _("Binary"));
        comboType.append ("deb-src", _("Source code"));
        comboType.set_active_id (_source.source.substring (0, 3) == "deb" ? "deb" : "deb-src");
        gridEdit.attach (comboType, 1, 0, 1, 1);

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
        switchStatus.set_active (_source.status == true);
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

        box.add (gridEdit);

        // define action buttons
        buttonRemove = new Gtk.Button.with_label (_("Remove Source"));
        buttonRemove.get_style_context ().add_class ("destructive-action");

        buttonSave = new Gtk.Button.with_label (_("Save"));
        buttonSave.get_style_context ().add_class ("suggested-action");

        boxActions.set_halign (Gtk.Align.CENTER);
        boxActions.set_margin_bottom (24);
        boxActions.add (buttonRemove);
        boxActions.add (buttonSave);

        box.add (boxActions);

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

        add (box);
        show_all ();
    }

    private Gtk.Grid EditGrid ()
    {
        var grid = new Gtk.Grid ();
        grid.set_margin_top (24);
        grid.set_margin_left (24);
        grid.set_margin_right (24);
        grid.set_margin_bottom (24);
        grid.set_column_spacing (12);
        grid.set_row_spacing (12);
        grid.set_halign (Gtk.Align.CENTER);

        return grid;
    }
}
