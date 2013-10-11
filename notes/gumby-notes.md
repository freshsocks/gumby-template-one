Gumby Framework : Notes
=======================

Gumby.css is loaded in the ``` <head> ``` of the main layout file. Use it in your HTML/jade with zero setup required.

#### FreshStart tries to simplify the Gumby setup

[Gumby](http://gumbyframework.com/) is a nice UI framework similar to Twitter's bootstrap. However, unlike bootstrap, its a pain in the gonads to [set up](http://gumbyframework.com/docs/). Gumby is very exsensible and flexible, as long as you have ruby ~1.9+ installed with sass, compass and modular-scale gems installed.

Gumby doesn't install nicely by just ``` bower install gumby ```. Gumby has it's own way of building and compiling using something called [Claymate](http://gumbyframework.com/docs/claymate/), which can be installed globally via npm. See, pain in the nads.

The reason for Claymate is that Gumby needs to compile the css using Compass, and then needs to move files around to a bunch of different directories to make a sensible file structure. So Claymate just takes care of that nonsense for you. In the case of **Fresh Start**, the directories are already set up, so installing and running Claymate is not necessary for us.

#### Modifying & extending Gumby with Compass

In the ``` /public/scss/ ``` directory, there are a few sass/compass files that are there for extending Gumby or changing some of the global Gumby variables, such as font sizes, colors, columns, etc. We don't actaully have to compile anything to use Gumby in **Fresh Start**. Gumby is already compiled into the ``` /public/css/gumby.css ``` file, included in the ``` <head> ``` tag of the main HTML layout file in ``` /views/layout.jade ``` and its ready to use with out-of-the-box settings.

If you want to [customize some of the settings in Gumby](http://gumbyframework.com/docs/mixins/), you would do so by editing the files in ``` /public/sass/ ``` and then running the following in the ``` /public/ ``` directory:

```
compass compile
```

> **NOTE:** You must have ruby (higer version than 1.8.7) installed with sass, compass and modular-scale gems also installed or else Gumby will not compile.

Gumby suggests that you don't modify the CSS directly. Instead, use their mixins and variables, work with the files in ``` /public/sass/ ```, and recompile them.

#### Just start using it

Again: no setup necessary. Just start using Gumby classes in your HTML/jade.


> **NOTE:**
> Gumby ships with _Open Sans_ as the default font. The Gumby.css file, for some reason, always has an incomplete URL in the ``` @import ``` for the font (missing an "http:" prefix), resulting in a missing font.
> I have taken the liberty of adding the "http:" prefix on the first line of ``` /public/css/gumby.css ``` so the fonts load properly. This is some weird sort of bug that must have slipped by.

> _**Be aware!**_ If you recompile Gumby, this URL refernece might get screwed up, and you might have to change it manually.