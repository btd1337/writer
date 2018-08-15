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
using Gdk;
using Granite.Widgets;

namespace Writer.Widgets {
    public class TextToolBar : Gtk.Toolbar {

        private TextEditor editor;
        public FontButton font_button;
        public ColorButton font_color_button;
        public ToggleButton bold_button;
        public ToggleButton italic_button;
        public ToggleButton underline_button;
        public ToggleButton strikethrough_button;
        public Button indent_more_button;
        public Button indent_less_button;
        public ModeButton align_button;
        public Gtk.SeparatorToolItem item_separator;

        public TextToolBar (TextEditor editor) {
            this.get_style_context ().add_class ("toolbar");

            this.editor = editor;
            editor.cursor_moved.connect (cursor_moved);

            setup_ui ();
        }

        public void setup_ui () {

            // Make Widgets

            var paragraph_combobox = new Gtk.ComboBoxText ();
            paragraph_combobox.append ("Paragraph", (_("Paragraph")));
            paragraph_combobox.append ("Title", (_("Title")));
            paragraph_combobox.append ("Subtitle", (_("Subtitle")));
            paragraph_combobox.append ("Two-Column", (_("Two-Column")));
            paragraph_combobox.set_active_id ("Paragraph");
            var paragraph_item = new ToolItem ();
            paragraph_item.add (paragraph_combobox);
            paragraph_item.tooltip_text = _("Style");

            var font_item = new ToolItem ();
            font_button = new Gtk.FontButton ();
            font_button.tooltip_text = _("Font");
            font_button.use_font = true;
            font_button.use_size = false;
            font_item.add (font_button);

            font_color_button = new Gtk.ColorButton.with_rgba ({0, 0, 0, 225});
            font_color_button.set_title (_("Choose a Font Color"));
            font_color_button.tooltip_text = _("Font Color");
            var font_color_item = new Gtk.ToolItem ();
            font_color_item.add (font_color_button);

            var styles_item = new ToolItem ();
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

            var indent_button = new ButtonGroup ();
            var indent_more_button = new Button.from_icon_name ("format-indent-more-symbolic", Gtk.IconSize.BUTTON);
            indent_more_button.tooltip_text = _("More indent");
            var indent_less_button = new Button.from_icon_name ("format-indent-less-symbolic", Gtk.IconSize.BUTTON);
            indent_less_button.tooltip_text = _("Less indent");
            indent_button.add (indent_more_button);
            indent_button.add (indent_less_button);
            var indent_item = new Gtk.ToolItem ();
            indent_item.add (indent_button);

            item_separator = new Gtk.SeparatorToolItem ();

            var insert_button = new ButtonGroup ();
            var insert_comment_button = new Button.from_icon_name ("insert-text-symbolic", Gtk.IconSize.BUTTON);
            insert_comment_button.tooltip_text = _("Insert text");
            var insert_link_button = new Button.from_icon_name ("insert-link-symbolic", Gtk.IconSize.BUTTON);
            insert_link_button.tooltip_text = _("Insert link");
            var insert_image_button = new Button.from_icon_name ("insert-image-symbolic", Gtk.IconSize.BUTTON);
            insert_image_button.tooltip_text = _("Insert image");
            // Todo: Let's create & use table icon
            var insert_table_button = new Button.from_icon_name ("insert-object-symbolic", Gtk.IconSize.BUTTON);
            insert_table_button.tooltip_text = _("Insert table");
            insert_button.add (insert_comment_button);
            insert_button.add (insert_link_button);
            insert_button.add (insert_image_button);
            insert_button.add (insert_table_button);
            var insert_item = new Gtk.ToolItem ();
            insert_item.add (insert_button);


            //Set border_width on ToolItems
            paragraph_item.border_width = 5;
            font_item.border_width = 5;
            font_color_item.border_width = 5;
            styles_item.border_width = 5;
            align_item.border_width = 5;
            indent_item.border_width = 5;
            insert_item.border_width = 5;

            // Add Widgets
            this.add (paragraph_item);
            this.add (font_item);
            this.add (font_color_item);
            this.add (styles_item);
            this.add (align_item);
            this.add (indent_item);
            this.add (item_separator);
            this.add (insert_item);


            // Connect signals
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


        /*
         * Signal callbacks
         */

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

        public void cursor_moved () {
            bold_button.active = editor.has_style ("bold");
            italic_button.active = editor.has_style ("italic");
            underline_button.active = editor.has_style ("underline");
            strikethrough_button.active = editor.has_style ("strikethrough");

            align_button.selected = editor.get_justification_as_int ();

            //TODO
            // Update font and color buttons
        }

    }
}
