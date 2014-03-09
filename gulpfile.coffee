###
# Main Tasks file
###

gulp = require("gulp")
gutil = require("gulp-util")
notify = require("gulp-notify")
rename = require("gulp-rename")

SASS_PATH = "sass/**/*.scss"
COFFEE_PATH = "coffeescripts/**/*.coffee"
IMAGES_PATH = "images/**/*"
EJS_TEMPLATE = "**/*.ejs"
EJS_IGNORE_TEMPLATE = "!**/*.ejs"
DIST_PATH = "dist/"

# Compass
compass = require("gulp-compass")
minifyCSS = require("gulp-minify-css")

gulp.task "compass", ->
  gulp.src SASS_PATH
      .pipe compass({
        config_file: "config.rb"
        css: "stylesheets/"
      })
      .on "error", gutil.log
      .pipe gulp.dest(DIST_PATH + "stylesheets/")
      .pipe gulp.rename({suffix: ".min"})
      .pipe minifyCSS()
      .pipe gulp.dest(DIST_PATH + "stylesheets/")
      .pipe notify({message: "Compass task complete."})

# Bower
bower = require("gulp-bower")

gulp.task "bower", ->
  bower().pipe gulp.dest(DIST_PATH + "vendor/")
         .pipe notify({message: "Bower task complete."})

# CoffeeScript
coffee = require("gulp-coffee")
concat = require("gulp-concat")
uglify = require("gulp-uglify")

gulp.task "coffee", ->
  gulp.src COFFEE_PATH
      .pipe coffee()
      .on "error", gutil.log
      .pipe gulp.dest(DIST_PATH + "javascripts/")
      .pipe concat("main.js")
      .pipe gulp.dest(DIST_PATH + "javascripts/")
      .pipe rename({suffix: ".min"})
      .pipe uglify()
      .pipe gulp.dest(DIST_PATH + "javascripts/")
      .pipe notify({message: "CoffeeScript task complete."})

# EJS
gulp.task "ejs", ->
  gulp.src [EJS_TEMPLATE, EJS_IGNORE_TEMPLATE]
      .pipe ejs()
      .on "error", gutil.log
      .pipe gulp.dest(DIST_PATH)
      .pipe notify({message: "EJS task complete."})

# Images
imagemin = require("gulp-imagemin")

gulp.task "images", ->
  gulp.src IMAGES_PATH
      .pipe imagemin({ optimizationLevel: 3, progressive: true, interlaced: true })
      .pipe gulp.dest(DIST_PATH + "images/")
      .pipe notify({message: "Images task complete."})


# Watch
gulp.task "watch", ->
  gulp.watch "bower.json", ["bower"]
  gulp.watch SASS_PATH, ["compass"]
  gulp.watch COFFEE_PATH, ["coffee"]
  gulp.watch EJS_TEMPLATE, ["ejs"]
  gulp.watch IMAGES_PATH, ["images"]

# Clean
clean = require("gulp-clean")

gulp.task "clean", ->
  gulp.src DIST_PATH, {read: false}
      .pipe clean()

# Default Task
gulp.task "default", ["clean"], ->
  gulp.start "watch"
