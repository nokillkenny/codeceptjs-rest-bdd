const { I } = inject();

let lastResponse;

const SCHEMAS = {
  validPost: ['userId', 'id', 'title', 'body'],
  empty: []
};

When('I create a post with title:{string}, body:{string}, userId:{int}', async (title, body, userId) => {
  lastResponse = await I.sendPostRequest('/posts', { title, body, userId });
});

When('I get posts for userId:{int}', async (userId) => {
  lastResponse = await I.sendGetRequest(`/posts?userId=${userId}`);
});

When('I fetch post {int}', async (postId) => {
  lastResponse = await I.sendGetRequest(`/posts/${postId}`);
});

Then('all posts belong to userId:{int}', (userId) => {
  const posts = lastResponse.data;
  const invalid = posts.filter(p => p.userId !== userId);
  if (invalid.length) {
    throw new Error(`Found ${invalid.length} posts not belonging to userId ${userId}`);
  }
});

Then('the response matches schema:{word}', (schemaName) => {
  const schema = SCHEMAS[schemaName];
  if (!schema) throw new Error(`Unknown schema: ${schemaName}`);
  if (schema.length === 0) return;
  
  const data = lastResponse.data;
  for (const key of schema) {
    if (!(key in data)) {
      throw new Error(`Missing required field: ${key}`);
    }
  }
});
