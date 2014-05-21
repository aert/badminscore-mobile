module.exports = {
    coffee: {
        files: ["app/**/*.coffee", "app/**/*.js"],
        tasks: "default"
    },
    less: {
        files: ["app/**/*.less", "app/**/*.css"],
        tasks: "default"
    },
    jade: {
        files: ["app/**/*.jade", "app/**/*.html"],
        tasks: ["default"]
    }
};
