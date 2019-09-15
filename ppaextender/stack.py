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
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk
from preferences import Preferences
from list import List
from welcome import Welcome
from detail import Detail

class Stack(Gtk.Box):
        
    # Define variable for GTK global theme
    settings = Gtk.Settings.get_default()

    def __init__(self, parent):
        Gtk.Box.__init__(self, orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.parent = parent

        self.stack = Gtk.Stack()
        self.stack.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT)
        self.stack.set_transition_duration(400)

        self.welcome = Welcome(self)
        self.detail = Detail(self)
        self.list_all = List(self)
        self.preferences = Preferences(self)

        self.stack.add_titled(self.welcome, "welcome", "Welcome")
        self.stack.add_titled(self.list_all, "list", "PPA")
        self.stack.add_titled(self.detail, "detail", "Add new")
        self.stack.add_titled(self.preferences, "preferences", "Preferences")

        self.pack_start(self.stack, True, True, 0)
