#!/usr/bin/python3
'''
   Copyright 2019 Mirko Brombin (send@mirko.pm)

   This file is part of PPAExtender.

    PPAExtender is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    PPAExtender is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with PPAExtender.  If not, see <http://www.gnu.org/licenses/>.
'''

import os
import gi
import apt
import threading
import time
from softwareproperties.SoftwareProperties import SoftwareProperties
import webbrowser
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib

GLib.threads_init()

class ThreadRemove(threading.Thread):

    def __init__(self, parent, sources_path, ppa):
        threading.Thread.__init__(self)
        self.parent = parent
        self.sources_path = sources_path
        self.ppa = ppa
        
    def run(self):
        os.remove(self.sources_path+self.ppa+".list")

        cache = apt.Cache()
        cache.open()
        cache.update()
        cache.open(None)

        self.parent.parent.hbar.spinner.stop()
        self.parent.parent.stack.list_all.ppa_model.clear()
        self.parent.parent.stack.list_all.generate_entries(True)
        self.parent.parent.hbar.trash.set_sensitive(True)

class ThreadAdd(threading.Thread):

    def __init__(self, parent, sources_path, url):
        threading.Thread.__init__(self)
        self.parent = parent
        self.sources_path = sources_path
        self.url = url
        
    def run(self):
        sp = SoftwareProperties()
        sp.add_source_from_line(self.url)
        sp.sourceslist.save()

        cache = apt.Cache()
        cache.open()
        cache.update()
        cache.open(None)

        self.parent.parent.parent.hbar.spinner.stop()
        self.parent.parent.list_all.ppa_model.clear()
        self.parent.parent.list_all.generate_entries(True)

# This method need to be improved
class PPA:
    waiting = "Waiting for PPA"
    invalid = "Not a valid PPA syntax"
    valid = "Valid PPA syntax found"
    sources_path = "/etc/apt/sources.list.d/"    
    cache = apt.Cache()

    def __init__(self, parent):
        self.parent = parent

    def add(self):
        self.parent.parent.parent.hbar.spinner.start()
        ThreadAdd(self.parent, self.sources_path, self.url).start()

    def remove(self, ppa):
        self.parent.parent.hbar.remove.set_sensitive(False)
        self.parent.parent.hbar.spinner.start()
        ThreadRemove(self.parent, self.sources_path, ppa).start()

    def list_all(self):
        l = []
        for f in os.listdir(self.sources_path):
            if not f.endswith(".save"):
                f = f[:-5]
                l.append(f)
        return l

    def validate(self, url, widget):
        self.url = url
        if url.startswith("ppa:"):
            self.parent.status = True
            widget.set_text(self.valid)
        elif url == "":
            self.parent.status = False
            widget.set_text(self.waiting)
        else:
            self.parent.status = False
            widget.set_text(self.invalid)
