var gulp  = require('gulp')
var exec = require('child_process').exec

gulp.task('make', function() {
    exec('make', function(err, stdout, stderr) {
        console.log(stdout);
        console.log(stderr);
    });
})

gulp.task('watch', function () {
    gulp.watch(['docs/*'], ['make'])
})
