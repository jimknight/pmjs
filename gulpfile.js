var gulp        = require('gulp');
var browserSync = require('browser-sync');
var concat      = require('gulp-concat');
var react       = require('gulp-react');
var sass        = require('gulp-sass');
var sourcemaps  = require('gulp-sourcemaps');
var reload      = browserSync.reload;

// Static Server + watching scss/html files
gulp.task('serve', ['javascript','sass','jsx'], function() {
    browserSync({
        server: "./app"
    });
    gulp.watch("app/scss/*.scss", ['sass']);
    gulp.watch("app/jsx/*.jsx", ['jsx']);
    gulp.watch("app/js/*.js", ['javascript']);
    gulp.watch("app/*.html").on('change', reload);
    gulp.watch("app/js/*.js").on('change', reload);
});

gulp.task('javascript', function() {
  return gulp.src('app/js/*.js')
    .pipe(sourcemaps.init())
      .pipe(concat('all.js'))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('app'));
});

// Compile sass into CSS & auto-inject into browsers
gulp.task('sass', function() {
    return gulp.src("app/scss/*.scss")
        .pipe(sass())
        .pipe(gulp.dest("app/css"))
        .pipe(reload({stream: true}));
});

// React
gulp.task('jsx', function () {
    return gulp.src("app/jsx/*.jsx")
        .pipe(sourcemaps.init())
        .pipe(react())
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest('app/js/'));
});

gulp.task('default', ['serve']);