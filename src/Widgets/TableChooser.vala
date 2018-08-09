/*
* Copyright (c) 2014-2018 Writer Developers
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
*/


using Gtk;

namespace Writer.Widgets {
    public class TableChooser : Gtk.Grid {
    
        public int columns;
        public int rows;
        
        public signal void selected (int columns, int rows);
        
        public TableChooser () {
            column_spacing = 6;
            row_spacing = 4;
            
            
            setup_ui ();
        }
        
        private void setup_ui () {
            // Make some content
            var cols_spin = new Gtk.SpinButton.with_range (1, 10, 1);
            var rows_spin = new Gtk.SpinButton.with_range (1, 10, 1);
            
            var insert_button = new Gtk.Button.with_label ("Insert Table");
            
            // Make some labels
            var main_label = new Gtk.Label ("Table");
            main_label.xalign = 0;
            var cols_label = new Gtk.Label ("Columns:");
            cols_label.xalign = 0;
            var rows_label = new Gtk.Label ("Rows:");
            rows_label.xalign = 0;
            
            // Package...
            attach (main_label, 0, 0, 2, 1);
            attach (cols_label, 0, 1, 1, 1);
            attach (cols_spin, 1, 1, 1, 1);
            attach (rows_label, 0, 2, 1, 1);
            attach (rows_spin, 1, 2, 1, 1);
            attach (insert_button, 0, 3, 2, 1);
            
            
            // Attach signals
            insert_button.clicked.connect (() => {
                columns = cols_spin.get_value_as_int ();
                rows = rows_spin.get_value_as_int ();
                selected (columns, rows);
            });
        }
    
    }
}

