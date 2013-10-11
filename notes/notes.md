Fresh Start
==============

A nodejs base app to start fresh from.

Includes
========

### Node Modules
* express
* jade
* stylus
* socket.io

### Bower Components
* d3
* gumby
* jquery
* modernizr
* underscore

Install
=======

```
git clone git://github.com/stevefloat/freshstart
```
```
cd freshstart
```
```
npm install
```
```
cd public
```
```
bower install
```
```
cd .. && node app
```

> **NOTE** This install is being dramatically improved! Stay tuned for a dope bash script that makes a brand new repo that is linked to FreshStart for you.

### Using Gumby

Gumby.css is loaded in the ``` <head> ``` of the main layout file. Use it in your HTML/jade with zero setup required.

See [notes on Gumby](gumby-notes.md) for more information on the complex web of dependencies and compiling that is the Gumby framework.
