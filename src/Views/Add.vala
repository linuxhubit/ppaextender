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

public class PPAExtender.Views.Add : Gtk.Box
{
    private Gtk.CssProvider cssProvider = new Gtk.CssProvider ();
    private Gtk.Label labelSourceValidation;
    private Gtk.Entry entrySource;
    private static Dialogs.Add dialogAdd;
    private bool isValid = false;

    public Add (Dialogs.Add dialog)
    {
        this.dialogAdd = dialog;
        GLib.Object
        (
            orientation: Gtk.Orientation.VERTICAL,
            spacing: 40
        );
    }

    construct
    {
        var gtkSettings = Gtk.Settings.get_default ();

        cssProvider.load_from_data(""
            + ".source-entry { min-width: 300px; font-size: 15px;}"
            + ".source-validation--waiting { color: grey; }"
            + ".source-validation--success { color: green; }"
            + ".source-validation--failed { color: red; }"
        );

        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (), 
            cssProvider, 
            Gtk.STYLE_PROVIDER_PRIORITY_USER
        );

        var grid = new Gtk.Grid ();
        grid.column_spacing = 12;
        grid.row_spacing = 6;
        grid.margin = 20;

        grid.halign = Gtk.Align.CENTER;
        grid.valign = Gtk.Align.CENTER;

        // create infobarWarning for disclaimer
        var labelWarning = new Gtk.Label (_("Be careful. Modifying repositories can damage your system."));
        var infobarWarning = new Gtk.InfoBar ();
        var infobarWarning_content = infobarWarning.get_content_area ();
        infobarWarning_content.add (labelWarning);
        infobarWarning.set_message_type (Gtk.MessageType.WARNING);

        var labelSourceDescription = new Gtk.Label (_("Enter the complete PPA URI and press enter."));
        labelSourceDescription.halign = Gtk.Align.CENTER;
        labelSourceDescription.xalign = 0;

        entrySource = new Gtk.Entry ();
        entrySource.get_style_context ().add_class ("source-entry");
        entrySource.placeholder_text = _("ex: ppa:mirkobrombin/ppa");
        entrySource.set_tooltip_text(_("ex: ppa:mirkobrombin/ppa"));
        entrySource.halign = Gtk.Align.CENTER;

        /* css classes for labelSourceValidation:
        * .source-validation--waiting
        * .source-validation--success
        * .source-validation--failed */

        labelSourceValidation = new Gtk.Label (_("Waiting for PPA to be entered."));
        labelSourceValidation.get_style_context ().add_class ("source-validation--waiting");
        labelSourceValidation.halign = Gtk.Align.CENTER;
        labelSourceValidation.xalign = 0;

        // populate grid
        grid.attach (labelSourceDescription, 0, 0, 1, 1);
        grid.attach (entrySource, 0, 1, 1, 1);
        grid.attach (labelSourceValidation, 0, 2, 1, 1);

        add (infobarWarning);
        add (grid);

        // validate uri when stop typing in entrySource
        entrySource.key_release_event.connect (() =>
        {
            source_validation();
        });

        // add new ppa when hit enter in entrySource
        entrySource.activate.connect (() =>
        {
            if(!isValid)
                return;

            dialogAdd.stack.set_visible_child_name ("confirm");
            dialogAdd.ppa = entrySource.get_text ();
        });

        show_all ();
    }

    private void source_validation ()
    {
        // reset labelSourceValidation style
        labelSourceValidation.get_style_context ().remove_class ("source-validation--waiting");
        labelSourceValidation.get_style_context ().remove_class ("source-validation--success");
        labelSourceValidation.get_style_context ().remove_class ("source-validation--failed");

        // TODO: perform pattern check for best validation results
        // Template: ppa:linuxhubit/ppaextender
        string currentText = entrySource.get_text ();
        if(currentText == "")
        {
            labelSourceValidation.get_style_context ().add_class ("source-validation--waiting");
            labelSourceValidation.set_text (_("Waiting for PPA to be entered."));
            dialogAdd.buttonNext.set_visible (false);
        }
        else if (currentText.substring (0, 4) == "ppa:" &
            currentText.split("/").length > 1 &
            currentText.substring (currentText.length -1, 1) != "/")
        {
            labelSourceValidation.get_style_context ().add_class ("source-validation--success");
            labelSourceValidation.set_text (_("Valid PPA found."));
            isValid = true;
            dialogAdd.buttonNext.set_visible (true);
            dialogAdd.ppa = currentText;
        }
        else
        {
            labelSourceValidation.get_style_context ().add_class ("source-validation--failed");
            labelSourceValidation.set_text (_("This PPA doesn't look good."));
            isValid = false;
            dialogAdd.buttonNext.set_visible (false);
        }
    }

}
