var gulp        = require('gulp');
var browserify  = require('browserify');
var concat      = require('gulp-concat');
var riot        = require('gulp-riot');
var sass        = require('gulp-sass');
var source      = require('vinyl-source-stream');
var sourcemaps  = require('gulp-sourcemaps');
var browserSync = require('browser-sync');
var reload      = browserSync.reload;

// Convert scss to css
gulp.task('scss', function() {
  gulp.src('./app/assets/scss/*.scss')
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('./app/assets/css/'))
});

// Compact all the css to one file
gulp.task('concatcss', function() {
  return gulp.src('./app/assets/css/*.css')
    .pipe(concat('styles.css'))
    .pipe(gulp.dest('./app/'));
});

// Concat all the tag files and then convert
gulp.task('concattag', function() {
  return gulp.src('./app/src/*.tag')
    .pipe(concat('alltags.tag'))
    .pipe(gulp.dest('./app/'));
});

// Compile the all tag file
gulp.task('compiletag', ['concattag'], function() {
  return gulp.src('./app/alltags.tag')
    .pipe(riot())
    .pipe(gulp.dest('./app/'));
});

// Convert all custom js files into one js
gulp.task('js', function () {
  gulp.src('app/assets/js/**/*.js')
  .pipe(concat('allcustomfiles.js'))
  .pipe(gulp.dest('app'))
});

// Build out the requires
gulp.task('build', function() {
  browserify('./app/app.js')
  .bundle()
  .pipe(source('bundle.js'))
  .pipe(gulp.dest('./app/'));
});

gulp.task('server', function() {
  browserSync({
    server: './app',
    port: 8080
  });
  gulp.watch("app/*.html").on('change', reload);
  gulp.watch("app/src/*.tag").on('change', reload);
});

gulp.task('default', ['scss','concatcss','compiletag', 'js','server']);