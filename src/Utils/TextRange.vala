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
using Pango;

namespace Writer.Utils {
    public class TextRange : Object {

        private TextBuffer buffer;
        private TextIter start;
        private TextIter end;
        private int start_offset;
        private int end_offset;

        public TextRange (TextBuffer buffer, TextIter start, TextIter end) {
            this.buffer = buffer;
            this.start = start;
            this.end = end;

            this.start_offset = this.start.get_offset ();
            this.end_offset = this.end.get_offset ();
        }


        /*
         * Style and Tag checks
         * ====================
         */


         // Check if every Iter in the range has the given tag
        public bool has_tag (TextTag tag) {
            TextIter temp;
            for (int i = this.start_offset; i < this.end_offset; i++) {
                temp = get_iter_at_offset (i);
                if (! temp.has_tag (tag)) {
                    return false;
                }
            }

            return true;
        }

        public bool has_style (string name) {
            var tag = buffer.tag_table.lookup (name);
            return this.has_tag (tag);
        }



        // Check if at least one Iter in the range has the given tag
        public bool contains_tag (TextTag tag) {
            TextIter temp;
            for (int i = this.start_offset; i < this.end_offset; i++) {
                temp = get_iter_at_offset (i);
                if (temp.has_tag (tag)) {
                    return true;
                }
            }

            return false;
        }

        public bool contains_style (string name) {
            var tag = buffer.tag_table.lookup (name);
            return this.contains_tag (tag);
        }



        // Check if the range wraps the given tag, i.e. if the tag begins and ends within the range
        public bool wraps_tag (TextTag tag) {
            if ( (!start.has_tag (tag) || start.begins_tag (tag)) &&
                 (!end.has_tag (tag) || end.ends_tag (tag)) &&
                 (contains_tag (tag)) ) {
                return true;
            } else {
                return false;
            }
        }

        public bool wraps_style (string name) {
            var tag = buffer.tag_table.lookup (name);
            return this.wraps_tag (tag);
        }



        // Check if the range wraps the given tag exactly, i.e. if the tag begins and ends at the bounds of the range
        public bool wraps_tag_exact (TextTag tag) {
            var range = new TextRange (buffer, get_iter_at_offset (start_offset + 1), get_iter_at_offset (end_offset - 1));

            if ( (!start.has_tag (tag) || start.begins_tag (tag)) &&
                 (!end.has_tag (tag) || end.ends_tag (tag)) &&
                 (range.has_tag (tag))
               ) {
                return true;
            } else {
                return false;
            }
        }

        public bool wraps_style_exact (string name) {
            var tag = buffer.tag_table.lookup (name);
            return this.wraps_tag_exact (tag);
        }



        // Check if the range wraps the tag, with the bounds beginning and ending the tag
        public bool wraps_tag_with_bounds (TextTag tag) {
            if ( (start.begins_tag (tag)) &&
                 (end.ends_tag (tag)) &&
                 (has_tag (tag))
               ) {
                return true;
            } else {
                return false;
            }
        }

        public bool wraps_style_with_bounds (string name) {
            var tag = buffer.tag_table.lookup (name);
            return this.wraps_tag_with_bounds (tag);
        }



        // Checkif the range wraps the tag, with the offset next to start beginning the tag, and the offset preceding end ending the tag
        public bool wraps_tag_without_bounds (TextTag tag) {
            var range = new TextRange (buffer, get_iter_at_offset (start_offset + 1), get_iter_at_offset (end_offset - 1));

            if ( (!start.has_tag (tag)) &&
                 (!end.has_tag (tag)) &&
                 (range.has_tag (tag))
               ) {
                return true;
            } else {
                return false;
            }
        }

        public bool wraps_style_without_bounds (string name) {
            var tag = buffer.tag_table.lookup (name);
            return this.wraps_tag_without_bounds (tag);
        }



        /*
         * Apply/Remove Tags/Styles
         * ========================
         */


        public void apply_tag (TextTag tag) {
            buffer.apply_tag (tag, start, end);
        }

        public void apply_style (string name) {
            var tag = buffer.tag_table.lookup (name);
            apply_tag (tag);
        }

        public void remove_tag (TextTag tag) {
            buffer.remove_tag (tag, start, end);
        }

        public void remove_style (string name) {
            var tag = buffer.tag_table.lookup (name);
            remove_tag (tag);
        }

        public void toggle_tag (TextTag tag) {
            if (has_tag (tag))
                remove_tag (tag);
            else
                apply_tag (tag);
        }

        public void toggle_style (string name) {
            if (has_style (name))
                remove_style (name);
            else
                apply_style (name);
        }



        /*
         * Justification
         * =============
         */


        public Gtk.Justification get_justification () {
            if (has_style ("align-center"))
                return Gtk.Justification.CENTER;
            else if (has_style ("align-right"))
                return Gtk.Justification.RIGHT;
            else if (has_style ("align-fill"))
                return Gtk.Justification.FILL;
            else
                return Gtk.Justification.LEFT;
        }
        public int get_justification_as_int () {
            if (has_style ("align-center"))
                return 1;
            else if (has_style ("align-right"))
                return 2;
            else if (has_style ("align-fill"))
                return 3;
            else
                return 0;
        }

        public void set_justification (string align) {
            remove_style ("align-left");
            remove_style ("align-center");
            remove_style ("align-right");
            remove_style ("align-fill");

            apply_style ("align-" + align);
        }



        /*
         * Fonts
         * =====
         */

        public void set_font (FontDescription font) {
            var font_name = font.to_string ();
            set_font_from_string (font_name);
        }

        public void set_font_from_string (string font) {
            if (buffer.tag_table.lookup (font) == null)
                buffer.create_tag (font, "font", font);

            apply_style (font);
        }

        public void set_font_color (Gdk.Color color) {
            var name = color.to_string ();
            set_font_color_from_string (name);
        }

        public void set_font_color_from_string (string color) {
            if (buffer.tag_table.lookup (color) == null)
                buffer.create_tag (color, "foreground", color);

            apply_style (color);
        }




        /*
         * Utilities
         */

        public TextIter get_iter_at_offset (int offset) {
            TextIter iter;
            buffer.get_iter_at_offset (out iter, offset);
            return iter;
        }

    }
}
