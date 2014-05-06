module.exports = {
    coffee: {
        files: ["app/**/*.coffee"],
        tasks: "coffee:compile"
    },
    jade: {
        files: ["app/**/*.jade"],
        tasks: ["jade:compile", "useminPrepare"]
    }
};
