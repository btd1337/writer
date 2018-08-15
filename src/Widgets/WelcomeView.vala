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


using Granite.Widgets;

namespace Writer.Widgets {
    public class WelcomeView : Welcome {

        private WriterApp app;

        public WelcomeView (WriterApp app) {
            base (_("No Documents Open"), _("Open a document to begin editing."));

            this.app = app;

            this.append ("document-new", _("New File"), _("Create a new document."));
            this.append ("document-open", _("Open File"), _("Open a saved document."));

            this.activated.connect ((index) => {
                // TODO
                // Open recent
                if (index == 0) {
                    app.new_file ();
                }
                else {
                    app.open_file_dialog ();
                }
            });
        }

    }
}
