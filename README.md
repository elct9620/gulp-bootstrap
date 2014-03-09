Gulp Bootstrap
==============

My [Fire.app](http://fireapp.kkbox.com) like gulp bootstrap.

Requirements
---

* Compass
* Node.js
* Gulp

Usage
---

* `gulp` - Compile all file into `dist/` (with `clean`)
* `gulp watch` - Watch and compile into `dist/`
* `gulp server` - Start `express` server and `livereload` on port 4000
* `gulp clean` - Clean `dist/`

Todo
---

* Add `test` task
* Run `clean` task before `server` task ( this now will block livereload )
* Add `ejs` helper and support load data like `json` and `yaml`
