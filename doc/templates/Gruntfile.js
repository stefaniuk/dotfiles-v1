module.exports = function(grunt) {
    require('load-grunt-tasks')(grunt);

    grunt.initConfig({
        watch: {
            config: {
                files: ['Gruntfile.js'],
                options: {
                    reload: true
                }
            },
            scripts: {
                files: ['assets/js/**/*.js'],
                tasks: ['concat:application', 'uglify:application'],
                options: {
                    debounceDelay: 250
                }
            },
            styles: {
                files: ['assets/sass/**/*.sass'],
                tasks: ['sass:application', 'cssmin:application'],
                options: {
                    debounceDelay: 250
                }
            }
        }
    });

    grunt.registerTask('default', [
        'scripts',
        'styles',
        'images'
    ]);
    grunt.registerTask('scripts', [
        // vendor
        'concat:vendor-all-js',
        // application
        'jshint:application',
        'concat:application',
        'uglify:application'
    ]);
    grunt.registerTask('styles', [
        // vendor
        'cssmin:vendor-highlightjs',
        'concat:vendor-all-css',
        // application
        'sass:application',
        'csslint:application',
        'cssmin:application'
    ]);
    grunt.registerTask('images', [
        'image_resize:logo',
        'imagemin:logo'
    ]);

};
