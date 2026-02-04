@api
Feature: JSONPlaceholder API
  REST API testing against jsonplaceholder.typicode.com

  Scenario: Get all posts
    When I send a GET request to "/posts"
    Then I see response code 200
    And the response is an array with more than 0 items

  Scenario: Get single post
    When I send a GET request to "/posts/1"
    Then I see response code 200
    And the response contains "userId"
    And the response contains "title"

  Scenario: Create a post
    When I send a POST request to "/posts" with:
      | title  | foo     |
      | body   | bar     |
      | userId | 1       |
    Then I see response code 201
    And the response contains "id"

  Scenario: Update a post
    When I send a PUT request to "/posts/1" with:
      | title | updated title |
    Then I see response code 200

  Scenario: Delete a post
    When I send a DELETE request to "/posts/1"
    Then I see response code 200

  Scenario: Get user's posts
    When I send a GET request to "/posts?userId=1"
    Then I see response code 200
    And the response is an array with more than 0 items

  Scenario: Get non-existent resource
    When I send a GET request to "/posts/9999"
    Then I see response code 404
