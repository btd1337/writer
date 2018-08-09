# Writer

**Note: this is a work-in-progress app and has not been released yet.**

Writer is a word processor for elementary OS that let you create simple and beautiful documents.

## Building, Testing, and Installation

You'll need the following dependencies to build:

* libgtk-3.0-dev
* libgtksourceview-3.0-dev
* libgranite (>= 0.3.0)
* libgconf-2.0-dev
* libzeitgeist-2.0
* ninja

Clone this repo, run `meson build` to configure the build environment and run `ninja` to build

```
git clone https://github.com/ryonakano/writer.git && cd writer/
meson build --prefix=/usr
cd build/
ninja
```

To install, use `ninja install`, then execute with `com.github.ryonakano.writer`

```
sudo ninja install
com.github.ryonakano.writer
```

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md).

## The Story Behind This App

Actually this repository is a fork of the [original Writer](https://launchpad.net/writer). One day I found the original one and was very impressed, but it doesn't seems to be updated recently and doesn't released to AppCenter. Then I feel I want to fork it and develop.

So this repository would not exist without the work of the original developers Tuur Dutoit, Anthony Huben and [its mockup designer](https://www.deviantart.com/spiceofdesign/art/Writer-Concept-351501580) spiceofdesign.
