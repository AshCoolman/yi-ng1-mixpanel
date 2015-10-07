var plumber = require('gulp-plumber');
var gulp = require('gulp');
var concat = require('gulp-concat');
var coffee = require('gulp-coffee');
var watch = require('gulp-watch');
var uglify = require('gulp-uglify');
var ngAnnotate = require('gulp-ng-annotate');

var files = [
    'src/ng-components/mixpanel/mixpanel.coffee',
    'src/ng-components/mixpanel/mixpanel.provider.coffee',
    'src/ng-components/mixpanel/mixpanel-track/mixpanel-track.coffee',
    'src/ng-components/mixpanel/mixpanel-track/mixpanel-track.directive.coffee'
]

gulp.task('default', function () {
    gulp.src(files)
        .pipe( coffee( { bare: true } ) )
        .pipe( ngAnnotate() )
        .pipe( uglify() )
        .pipe( concat('yi-ng-mixpanel.min.js') )
        .pipe( gulp.dest('dist') );
    return null;
});