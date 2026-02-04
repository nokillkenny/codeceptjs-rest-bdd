exports.config = {
  tests: './*_test.js',
  output: './reports',
  helpers: {
    REST: {
      endpoint: process.env.API_URL || 'https://jsonplaceholder.typicode.com',
    },
    JSONResponse: {}
  },
  gherkin: {
    features: './features/*.feature',
    steps: [
      './step_definitions/api.steps.js',
      './step_definitions/data-driven.steps.js'
    ]
  },
  plugins: {
    allure: { enabled: false }
  },
  mocha: {
    reporterOptions: {
      reportDir: 'reports',
      reportFilename: 'report',
      html: true,
      json: false
    }
  },
  name: 'codeceptjs-rest-bdd'
};
