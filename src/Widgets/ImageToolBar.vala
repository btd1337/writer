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
    public class ImageToolBar : Gtk.Toolbar {

        private TextEditor editor;
        public ModeButton align_button;

        public ImageToolBar (TextEditor editor) {
            this.get_style_context ().add_class ("toolbar");

            this.editor = editor;

            var wrap_combobox = new Gtk.ComboBoxText ();
            wrap_combobox.append ("In line of text", (_("In line of text")));
            wrap_combobox.append ("Float above text", (_("Float above text")));
            wrap_combobox.set_active_id ("In line of text");
            var wrap_item = new Gtk.ToolItem ();
            wrap_item.add (wrap_combobox);

            var lock_aspect_check = new Gtk.CheckButton.with_label (_("Lock aspect ratio"));
            var lock_aspect_item = new Gtk.ToolItem ();
            lock_aspect_item.add (lock_aspect_check);

            var align_item = new ToolItem ();
            align_button = new ModeButton ();
            var align_left = new Gtk.Image.from_icon_name ("format-justify-left-symbolic", Gtk.IconSize.BUTTON);
            align_left.tooltip_text = _("Align left");
            var align_center = new Gtk.Image.from_icon_name ("format-justify-center-symbolic", Gtk.IconSize.BUTTON);
            align_center.tooltip_text = _("Align center");
            var align_right = new Gtk.Image.from_icon_name ("format-justify-right-symbolic", Gtk.IconSize.BUTTON);
            align_right.tooltip_text = _("Align right");
            align_button.append (align_left);
            align_button.append (align_center);
            align_button.append (align_right);
            align_item.add (align_button);

            var edit_image_button = new Gtk.Button.with_label (_("Crop"));
            edit_image_button.tooltip_text = _("Crop the selected image");
            var edit_image_item = new Gtk.ToolItem ();
            edit_image_item.add (edit_image_button);

            var delete_image_button = new Gtk.Button.with_label (_("Remove this Image"));
            delete_image_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
            delete_image_button.tooltip_text = _("Remove the selected image");
            var delete_image_item = new Gtk.ToolItem ();
            delete_image_item.add (delete_image_button);


            // Set border_width on ToolItems
            wrap_item.border_width = 5;
            lock_aspect_item.border_width = 5;
            align_item.border_width = 5;
            edit_image_item.border_width = 5;
            align_item.border_width = 5;
            delete_image_item.border_width = 5;

            // Add Widgets            
            this.add (wrap_item);
            this.add (lock_aspect_item);
            this.add (align_item);
            this.add (edit_image_item);
            this.add (delete_image_item);

            align_button.mode_changed.connect (() => {
                change_align (align_button.selected);
            });
        }

        public void change_align (int index) {
            switch (index) {
                case 1:
                    editor.set_justification ("center"); break;
                case 2:
                    editor.set_justification ("right"); break;
                default:
                    editor.set_justification ("left"); break;
            }
        }

    }
}
