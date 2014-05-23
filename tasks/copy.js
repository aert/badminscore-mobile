module.exports = {
    main: {
        files: [
            // Fonts
            {
                expand: true,
                cwd: "bower_components/bootswatch/fonts/",
                src: "*",
                dest: "build/static/fonts/"
            },
            // App images
            {
                expand: true,
                cwd: "app/styles/images/",
                src: "*",
                dest: "build/static/images/"
            },
            // Favicon
            {
                src: "app/favicon.ico",
                dest: "build/favicon.ico"
            }
        ]
    }
};
