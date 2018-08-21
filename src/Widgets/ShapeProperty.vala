/*
* Copyright (c) 2014-2018 Writer Developers
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

using Gtk;
using Gdk;
using Granite.Widgets;

namespace Writer.Widgets {
    public class ShapeProperty : Gtk.Grid {

        private TextEditor editor;

        public ShapeProperty () {
            var shape_properties_label = new Gtk.Label (_("Shape Properties"));
            shape_properties_label.get_style_context ().add_class ("h3");
            shape_properties_label.xalign = 0;

            // Create labels/colorbuttons for fill/line color
            var fill_color_label = new Gtk.Label (_("Fill Color: "));
            fill_color_label.xalign = 1;
            var line_color_label = new Gtk.Label (_("Line Color: "));
            line_color_label.xalign = 1;
            // TODO: Update the color button
            var fill_color_button = new Gtk.ColorButton.with_rgba ({0, 0, 0, 225});
            var line_color_button = new Gtk.ColorButton.with_rgba ({0, 0, 0, 225});

            // Create label & spin button for boder setting
            var border_label = new Gtk.Label (_("Border: "));
            border_label.xalign = 1;
            var border_spin = new Gtk.SpinButton.with_range (0.1, 10, 0.1);

            // Add Widgets
            margin = 12;
            column_spacing = 6;
            row_spacing = 6;
            attach (shape_properties_label, 0, 0, 1, 1);
            attach (fill_color_label, 0, 1, 1, 1);
            attach (fill_color_button, 1, 1, 1, 1);
            attach (line_color_label, 0, 2, 1, 1);
            attach (line_color_button, 1, 2, 1, 1);
            attach (border_label, 0, 3, 1, 1);
            attach (border_spin, 1, 3, 1, 1);

            // Connect signals
            fill_color_button.color_set.connect (() => {
                Gdk.Color color;
                fill_color_button.get_color (out color);
                editor.set_font_color (color);
            });
            line_color_button.color_set.connect (() => {
                Gdk.Color color;
                line_color_button.get_color (out color);
                editor.set_font_color (color);
            });

        }

    }
}
