module.exports = {
    compile: {
        expand: true,
        cwd: "app/",
        src: ['**/*.coffee'],
        dest: '.tmp/app/',
        ext: '.js',
        options: {
            bare: true
        }
    }
};
