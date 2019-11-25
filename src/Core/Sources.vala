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

    private string[] sources_builtin_rows;
    private string[] sources_3rdparty_rows;

    /*
    * list built in sources
    */
    public string[] list_builtin () {
        string path_builtin_sources = "/etc/apt/sources.list";
        string row;

        var sources_file = File.new_for_path (path_builtin_sources);
        var dis = new DataInputStream (sources_file.read ());

        /*
        * populate sources_builtin_rows with sources.list rows
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
                        sources_builtin_rows += row;
                    }
                } else {
                    sources_builtin_rows += row;
                }
            }
        }

        return sources_builtin_rows;
    }

    /*
    * list third party sources
    */
    public string[] list_3rdparty () {
        string path_3rdparty_sources = "/etc/apt/sources.list.d/";
        string row;

        var sources_path = File.new_for_path (path_3rdparty_sources);
        var enumerator = sources_path.enumerate_children (FileAttribute.STANDARD_NAME, FileQueryInfoFlags.NONE, null);

        /*
        * populate sources_3rdparty_files with files in sources.list.dir path
        */
        for ( GLib.FileInfo? info = enumerator.next_file (null) ; info != null ; info = enumerator.next_file (null) ) {
            /*
            * exclude sources backup files (.save)
            */
            if (info.get_name ().substring (info.get_name ().length - 5, 5) != ".save") {
                /*
                * populate sources_3rdparty_rows with source rows
                */
                var sources_file = File.new_for_path (path_3rdparty_sources + info.get_name ());
                var dis = new DataInputStream (sources_file.read ());
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
                                sources_3rdparty_rows += row;
                            }
                        } else {
                            sources_3rdparty_rows += row;
                        }
                    }
                }
            }
        }

        return sources_3rdparty_rows;
    }
}
