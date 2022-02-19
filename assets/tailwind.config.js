module.exports = {
    content: ["./js/**/*.js", "../lib/*_web.ex", "../lib/*_web/**/*.*ex"],
    theme: {
        fontFamily: {
            mono: ["DejaVu Sans Code", "DejaVu LGC Sans Code", "DejaVu Sans Mono", "monospace"],
        },
        extend: {},
        container: {
            center: true,
        },
    },
    plugins: [require("@tailwindcss/forms")],
};
