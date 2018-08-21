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
using Granite;
using Granite.Widgets;

namespace Writer.Widgets {
    public class TitleBar : HeaderBar {

        private WriterApp app;

        private Button open_button;
        private Button save_button;
        private Button save_as_button;
        private Button revert_button;
        private Gtk.MenuItem export_item;
        private Gtk.MenuItem print_item;
        private MenuButton export_button;
        public Gtk.MenuButton app_menu;
        private Gtk.SearchEntry search_field;

        public TitleBar (WriterApp app) {

            // Basics
            this.app = app;
            this.title = "Writer";
            this.set_show_close_button (true);
            this.get_style_context ().add_class ("titlebar");

            // Make buttons
            open_button = new Gtk.Button.from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR);
            open_button.tooltip_text = _("Open a file");
            save_button = new Gtk.Button.from_icon_name ("document-save", Gtk.IconSize.LARGE_TOOLBAR);
            save_button.tooltip_text = _("Save this file");
            save_as_button = new Gtk.Button.from_icon_name ("document-save-as", Gtk.IconSize.LARGE_TOOLBAR);
            save_as_button.tooltip_text = _("Save this file with a different name");
            revert_button = new Gtk.Button.from_icon_name ("document-revert", Gtk.IconSize.LARGE_TOOLBAR);
            revert_button.tooltip_text = _("Restore this file");

            // Search Field
            search_field = new Gtk.SearchEntry ();
            search_field.placeholder_text = _("Find");
            search_field.search_changed.connect (() => {
                app.search (search_field.text);
            });

            // Export Menu
            export_item = new Gtk.MenuItem.with_label (_("Export to PDF…"));
            print_item = new Gtk.MenuItem.with_label (_("Print…"));
            var export_menu = new Gtk.Menu ();
            export_menu.add (export_item);
            export_menu.add (print_item);
            export_button = new Gtk.MenuButton ();
            export_button.set_popup (export_menu);
            export_button.set_image (new Gtk.Image.from_icon_name ("document-export", Gtk.IconSize.LARGE_TOOLBAR));
            export_button.tooltip_text = _("Print or export this file");
            export_menu.show_all ();

            // Main Menu (Inspired form Code)
            // Create zoom in/out button
            // TODO: Add actions for each button
            var zoom_out_button = new Gtk.Button.from_icon_name ("zoom-out-symbolic", Gtk.IconSize.MENU);
            zoom_out_button.tooltip_text = _("Zoom Out");

            var zoom_default_button = new Gtk.Button.with_label ("100%");
            zoom_default_button.tooltip_text = _("Zoom 1:1");

            var zoom_in_button = new Gtk.Button.from_icon_name ("zoom-in-symbolic", Gtk.IconSize.MENU);
            zoom_in_button.tooltip_text = _("Zoom In");

            // Combine three buttons above to a grid
            var zoom_size_grid = new Gtk.Grid ();
            zoom_size_grid.column_homogeneous = true; // Use same width for column
            zoom_size_grid.hexpand = true;
            zoom_size_grid.margin = 12;
            zoom_size_grid.get_style_context ().add_class (Gtk.STYLE_CLASS_LINKED);
            zoom_size_grid.add (zoom_out_button);
            zoom_size_grid.add (zoom_default_button);
            zoom_size_grid.add (zoom_in_button);

            // Create a separator
            var menu_separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);

            // Create preferences button
            var preferences_menuitem = new Gtk.ModelButton ();
            preferences_menuitem.text = _("Preferences");

            // Add to main grid
            var menu_grid = new Gtk.Grid ();
            menu_grid.margin_bottom = 3;
            menu_grid.orientation = Gtk.Orientation.VERTICAL;
            menu_grid.width_request = 200;
            menu_grid.attach (zoom_size_grid, 0, 0, 3, 1);
            menu_grid.attach (menu_separator, 0, 1, 3, 1);
            menu_grid.attach (preferences_menuitem, 0, 2, 3, 1);
            menu_grid.show_all ();

            // Set popover
            var menu = new Gtk.Popover (null);
            menu.add (menu_grid);

            // Create button for Main Menu
            var app_menu = new Gtk.MenuButton ();
            app_menu.image = new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
            app_menu.tooltip_text = _("Menu");
            app_menu.popover = menu;

            // Add buttons to TitleBar
            this.pack_start (open_button);
            this.pack_start (save_button);
            this.pack_start (save_as_button);
            this.pack_start (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));
            this.pack_start (revert_button);
            this.pack_end (app_menu);
            this.pack_end (export_button);
            this.pack_end (search_field);

            // Connect signals
            open_button.clicked.connect (app.open_file_dialog);
            save_button.clicked.connect (app.save);
            save_as_button.clicked.connect (app.save_as);
            revert_button.clicked.connect (app.revert);

            export_item.activate.connect (app.export_file);
            print_item.activate.connect (app.print_file);

            preferences_menuitem.clicked.connect (app.preferences);
        }


        public void set_active (bool active) {
            save_button.sensitive = active;
            save_as_button.sensitive = active;
            revert_button.sensitive = active;
            export_button.sensitive = active;
            search_field.sensitive = active;

            export_button.sensitive = active;
        }
    }
}
