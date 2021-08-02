const util = require('util');

const I = actor();
const endpoint = 'v1/cleaning-sessions';


module.exports = {
    outputEndpoint() {
        I.say(`Testing with endpoint = ${endpoint}`);
    },

    declareSummary(summary){
        I.say(`Testing for: ${summary}`);
    },

    addParamsToPayload(payload, roomSize, startingCoordinate, patches,instructions){
        // should add validation against undefined
        payload.roomSize = JSON.parse(roomSize);
        payload.coords = JSON.parse(startingCoordinate);
        payload.patches = JSON.parse(patches);
        payload.instructions = instructions;
        I.say(`payload: ${payload}`);
        return payload
    },

    async postWith(payload,expectedResponse, expectedResponseCode=200) {
        const expectedJson = JSON.parse(expectedResponse);

        const res = await I.sendPostRequest(endpoint,payload);
        // I.say(`actual response = ${util.inspect(res.data)}`);
        
        // would rather do object key comparison w/ more time
        await I.assertEqual(res.status,expectedResponseCode, `\nExpected status response:${res.status}\n to eql ${expectedResponseCode}`);
        await I.assertDeepEqual(res.data, expectedJson, `Asserting response: "${util.inspect(res.data)}" with to match expectation: ${util.inspect(expectedJson)}`);

    },
}