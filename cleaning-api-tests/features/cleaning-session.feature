Feature: Testing Roomba app

Scenario Outline: Happy path Tests
    Given I am testing the cleaning session API
    When I generate a payload with roomsize:`<roomsize>`, coordinates:`<coords>`,patches:`<patches>`,instructions:`<instructions>`
    Then I post and expect this response: `<expectation>`
    Examples:
      |              summary                   | roomsize | coords| patches             | instructions|               expectation            |
      | 0 patches, traverse entire 5x5 grid    | [5,5]    | [0,0] | [] | NNNNESSSSSSENNNNESSSSSENNNNESSSSWNNNNNEWWSSSSW      | { "coords": [ 1, 0 ], "patches": 0 } |
      | 0 patches, start at 0 hit boundary     | [5,5]    | [0,0] | [] | W      | { "coords": [ 0, 0 ], "patches": 0 } |
      | All patches, land on last patch        | [5,5]    | [1,1] | [[1,0],[2,2],[2,3]] | SENNN       | { "coords": [ 2, 3 ], "patches": 3 } |
      | 2 patches                              | [5,5]    | [1,1] | [[1,0],[2,2],[2,3]] | SENNEN      | { "coords": [ 3, 3 ], "patches": 2 } |
      | 1 patch, revisit same path three times | [5,5]    | [1,1] | [[1,0],[2,2],[2,3]] | SNSNSN      | { "coords": [ 1, 1 ], "patches": 1 } |
      | Roomba doesn't go past boundaries      | [5,5]    | [1,1] | [[1,0]] |        NNNEEESSSSSSS      | {"coords":[4,0],"patches":0}         |
 
# Bug: Patches are being retained across different calls. Need to restart env to reset patch state
Scenario: Request info is not retained 
  Given I am testing the cleaning session API
  When I have a payload: `{"roomSize": [5,5],"coords": [1,1],"patches": [[1,1]],"instructions": "NS"}`
  Then I post and expect this response: `{ "coords": [ 1, 1 ], "patches": 1 }`
  When I have a payload: `{"roomSize": [5,5],"coords": [1,1],"patches": [[4,4]],"instructions": "NS"}`
  Then I post and expect this response: `{ "coords": [ 1, 1 ], "patches": 0 }`

# Bug: does not hoover on starting point
Scenario: Hoover is always on, even starting point
  Given I am testing the cleaning session API
  When I have a payload: `{"roomSize": [5,5],"coords": [1,2],"patches": [[1,2]],"instructions": ""}`
  Then I post and expect this response: `{ "coords": [ 1, 2 ], "patches": 1 }`


# Bug: Empty roomsize array throws 500 error "java.lang.ArrayIndexOutOfBoundsException: 0"
# Scenario: Test required field for roomsize
#   Given I am testing the cleaning session API
#   When I have a payload: `{"roomSize": [],"coords": [1,2],"patches": [[1,2]],"instructions": ""}`
#   Then I post and expect this response: `{"timestamp":"2021-08-02T13:37:30.937+0000","path":"/v1/cleaning-sessions","status":500,"error":"Internal Server Error","message":"0"}`

# Bug: Negative coordinates should not be accepted
# Scenario:  Negative coordinates should not be accepted
#   Given I am testing the cleaning session API
#   When I have a payload: `{"roomSize": [5,5],"coords": [2,68],"patches": [],"instructions": "EWEEWNNNEN"}`
#   Then Then I post and expect this response: `ERROR MESSAGE` with code: 400
  # Actual:
  # Then I post and expect this response: `{"coords":[4,68],"patches":0}`
  

# Bug: Starting coorindates can land outside room boundaries
# Scenario: Starting coordinates should throw error when outside the room boundary
#   Given I am testing the cleaning session API
#   When I have a payload: `{"roomSize": [],"coords": [1,2],"patches": [[1,2]],"instructions": ""}`
#   Then I post and expect this response: `{"timestamp":"2021-08-02T13:37:30.937+0000","path":"/v1/cleaning-sessions","status":500,"error":"Internal Server Error","message":"0"}`

# Bug: Coorindates, patches, and roomsize array can take more than 2 values
#   Given I am testing the cleaning session API
#   When I have a payload: `{"roomSize": [5, 5],"coords": [2,2],"patches": [[0,0,2],[2,2,0],[2,2,2]],"instructions": "NNNNNNSSSSSEEEWWWW"}`
#   Then I post and expect this response: `ERROR MESSAGE` with code: 400
  # Actual:
  # Then I post and expect this response: `{"coords":[0,0],"patches":6}`

# Todo: possible expected scenario. Or could add serverside validation error
# Scenario: Empty coordinate array throws 400
#   Given I am testing the cleaning session API
#   When I have a payload: `{"roomSize": [5,5],"coords": [],"patches": [[1,2]],"instructions": ""}`
#   Then I post and expect this response: `` with code: 400

