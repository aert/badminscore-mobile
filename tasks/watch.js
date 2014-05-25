module.exports = {
    coffee: {
        files: ["app/**/*.coffee", "app/**/*.js"],
        tasks: "dev"
    },
    less: {
        files: ["app/**/*.less", "app/**/*.css"],
        tasks: "dev"
    },
    jade: {
        files: ["app/**/*.jade", "app/**/*.html"],
        tasks: ["dev"]
    }
};
