###
# Main Tasks file
###

gulp = require("gulp")
gutil = require("gulp-util")

SASS_PATH = "sass/**/*.scss"
COFFEE_PATH = "coffeescripts/**/*.coffee"
EJS_TEMPLATE = "**/*.ejs"
EJS_IGNORE_TEMPLATE = "!**/*.ejs"

# Compass
compass = require("gulp-compass")

gulp.task "compass", ->
  gulp.src SASS_PATH
      .pipe compass({
        config_file: "config.rb"
        css: "stylesheets/"
      })
      .on "error", gutil.log
      .pipe gulp.dest("stylesheets/")

# Bower
bower = require("gulp-bower")

gulp.task "bower", ->
  bower().pipe(gulp.dest("vendor/"))

# CoffeeScript
coffee = require("gulp-coffee")

gulp.task "coffee", ->
  gulp.src COFFEE_PATH
      .pipe coffee()
      .on "error", gutil.log
      .pipe gulp.dest "javascripts/"

# EJS
  gulp.task "ejs", ->
    gulp.src [EJS_TEMPLATE, EJS_IGNORE_TEMPLATE]
        .pipe ejs()
        .on "error", gutil.log
        .pipe gulp.dest "public/"

# Watch
gulp.task "watch", ->
  gulp.watch SASS_PATH, ["compass"]
  gulp.watch "bower.json", ["bower"]
  gulp.watch COFFEE_PATH, ["coffee"]
  gulp.watch EJS_TEMPLATE, ["ejs"]

# Default Task
gulp.task "default", ["watch"]
