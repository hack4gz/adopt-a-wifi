gulp = require 'gulp'
gutil = require 'gulp-util'

del = require 'del'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
autoprefixer = require 'gulp-autoprefixer'
browserify = require 'browserify'
gulpBrowserify = require 'gulp-browserify'
rename = require 'gulp-rename'
watchify = require 'watchify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
sourcemaps = require 'gulp-sourcemaps'
glob = require 'glob'
nodemon = require 'gulp-nodemon'
livereload = require 'gulp-livereload'
_ = require 'lodash'

src =
  sass: './src/scss/**/*.scss'
  coffee: './src/coffee/**/*.coffee'

dest =
  css: './public/css/'
  js: './public/js/'

gulp.task 'nodemon', ->
  nodemon
    script: './bin/www'
    env: 'NODE_ENV': 'development'

gulp.task 'css:vendors', ->
  gulp.src('src/scss/vendors/*.*')
    .pipe(gulp.dest(dest.css + 'vendors/'))

gulp.task 'dev:css', ->
  gulp.src(src.sass)
    .pipe(sass(errLogToConsole: true))
    .pipe(autoprefixer(browsers: ['last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4']))
    .pipe(gulp.dest(dest.css))

gulp.task 'dev:js', ->
  glob src.coffee, {}, (err, files) ->
    _.each files, (file) ->
      filename = file.split('/').pop()
      bundler = watchify browserify(file, watchify.args)
      bundler.on 'error', gutil.log.bind(gutil, 'Browserify Error')

      bundler.bundle()
        .pipe(source(filename))
        .pipe(buffer())
        .pipe(rename(extname: '.js'))
        .pipe(sourcemaps.init(loadMaps: true))
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest(dest.js))

gulp.task 'watch', ->
  livereload.listen()
  gulp.watch ['src/scss/*.scss', 'src/scss/**/*.scss'], ['dev:css']
  gulp.watch ['src/coffee/*.coffee', 'src/coffee/**/*.coffee'], ['dev:js']
  gulp.watch(['public/**', 'views/**']).on 'change', livereload.changed

gulp.task 'build:css', ->
  gulp.src(src.sass)
    .pipe(sass(outputStyle: 'compressed'))
    .pipe(autoprefixer(browsers: ['last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4']))
    .pipe(gulp.dest(dest.css))

gulp.task 'build:js', ->
  gulp.src(src.coffee, read: false)
    .pipe(gulpBrowserify(extensions: ['.coffee'], debug: false))
    .pipe(uglify())
    .pipe(rename(extname: '.js'))
    .pipe(gulp.dest(dest.js))

gulp.task 'clean', ->
  del(["./public/css/*.css", "./public/js/*.js", "./public/js/*.js.map"])

gulp.task 'default', ['css:vendors', 'dev:css', 'dev:js', 'nodemon', 'watch']

gulp.task 'build', ['css:vendors', 'build:css', 'build:js']
