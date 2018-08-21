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
    public class InsertChooser : Gtk.Grid {

        public InsertChooser () {
            // Create header label
            var header_label = new Gtk.Label (_("Choose What to Insert:"));
            header_label.get_style_context ().add_class ("h3");
            header_label.xalign = 0;

            // Create insert buttons
            // TODO: Create icons to represent each shape
            var insert_image_button = new Gtk.Button ();
            insert_image_button.image = new Gtk.Image.from_icon_name ("emblem-photos-symbolic", Gtk.IconSize.DND);
            insert_image_button.tooltip_text = _("Insert a image from file…");
            var insert_shape_button = new Gtk.Button ();
            insert_shape_button.image = new Gtk.Image.from_icon_name ("insert-object-symbolic", Gtk.IconSize.DND);
            insert_shape_button.tooltip_text = _("Insert a shape");
            var insert_table_button = new Gtk.Button ();
            insert_table_button.image = new Gtk.Image.from_icon_name ("insert-object-symbolic", Gtk.IconSize.DND);
            insert_table_button.tooltip_text = _("Insert a table");
            var insert_textbox_button = new Gtk.Button ();
            insert_textbox_button.image = new Gtk.Image.from_icon_name ("insert-object-symbolic", Gtk.IconSize.DND);
            insert_textbox_button.tooltip_text = _("Insert a textbox");

            var shape_buttons = new ButtonGroup ();
            shape_buttons.pack_start (insert_image_button);
            shape_buttons.pack_start (insert_shape_button);
            shape_buttons.pack_start (insert_table_button);
            shape_buttons.pack_start (insert_textbox_button);

            // Package...
            margin = 12;
            column_spacing = 6;
            row_spacing = 4;
            attach (header_label, 0, 0, 1, 1);
            attach (shape_buttons, 0, 1, 4, 1);

            // TODO: Attach signals
        }

    }
}
