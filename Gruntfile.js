module.exports = function(grunt) {

    // Constants

    // Project Config
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        clean: require("./tasks/clean"),
        copy: require("./tasks/copy"),
        less: require("./tasks/less.js"),
        coffee: require("./tasks/coffee.js"),
        jade: require("./tasks/jade.js"),
        filerev: require("./tasks/filerev.js"),
        useminPrepare: require("./tasks/useminPrepare.js"),
        usemin: require("./tasks/usemin.js"),
        watch: require("./tasks/watch.js")
    });

    // Dependencies
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-cssmin');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-filerev');
    grunt.loadNpmTasks('grunt-usemin');
    grunt.loadNpmTasks('grunt-contrib-watch');

    // Tasks
    grunt.registerTask('default', [
        "clean:build",
        "copy",
        "less",
        "coffee",
        "jade",
        "useminPrepare",
        "concat",
        "uglify",
        "cssmin",
        "filerev",
        "usemin"
    ]);

};
