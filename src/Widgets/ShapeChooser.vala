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

namespace Writer.Widgets {
    public class ShapeChooser : Gtk.Grid {

        public ShapeChooser () {
            // Create type label
            var type_label = new Gtk.Label (_("Insert Shape"));
            type_label.get_style_context ().add_class ("h3");
            type_label.xalign = 0;

            // Create shape buttons
            // TODO: Create icons to represent each shape
            var line_button = new Gtk.Button ();
            line_button.image = new Gtk.Image.from_icon_name ("insert-object-symbolic", Gtk.IconSize.DND);
            line_button.tooltip_text = _("Line");
            var circle_button = new Gtk.Button ();
            circle_button.image = new Gtk.Image.from_icon_name ("insert-object-symbolic", Gtk.IconSize.DND);
            circle_button.tooltip_text = _("Circle");
            var triangle_button = new Gtk.Button ();
            triangle_button.image = new Gtk.Image.from_icon_name ("insert-object-symbolic", Gtk.IconSize.DND);
            triangle_button.tooltip_text = _("Triangle");
            var square_button = new Gtk.Button ();
            square_button.image = new Gtk.Image.from_icon_name ("insert-object-symbolic", Gtk.IconSize.DND);
            square_button.tooltip_text = _("Square");

            var shape_buttons = new ButtonGroup ();
            shape_buttons.pack_start (line_button);
            shape_buttons.pack_start (circle_button);
            shape_buttons.pack_start (triangle_button);
            shape_buttons.pack_start (square_button);

            // Package...
            margin = 12;
            column_spacing = 6;
            row_spacing = 4;
            attach (type_label, 0, 0, 1, 1);
            attach (shape_buttons, 0, 1, 4, 1);

            // TODO: Attach signals
        }

    }
}
