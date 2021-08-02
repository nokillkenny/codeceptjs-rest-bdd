const util = require('util');
const { I, CleaningSessionEndpoint } = inject();
let payload = {};

Given('I am testing the cleaning session API', async () => {
  CleaningSessionEndpoint.outputEndpoint();
})

When(/I generate a payload with roomsize:`(.*?)`, coordinates:`(.*?)`,patches:`(.*?)`,instructions:`(.*?)`/, async (roomSize, coords, patches, instructions) => {
  payload = CleaningSessionEndpoint.addParamsToPayload(payload,roomSize,coords,patches,instructions)
})

When(/I have a payload: `(.*?)`/,  async(stringifiedPayload) => {
  payload = JSON.parse(stringifiedPayload);
})

Then(/I post and expect this response: `(.*?)`/, async (expectedResponse) => {
  I.say(`Posting with: ${util.inspect(payload)}`);
  CleaningSessionEndpoint.postWith(payload,expectedResponse)
})

Then(/I post and expect this response: `(.*?)` with code: (.*?)/, async (expectedResponse,expectedResponseCode) => {
  CleaningSessionEndpoint.postWith(payload,expectedResponse,expectedResponseCode)
})
 
