module.exports = {
    html: "build/hello.html",
    options: {
        root: "./",
        dest: "build/",
        flow: {
            steps: { 'js': ['concat'], 'css': ['concat', 'cssmin']},
            post: {}
        }
    }
};
