# CodeceptJS REST BDD

![CI](https://github.com/nokillkenny/codeceptjs-rest-bdd/actions/workflows/test.yml/badge.svg)

REST API testing with CodeceptJS using Gherkin BDD syntax.

## Stack
- CodeceptJS 3.6
- REST helper
- Mochawesome reporter

## Setup

```bash
npm install
```

## Run Tests

```bash
# Run all tests
npm test

# With HTML report
npm run test:report
```

## Structure

```
├── features/           # Gherkin feature files
├── step_definitions/   # Step implementations
├── reports/            # Test output
└── codecept.conf.js    # Configuration
```

## CI

Tests run in GitHub Actions with HTML reports uploaded as artifacts and aggregated to a central dashboard.
