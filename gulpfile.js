var gulp = require('gulp'),
    del = require('del'),
    run = require('gulp-run'),
    sass = require('gulp-sass'),
    cssmin = require('gulp-minify-css'),
    browserify = require('browserify'),
    uglify = require('gulp-uglify'),
    concat = require('gulp-concat'),
    jshint = require('gulp-jshint'),
    browserSync = require('browser-sync'),
    source = require('vinyl-source-stream'),
    buffer = require('vinyl-buffer'),
    reactify = require('reactify'),
    package = require('./package.json'),
    reload = browserSync.reload;
var debug = require('gulp-debug');

gulp.task('server', function() {
  browserSync({
    server: './app'
  });
});

// Compile sass into CSS & auto-inject into browsers
gulp.task('sass', function() {
  return gulp.src([package.paths.sass,package.paths.css])
  .pipe(sass())
  .pipe(concat(package.dest.style))
  .pipe(gulp.dest(package.dest.dist));
});
gulp.task('sass:min', function() {
  return gulp.src(package.paths.sass)
  .pipe(sass())
  .pipe(concat(package.dest.style))
  .pipe(cssmin())
  .pipe(gulp.dest(package.dest.dist));
});

/**
 * JSLint/JSHint validation
 */
gulp.task('lint', function() {
  return gulp.src(package.paths.js)
  .pipe(jshint())
  .pipe(jshint.reporter('default'));
});

/** JavaScript compilation */
gulp.task('js', function() {
  return browserify(package.paths.app)
  .transform(reactify)
  .bundle()
  .pipe(source(package.dest.app))
  .pipe(gulp.dest(package.dest.dist));
});
gulp.task('js:min', function() {
  return browserify(package.paths.app)
  .transform(reactify)
  .bundle()
  .pipe(source(package.dest.app))
  .pipe(buffer())
  .pipe(uglify())
  .pipe(gulp.dest(package.dest.dist));
});

/**
 * Compiling resources and serving application
 */
gulp.task('serve', ['lint', 'sass', 'js', 'server'], function() {
  return gulp.watch([
    package.paths.js, package.paths.jsx, package.paths.html, package.paths.sass
  ], [
   'lint', 'sass', 'js', browserSync.reload
  ]);
});

gulp.task('serve:minified', ['lint', 'sass:min', 'js:min', 'server'], function() {
  return gulp.watch([
    package.paths.js, package.paths.jsx, package.paths.html, package.paths.sass
  ], [
   'lint', 'sass:min', 'js:min', browserSync.reload
  ]);
});

gulp.task('default', ['serve']);