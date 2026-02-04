@api @data-driven
Feature: Data-driven API tests
  Parameterized scenarios using example tables

  Scenario Outline: Create posts with various data
    When I create a post with title:"<title>", body:"<body>", userId:<userId>
    Then I see response code 201
    And the response contains "id"

    Examples:
      | title              | body                    | userId |
      | Simple post        | Basic content           | 1      |
      | Post with numbers  | Content 123 456         | 2      |
      | Unicode: café      | Body with émojis 🎉     | 1      |
      | Empty body test    |                         | 3      |

  Scenario Outline: Filter posts by user
    When I get posts for userId:<userId>
    Then I see response code 200
    And all posts belong to userId:<userId>

    Examples:
      | userId | expectedMin |
      | 1      | 5           |
      | 2      | 5           |
      | 3      | 5           |

  Scenario Outline: Validate post structure
    When I fetch post <postId>
    Then I see response code <expectedCode>
    And the response matches schema:<schema>

    Examples:
      | postId | expectedCode | schema       |
      | 1      | 200          | validPost    |
      | 100    | 200          | validPost    |
