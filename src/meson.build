config_data = configuration_data()
config_data.set('GETTEXT_PACKAGE', meson.project_name())
gettext_declaration = configure_file(
    configuration: config_data,
    input: 'config.vala.in',
    output: 'config.vala'
)

executable(
    meson.project_name(),
        'Utils/BugFixAchive.vala',
        'Utils/Document.vala',
        'Utils/FileChooser.vala',
        'Utils/Stylesheet.vala',
        'Utils/TextEditor.vala',
        'Utils/TextRange.vala',
        'Utils/ZeitgeistLogger.vala',
        'Widgets/ButtonGroup.vala',
        'Widgets/EditorView.vala',
        'Widgets/ImageToolBar.vala',
        'Widgets/TableChooser.vala',
        'Widgets/TableToolBar.vala',
        'Widgets/TextToolBar.vala',
        'Widgets/TitleBar.vala',
        'Widgets/ToolBar.vala',
        'Widgets/WelcomeView.vala',
        #'config.vala',
        'MainWindow.vala',
        'Writer.vala',
    dependencies: [
        dependency('gee-0.8'),
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0', version: '>=3.22'),
        dependency('gtksourceview-3.0'),
        dependency('zeitgeist-2.0'),
        meson.get_compiler('vala').find_library('posix'),
    ],
    install: true
)
