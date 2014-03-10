Gulp Bootstrap
==============

My [Fire.app](http://fireapp.kkbox.com) like gulp bootstrap.

Requirements
---

* Compass
  `gem install compass`
* Gulp
  `npm install -g gulp`

Install
---

* Download the [zip](https://github.com/elct9620/gulp-bootstrap/archive/master.zip) and Extract
* npm install
* Modify `package.json` to your project config
  Note: You can also add `bower.json` or edit `gulpfile.coffee` to change config
* Starting using it

Usage
---

* `gulp` - Compile all file into `dist/` (with `clean`)
* `gulp watch` - Watch and compile into `dist/`
* `gulp server` - Start `express` server and `livereload` on port 4000
* `gulp clean` - Clean `dist/`
* `gulp test`( `npm test` ) - Using `mocha` to test, use `BDD` style and pre require `chai.should()`

Todo
---

* Run `clean` task before `server` task ( this now will block livereload )
* Add `ejs` helper and support load data like `json` and `yaml`
