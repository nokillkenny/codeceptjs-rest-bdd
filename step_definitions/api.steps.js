const { I } = inject();

let lastResponse;

When('I send a GET request to {string}', async (path) => {
  lastResponse = await I.sendGetRequest(path);
});

When('I send a POST request to {string} with:', async (path, table) => {
  const data = {};
  table.rows.forEach(row => { data[row.cells[0].value] = row.cells[1].value; });
  lastResponse = await I.sendPostRequest(path, data);
});

When('I send a PUT request to {string} with:', async (path, table) => {
  const data = {};
  table.rows.forEach(row => { data[row.cells[0].value] = row.cells[1].value; });
  lastResponse = await I.sendPutRequest(path, data);
});

When('I send a DELETE request to {string}', async (path) => {
  lastResponse = await I.sendDeleteRequest(path);
});

Then('I see response code {int}', (code) => {
  I.seeResponseCodeIs(code);
});

Then('the response contains {string}', (key) => {
  I.seeResponseContainsKeys([key]);
});

Then('the response is an array with more than {int} items', (count) => {
  const data = lastResponse.data;
  if (!Array.isArray(data) || data.length <= count) {
    throw new Error(`Expected array with more than ${count} items, got ${Array.isArray(data) ? data.length : 'non-array'}`);
  }
});
