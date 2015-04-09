var gulp        = require('gulp');
var browserify  = require('browserify');
var concat      = require('gulp-concat');
var gutil       = require('gulp-util');
var riot        = require('gulp-riot');
var sass        = require('gulp-sass');
var source      = require('vinyl-source-stream');
var replace     = require('gulp-replace');
var sourcemaps  = require('gulp-sourcemaps');
var browserSync = require('browser-sync');
var reload      = browserSync.reload;
var rsync       = require('rsyncwrapper').rsync;
var debug       = require('gulp-debug');

// Deploy
gulp.task('deploy', ['compiletag','localreplace'], function() {
  rsync({
    ssh: true,
    src: './app/',
    dest: 'deployer@projectmailboxes.com:/home/deployer/apps/pmjs/',
    recursive: true,
    syncDest: true,
    args: ['--verbose']
  }, function(error, stdout, stderr, cmd) {
      gutil.log(stdout);
  });
});

gulp.task('localreplace', function(){
  gulp.src('./app/alltags.js')
    .pipe(replace(/http:\/\/localhost:3000/g, ''))
    .pipe(gulp.dest('./app/'));
});

// Convert scss to css
gulp.task('scss', function() {
  gulp.src('./app/assets/scss/*.scss')
    .pipe(sass())
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
    .pipe(debug({title: 'src:'}))
    .pipe(concat('alltags.tag'))
    .pipe(gulp.dest('./app/'))
    .pipe(debug({title: 'dest:'}));
});

// Compile the all tag file
gulp.task('compiletag', function() {
  return gulp.src('./app/alltags.tag')
    .pipe(debug({title: 'src:'}))
    .pipe(riot())
    .pipe(gulp.dest('./app/'))
    .pipe(debug({title: 'dest:'}));
});

// Convert all custom js files into one js
gulp.task('js', function () {
  gulp.src('app/assets/js/**/*.js')
  .pipe(concat('allcustomfiles.js'))
  .pipe(gulp.dest('app'))
});

gulp.task('server', function() {
  browserSync({
    server: './app',
    port: 8080
  });
  gulp.watch("./app/assets/scss/*.scss", ['scss']);
  gulp.watch("./app/assets/css/*.css", ['concatcss']);
  gulp.watch("./app/styles.css").on('change', reload);
  gulp.watch("./app/*.html").on('change', reload);
  gulp.watch("./app/src/*.tag", ['concattag']);
  gulp.watch("./app/alltags.tag", ['compiletag']);
  gulp.watch("./app/alltags.js").on('change', reload);
  gulp.watch("./app/src/*.tag").on('change', reload);
});

gulp.task('default', ['scss','concatcss','compiletag', 'js','server']);