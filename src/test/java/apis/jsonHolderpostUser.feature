Feature: jsonHolder Post User API validation

  Background: 
    * url baseUrl = jsonHolderBaseUri
    * path getUsersPath = getUsersPathJsonHolder
    * def payload = read('classpath:user.json')

  # And header Authorization = 'Bearer xxx'
  @postUser
  Scenario: Post a user
    Given header Accept = 'application/json'
    When request { "id": 1,"title": "foo","body": "bar","userId": 1}
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == 1
    And match response.body contains 'b'

  @jsonFile
  Scenario: Post a user with json
    Given header Accept = 'application/json'
    When request payload
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == payload.userId
    And match response.body contains payload.body.charAt(0)

  @setJsonRequest
  Scenario: Post a user with json
    Given header Accept = 'application/json'
    * set payload.userId = 10
    When request payload
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == payload.userId
    And match response.body contains payload.body.charAt(0)

  @dataDriven @smoke @regression
  Scenario Outline: Test for - <id>
    Given header Accept = 'application/json'
    #* set payload.id = <id>
    * set payload.title = <title>
    * set payload.body = <body>
    * set payload.userId = <userId>
    When request payload
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    #Then match response.id == payload.id
    And match response.title == payload.title
    And match response.userId == payload.userId
    And match response.body contains payload.body.charAt(0)
    
    Examples: 
      | id     | title|        body | userId |
      | DataDriven1 | 'Karate -1'|'X'  |    101 |
      | DataDriven2 | 'Karate-2'|'Y'  |    102 |
      | DataDriven3 | 'Karate-3'|'Z'  |    103  |
