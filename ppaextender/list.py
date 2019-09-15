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
from ppa import PPA

class List(Gtk.ScrolledWindow):

    def __init__(self, parent):
        Gtk.ScrolledWindow.__init__(self)
        self.parent = parent
        self.ppa = PPA(self)
        self.generate_entries()

    def generate_entries(self, update=False):
        ppa_s = self.ppa.list_all()
        if update == False:
            self.ppa_model = Gtk.ListStore(str)

        for ppa_l in ppa_s:
            self.ppa_model.append([ppa_l])
        self.ppa_s_sort = Gtk.TreeModelSort(model=self.ppa_model)
        self.treeview = Gtk.TreeView.new_with_model(self.ppa_s_sort)
        tree_selection = self.treeview.get_selection()
        tree_selection.connect('changed', self.on_row_change)
        for i, column_title in enumerate(["Name"]):
            renderer = Gtk.CellRendererText()
            column = Gtk.TreeViewColumn(column_title, renderer, text=i)
            self.treeview.append_column(column)
        self.add(self.treeview)
        
    def on_row_change(self, widget):
        (model, pathlist) = widget.get_selected_rows()
        for path in pathlist :
            tree_iter = model.get_iter(path)
            value = model.get_value(tree_iter,0)
            self.parent.parent.hbar.ppa_name = value
