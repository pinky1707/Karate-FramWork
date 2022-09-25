Feature: jsonHolder Post User API validation

  Background: 
    * url baseUrl = 'https://jsonplaceholder.typicode.com'
    * path getUsersPath = '/posts'
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
    
     @jsonFile
  Scenario: Post a user with json
    Given header Accept = 'application/json'
    When request payload
    And method POST
    Then status 201
    
    @setJsonRequest
  Scenario: Post a user with json
    Given header Accept = 'application/json'
    #* set payload.userId = 1
    When request payload
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
   