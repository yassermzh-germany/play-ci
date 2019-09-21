const Jasmine = require("jasmine");
const jasmine = new Jasmine({});
jasmine.loadConfig({
    // spec_dir: 'spec',
    spec_files: ["package*/**/*[sS]pec.js"],
    helpers: ["helpers/**/*.js"],
    random: false,
    seed: null,
    stopSpecOnExpectationFailure: false
});

// setup console reporter
const JasmineConsoleReporter = require("jasmine-console-reporter");
const reporter = new JasmineConsoleReporter({
    colors: 1,
    cleanStack: 1,
    verbosity: 4,
    listStyle: "indent",
    timeUnit: "ms",
    timeThreshold: { ok: 500, warn: 1000, ouch: 3000 },
    activity: true,
    emoji: true,
    beep: true
});

jasmine.env.clearReporters();
jasmine.addReporter(reporter);
jasmine.execute();
