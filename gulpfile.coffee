###
# Main Tasks file
###

gulp = require("gulp")
gutil = require("gulp-util")
notify = require("gulp-notify")
rename = require("gulp-rename")
cache = require("gulp-cached")

APP_PATH = "app/"
SASS_PATH = APP_PATH + "sass/**/*.scss"
COFFEE_PATH = APP_PATH + "coffeescripts/**/*.coffee"
IMAGES_PATH = APP_PATH + "images/**/*"
EJS_TEMPLATE = [APP_PATH + "**/*.html", APP_PATH + "**/*.ejs"]
EJS_IGNORE_TEMPLATE = [APP_PATH + "!**/_*.ejs"]
DIST_PATH = "dist/"

SERVER_PORT = 4000
SERVER_ROOT = __dirname + "/" + DIST_PATH
LIEVRELOAD_PORT = 35729

livereload = require("gulp-livereload")
server = null

# Compass
compass = require("gulp-compass")
minifyCSS = require("gulp-minify-css")

gulp.task "compass", ->
  gulp.src SASS_PATH
      .pipe cache("compass")
      .pipe compass({
        config_file: __dirname + "/config.rb"
        project: __dirname + "/" + APP_PATH
        css: "stylesheets/"
      })
      .on "error", gutil.log
      .pipe gulp.dest(DIST_PATH + "stylesheets/")
      .pipe rename({suffix: ".min"})
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
      .pipe cache("coffee")
      .pipe coffee()
      .on "error", gutil.log
      .pipe gulp.dest(DIST_PATH + "javascripts/")
      .pipe concat("main.js")
      .on "error", gutil.log
      .pipe gulp.dest(DIST_PATH + "javascripts/")
      .pipe rename({suffix: ".min"})
      .pipe uglify()
      .on "error", gutil.log
      .pipe gulp.dest(DIST_PATH + "javascripts/")
      .pipe notify({message: "CoffeeScript task complete."})

# EJS
ejs = require("gulp-ejs")

gulp.task "ejs", ->
  gulp.src EJS_TEMPLATE.concat(EJS_IGNORE_TEMPLATE)
      .pipe cache("ejs")
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

# Server
startExpress = ()->
  express = require("express")
  app = express()
  app.use(express.static(SERVER_ROOT))
  app.listen(SERVER_PORT)

startLivereload = ()->
  server = livereload(LIEVRELOAD_PORT)

  gulp.watch(DIST_PATH + "**/*").on "change", (file) ->
    server.changed file.path if server

gulp.task "server", ["build", "watch"], ->
  startExpress()
  startLivereload()

# Build
gulp.task "build", ["bower", "compass", "coffee", "images", "ejs"]

# Default Task
gulp.task "default", ["clean", "build"]
