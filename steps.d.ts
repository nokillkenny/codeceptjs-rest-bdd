/// <reference types='codeceptjs' />
type CleaningSessionEndpoint = typeof import('./cleaning-api-tests/step-definitions/cleaning-session.steps.js');
type AssertWrapper = import('codeceptjs-assert');

declare namespace CodeceptJS {
  interface SupportObject { I: I, current: any, CleaningSessionEndpoint: CleaningSessionEndpoint }
  interface Methods extends Playwright, REST, CustomHelper {}
  interface I extends WithTranslation<Methods> {}
  namespace Translation {
    interface Actions {}
  }
}
