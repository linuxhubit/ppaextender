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
import webbrowser
gi.require_version('Gtk', '3.0')
gi.require_version('Granite', '1.0')
from gi.repository import Gtk, Granite
from constants import App

class Welcome(Gtk.Box):

    def __init__(self, parent):
        Gtk.Box.__init__(self, False, 0)
        
        self.parent = parent

        # Create welcome widget
        self.welcome = Granite.WidgetsWelcome()
        self.welcome = self.welcome.new(App.application_name, App.application_description)

        # Welcome voices
        self.welcome.append("document-new", "Add PPA", "Add new PPA")
        self.welcome.append("mail-archive", "List PPA", "List your PPA")
        self.welcome.append("open-menu", "Preferences", "Application settings")
        self.welcome.append("text-x-makefile", "Stranger Things", "You founded the chocolate pudding!")
        
        self.welcome.connect("activated", self.on_welcome_activated)

        self.add(self.welcome)

    def on_welcome_activated(self, widget, index):
        self.parent.parent. hbar.toggle_back()
        if index == 0:
            # Add PPA
            self.parent.stack.set_visible_child_name("detail")
        elif index == 1:
            self.parent.parent. hbar.toggle_remove()
            # List PPA
            self.parent.stack.set_visible_child_name("list")
        else:
            # Show Preferences
            self.parent.stack.set_visible_child_name("preferences")

