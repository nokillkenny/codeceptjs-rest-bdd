// const { setHeadlessWhen } = require('@codeceptjs/configure');

// setHeadlessWhen(process.env.HEADLESS);

exports.config = {
  tests: './todomvc-tests/**/*_test.js',
  output: './output',
  helpers: {
    REST: {
      endpoint: process.env.CODECEPT_URL || 'http://localhost:8080/',
      defaultHeaders: {
        // 'Content-Type': 'application/json'
      }
    },
    "AssertWrapper" : {
      "require": "codeceptjs-assert"
    }
  },

  gherkin: {
    features: './cleaning-api-tests/features/*.feature',
    steps: [
      './cleaning-api-tests/step-definitions/cleaning-session.steps.js'
    ]
  },

  include: {
    CleaningSessionEndpoint: './cleaning-api-tests/endpoints/cleaning-session.api.js'
  },
  bootstrap: null,
  mocha: {},
  name: 'codecept demo tests'
}