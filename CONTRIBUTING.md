# Contributing

There are many ways you can contribute, even if you don't know how to code. I would appreciate it if you could contribute to this app!

## Reporting Issues or Suggesting Features

I recommend to take a look at [elementary's Reference](https://elementary.io/docs/code/reference#reporting-bugs) and use it as a reference if you're new to this kind of things.

## How to Translate This App

Translating some app and making it easy-to-use for more people are one of the most important things. Though the core thing is translation, there are some process to do it. Let's walk through it!

### Create Translation

#### Before Translation

First of all fork this repo on GitHub and clone the forked repo to local:

    git clone https://github.com/your-username/writer.git

Next, search for your language code (e.g. en = English, zh = Chinese). See https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes if you need. Then add it to `po/LINGUAS` and `po/extra/LINGUAS`, in a new line, after the last line.

After that, run the following command to create/update po files:

    meson build --prefix=/usr
    cd build/
    ninja com.github.ryonakano.writer-update-po
    ninja extra-update-po

Other language files are also updated when you run this command, but **ignore them.**

#### Translation

Now what you've been waiting for! Translate `po/<language_code>.po` and `po/extra/<language_code>.po` using the po editor of your choice (e.g. Poedit).

#### After Translation

After you save the po file, open a terminal in the folder you've cloned this repo in and type:

    git checkout -b "<language_code>-translation"

Then add the po file and LINGUAS file you've updated. **Do not add other files!**

    git add po/LINGUAS po/extra/LINGUAS po/<language_code>.po po/extra/<language_code>.po
    git commit -m "Add <Language Name> translation"
    git push origin master

Type your github username and password if you are asked. Finally, open your cloned repo and select "Compare & Pull Request".

And that's all! I'll check whether there is no problem in your pull request (PR), and if so I'll approve and merge your PR! Your translation is released every time I push this app to AppCenter Dashboard, so it is not always reflected when your PR is merged. Please be patient.

### Update your/others' Translation

You can also update your or others' translation if needed. In that case, you don't have to update or add `po/LINGUAS` file to your PR. Open existing po file with any po editor and add just it when you've updated it and saved.

### Note

* **If you find some issue (e.g. typo) in the translation files, create another PR which fix it! Do NOT fix it in your translation PR!** If you don't know how to fix it, post a issue about that. I'll fix it.
* **If you can understand and would like to translate into multiple languages, please make separated PRs per languages!** It's not good thing to include more than two translation in your one PR.
* Only edit and add `po/LINGUAS`, `po/extra/LINGUAS`, `po/<language_code>.po` and `po/extra/<language_code>.po` to your PR if you would like to add/update translation. Do NOT add other files in your PR.
* If you have some knowledge of meson & ninja, please make sure your translation works by building this app. See [README.md](README.md) if you need.

## References

This file was created by referring these references:

* https://github.com/lainsce/notejot/blob/master/po/README.md
* https://github.com/BaptisteGelez/Spreadsheet/blob/master/README.md
