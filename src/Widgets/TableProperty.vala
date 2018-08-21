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
    public class TableProperty : Gtk.Grid {

        private TextEditor editor;
        public FontButton font_button;
        public ToggleButton bold_button;
        public ToggleButton italic_button;
        public ToggleButton underline_button;
        public ToggleButton strikethrough_button;
        public ModeButton align_button;

        public TableProperty (TextEditor editor) {
            this.editor = editor;

            var table_properties_label = new Gtk.Label (_("Table Properties"));
            table_properties_label.get_style_context ().add_class ("h3");
            var table_properties_item = new Gtk.ToolItem ();
            table_properties_item.add (table_properties_label);

            var font_item = new Gtk.ToolItem ();
            font_button = new Gtk.FontButton ();
            font_button.tooltip_text = _("Font");
            font_button.use_font = true;
            font_button.use_size = false;
            font_item.add (font_button);

            var font_color_button = new Gtk.ColorButton.with_rgba ({0, 0, 0, 225});
            font_color_button.tooltip_text = _("Font Color");
            var font_color_item = new Gtk.ToolItem ();
            font_color_item.add (font_color_button);

            var styles_item = new Gtk.ToolItem ();
            var styles_buttons = new ButtonGroup ();
            bold_button = new Gtk.ToggleButton ();
            bold_button.add (new Image.from_icon_name ("format-text-bold-symbolic", Gtk.IconSize.BUTTON));
            bold_button.tooltip_text = _("Add bold to text");
            bold_button.focus_on_click = false;
            styles_buttons.pack_start (bold_button);
            italic_button = new Gtk.ToggleButton ();
            italic_button.add (new Image.from_icon_name ("format-text-italic-symbolic", Gtk.IconSize.BUTTON));
            italic_button.tooltip_text = _("Add italic to text");
            italic_button.focus_on_click = false;
            styles_buttons.pack_start (italic_button);
            underline_button = new Gtk.ToggleButton ();
            underline_button.add (new Image.from_icon_name ("format-text-underline-symbolic", Gtk.IconSize.BUTTON));
            underline_button.tooltip_text = _("Add underline to text");
            underline_button.focus_on_click = false;
            styles_buttons.pack_start (underline_button);
            strikethrough_button = new Gtk.ToggleButton ();
            strikethrough_button.add (new Image.from_icon_name ("format-text-strikethrough-symbolic", Gtk.IconSize.BUTTON));
            strikethrough_button.tooltip_text = _("Strikethrough text");
            strikethrough_button.focus_on_click = false;
            styles_buttons.pack_start (strikethrough_button);
            styles_item.add (styles_buttons);

            var align_item = new ToolItem ();
            align_button = new ModeButton ();
            var align_left = new Gtk.Image.from_icon_name ("format-justify-left-symbolic", Gtk.IconSize.BUTTON);
            align_left.tooltip_text = _("Align left");
            var align_center = new Gtk.Image.from_icon_name ("format-justify-center-symbolic", Gtk.IconSize.BUTTON);
            align_center.tooltip_text = _("Align center");
            var align_right = new Gtk.Image.from_icon_name ("format-justify-right-symbolic", Gtk.IconSize.BUTTON);
            align_right.tooltip_text = _("Align right");
            var text_fill = new Gtk.Image.from_icon_name ("format-justify-fill-symbolic", Gtk.IconSize.BUTTON);
            text_fill.tooltip_text = _("Fill text");
            align_button.append (align_left);
            align_button.append (align_center);
            align_button.append (align_right);
            align_button.append (text_fill);
            align_item.add (align_button);

            var delete_table_button = new Gtk.Button.with_label (_("Delete this Table"));
            delete_table_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
            delete_table_button.tooltip_text = _("Delete the selected table");
            var delete_table_item = new Gtk.ToolItem ();
            delete_table_item.add (delete_table_button);

            // Add Widgets
            margin = 12;
            column_spacing = 6;
            row_spacing = 6;
            attach (table_properties_item, 0, 0, 1, 1);
            attach (font_item, 0, 1, 2, 1);
            attach (font_color_item, 3, 1, 1, 1);
            attach (styles_item, 0, 2, 1, 1);
            attach (align_item, 0, 3, 1, 1);
            attach (delete_table_item, 0, 4, 1, 1);

            align_button.mode_changed.connect (() => {
                change_align (align_button.selected);
            });

            font_button.font_set.connect (() => {
                editor.set_font_from_string (font_button.font);
            });
            font_color_button.color_set.connect (() => {
                Gdk.Color color;
                font_color_button.get_color (out color);
                editor.set_font_color (color);
            });

            bold_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("bold");
                return false;
            });
            italic_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("italic");
                return false;
            });
            underline_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("underline");
                return false;
            });
            strikethrough_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("strikethrough");
                return false;
            });

        }

        public void change_align (int index) {
            switch (index) {
                case 1:
                    editor.set_justification ("center"); break;
                case 2:
                    editor.set_justification ("right"); break;
                case 3:
                    editor.set_justification ("fill"); break;
                default:
                    editor.set_justification ("left"); break;
            }
        }

    }
}
