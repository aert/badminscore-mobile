module.exports = {
    main: {
        files: [
            // Fonts
            {
                expand: true,
                cwd: "bower_components/Metro-UI-CSS/fonts/",
                src: [ 
                    "iconFont.eot",
                    "iconFont.svg",
                    "iconFont.ttf",
                    "iconFont.woff"
                ],
                dest: "build/static/fonts/"
            },
            // App images
            {
                expand: true,
                cwd: "app/styles/images/",
                src: "*",
                dest: "build/static/images/"
            }
        ]
    }
};
