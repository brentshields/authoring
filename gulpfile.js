var gulp  = require('gulp')
    exec = require('child_process').exec
    livereload = require('gulp-livereload');

function update() {
    exec('make', function(err, stdout, stderr) {
        console.log(stdout);
        console.log(stderr);
        livereload.changed();
    });
}

gulp.task('watch', function () {
    livereload.listen();
    gulp.watch(['docs/*']).on('change', update);
})
