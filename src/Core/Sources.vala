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

public class PPAExtender.Core.Sources : Object
{
    // List sources
    public List<Models.Source> ListSources (
        string sourcesList = "/etc/apt/sources.list",
        string? name = null)
    {
        List<Models.Source> sources = new List<Models.Source>();
        string row;

        var sourcesFile = File.new_for_path (sourcesList);
        var dis = new DataInputStream (sourcesFile.read ());

        while ((row = dis.read_line (null)) != null)
        {
            // check if row has at least 3 characters
            if (row.length < 3)
                continue;

            Models.Source newRow = new Models.Source ();

            if (row.contains ("deb") && !row.contains("cdrom:"))
            {
                newRow.name = name == null ? _("system") : name;
                newRow.source = row.replace ("# ", "");
                newRow.status = row.substring (0, 3).contains ("# ") ? false : true;
                newRow.typeOf = sourcesList == "/etc/apt/sources.list" ? _("Built-in") : _("3rd-party");

                sources.append (newRow);
            }
        }

        return sources;
    }

    // List third-party sources
    public List<Models.Source> List3rdSources ()
    {
        List<Models.Source> sources = new List<Models.Source>();
        string path3rdSources = "/etc/apt/sources.list.d/";
        string row;

        var pathSources = File.new_for_path (path3rdSources);
        var enumerator = pathSources.enumerate_children (FileAttribute.STANDARD_NAME, FileQueryInfoFlags.NONE, null);

        for ( GLib.FileInfo? info = enumerator.next_file (null) ; info != null ; info = enumerator.next_file (null) )
        {
            // exclude sources backup files (.save)
            string fileName = info.get_name ();
            string cleanName = fileName.substring (0,fileName.length - 5);

            if(cleanName.length > 10)
                cleanName = cleanName.substring (0, 15) + " […]";

            if (fileName.substring (fileName.length - 5, 5) != ".save")
                sources.concat(ListSources(path3rdSources + fileName, cleanName));
        }

        return sources;
    }

    // Add new source to the system
    public bool AddSource (string sourceRow)
    {
        /* Posix.system ("apt-add-repository ppa:user/repository -yu");
         * command will add repo and update without confirm */
        return true;
    }

    // Delete source from the system
    public bool DeleteSource (string sourceRow)
    {
        /* Posix.system ("apt-add-repository ppa:user/repository -ryu");
         * command will remove repo and update without confirm */
        return true;
    }

    // Edit source and save to the system
    public bool EditSource (string sourceRow)
    {
        /* Edit should be performed updating source file
         * in /etc/apt/source.list.d */
        return true;
    }

    // Update sources and reload list
    public bool UpdateSource ()
    {
        /* delete all entries
         * call list_builtin ();
         * call list_3rdparty ();
         * populate list */
        return true;
    }
}
