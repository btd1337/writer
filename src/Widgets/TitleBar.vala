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

using Granite;
using Granite.Widgets;

namespace Writer.Widgets {
    public class TitleBar : HeaderBar {

        private WriterApp app;

        private Button open_button;
        private Button save_button;
        private Button save_as_button;
        private Button revert_button;
        private Button print_button;
        private Gtk.MenuItem save_as_item;
        private Gtk.SearchEntry search_field;

        public TitleBar (WriterApp app) {

            //Basics
            this.app = app;
            this.title = "Writer";
            this.set_show_close_button (true);
            this.get_style_context ().add_class ("primary-toolbar");

            //Make buttons
            open_button = new Gtk.Button.from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR);
            open_button.tooltip_text = _("Open a file");
            save_button = new Gtk.Button.from_icon_name ("document-save", Gtk.IconSize.LARGE_TOOLBAR);
            save_button.tooltip_text = _("Save this file");
            save_as_button = new Gtk.Button.from_icon_name ("document-save-as", Gtk.IconSize.LARGE_TOOLBAR);
            save_as_button.tooltip_text = _("Save this file with a different name");
            revert_button = new Gtk.Button.from_icon_name ("document-revert", Gtk.IconSize.LARGE_TOOLBAR);
            revert_button.tooltip_text = _("Restore this file");
            print_button = new Gtk.Button.from_icon_name ("document-export", Gtk.IconSize.LARGE_TOOLBAR);
            print_button.tooltip_text = _("Print…");

            //Search Field
            search_field = new Gtk.SearchEntry ();
            search_field.placeholder_text = "Find";
            search_field.search_changed.connect (() => {
                app.search (search_field.text);
            });

            //AppMenu
            var preferences_item = new Gtk.MenuItem.with_label ("Preferences");
            var app_menu_menu = new Gtk.Menu ();
            app_menu_menu.add (new Gtk.SeparatorMenuItem ());
            app_menu_menu.add (preferences_item);
            var app_menu = app.create_appmenu (app_menu_menu);

            //Add buttons to TitleBar
            this.pack_start (open_button);
            this.pack_start (save_button);
            this.pack_start (save_as_button);
            this.pack_start (revert_button);
            this.pack_end (print_button);
            this.pack_end (app_menu);
            this.pack_end (search_field);

            //Connect signals
            open_button.clicked.connect (app.open_file_dialog);
            save_button.clicked.connect (app.save);
            save_as_button.clicked.connect (app.save_as);
            revert_button.clicked.connect (app.revert);
            print_button.clicked.connect (app.print_file);

            preferences_item.activate.connect (app.preferences);
        }


        public void set_active (bool active) {
            save_button.sensitive = active;
            revert_button.sensitive = active;
            print_button.sensitive = active;
            search_field.sensitive = active;

            save_as_item.sensitive = active;
        }
    }
}
