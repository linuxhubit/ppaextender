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

public class PPAExtender.Core.Sources : Object {
    
    private string[] sources_rows;

    /*
    * permissions should be checked on ppaextender startup.
    */
    public string[] list () {
        var sources_file = File.new_for_path ("/etc/apt/sources.list");

        var dis = new DataInputStream (sources_file.read ());
        string row;

        /*
        * populate sources_rows with sources.list rows
        */
        while ((row = dis.read_line (null)) != null) {

            /*
            * check if row has at least 3 characters
            */
            if (row.length > 3) {

                /*
                * check if row is commented
                */
                if ((row.substring (0, 3)).contains ("# ")) {

                    /*
                    * check if commented row is a valid repository
                    * in the future this control should be improved
                    */
                    if (row.contains (" deb ")) {
                        sources_rows += row;
                    }
                } else {
                    sources_rows += row;
                }
            }
        }

        return sources_rows;
    }
}
