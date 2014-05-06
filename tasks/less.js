module.exports = {
    production: {
        expand: true,
        cwd: "app/",
        src: ['**/*.less'],
        dest: '.tmp/app/',
        ext: '.css'
    }
};
