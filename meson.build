project('com.github.ryonakano.writer', 'vala', 'c')

i18n = import('i18n')
add_global_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language:'c'
)

subdir('data')
subdir('po')
subdir('src')

meson.add_install_script('meson/post_install.py')
