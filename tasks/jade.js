module.exports = {
    compile: {
        options: {
            pretty: true
        },
        files: [{
            expand: true,
            cwd: "app/",
            src: ['**/*.jade'],
            dest: 'build/',
            ext: '.html'
        }]
    }
};
