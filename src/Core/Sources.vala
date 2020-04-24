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

    /*
    * list sources
    */
    public List<Models.Source> list (
        string sourcesList = "/etc/apt/sources.list",
        string? name = null)
    {
        List<Models.Source> sources = new List<Models.Source>();
        string row;

        var sources_file = File.new_for_path (sourcesList);
        var dis = new DataInputStream (sources_file.read ());

        /*
        * populate sources_builtin_rows with sources.list rows
        */
        while ((row = dis.read_line (null)) != null) {

            /*
            * check if row has at least 3 characters
            */
            if (row.length > 3) {
                Models.Source newRow = new Models.Source ();

                /*
                * check if row is commented
                */
                if (row.contains ("deb") && !row.contains("cdrom:"))
                {
                    newRow.name = name == null ? _("system") : name;
                    newRow.source = row;
                    newRow.status = row.substring (0, 3).contains ("# ") ? _("Disabled") : _("Enabled");
                    newRow.type_of = sourcesList == "/etc/apt/sources.list" ? _("Built-in") : _("3rd-party");

                    sources.append (newRow);
                }
            }
        }

        return sources;
    }

    /*
    * list third party sources
    */
    public List<Models.Source> list_3rdparty () {
        List<Models.Source> sources = new List<Models.Source>();
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
            string fileName = info.get_name ();
            string cleanName = fileName.substring (0,fileName.length - 5);
            if(cleanName.length > 10)
                cleanName = cleanName.substring (0, 15) + " […]";

            if (fileName.substring (fileName.length - 5, 5) != ".save") {
                sources.concat(list(path_3rdparty_sources + fileName, cleanName));
            }
        }

        return sources;
    }

    /*
    * create object from source
    */
    public Models.SourceComponents create_object (string source_line) {
        string[] source_array = source_line.split(" ");
        Models.SourceComponents source_components = new Models.SourceComponents ();
        // deb http://it.archive.ubuntu.com/ubuntu/ bionic-updates universe
        source_components.type_of = source_array[0];
        source_components.release = source_array[3];
        source_components.component = source_array[2];
        source_components.status = source_array[0];
        source_components.uri = source_array[1];
        return source_components;
    }

    /*
    * add new source to the system
    */
   public bool add (string source_line) {
        return true;
   }

    /*
    * delete source from the system
    */
   public bool delete (string source_line) {
        return true;
   }

    /*
    * edit source and save to the system
    */
   public bool edit (string source_line) {
        return true;
   }

    /*
    * update sources and reload list
    */
   public bool update () {
        // delete all entries
        // call list_builtin ();
        // call list_3rdparty ();
        // populate list
        return true;
   }
}

