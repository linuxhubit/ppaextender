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

public class PPAExtender.Application : Gtk.Application
{

    public MainWindow? window = null;

    construct
    {
        flags |= ApplicationFlags.HANDLES_OPEN;
        application_id = Constants.APP_ID;
    }

    public static int main (string[] args)
    {
        var app = new Application ();
        return app.run (args);
    }

    public static Application _instance = null;
    public static Application instance
    {
        get
        {
            if (_instance == null)
            {
                _instance = new Application ();
            }
            return _instance;
        }
    }

    public override void activate ()
    {
        if (window == null)
        {
            window = new MainWindow ();
            add_window (window);
            window.show_all ();
        }
        else
        {
            window.present ();
        }
    }
}
