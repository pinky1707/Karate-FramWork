Feature: gorest Get Users api validation

  Background: 
    * def baseUrl = 'https://gorest.co.in'
    * def getUsersPath = '/public/v2/posts'

  @sample
  Scenario: A sample karate scenario
    * print "<--------Hello World------->"

  Scenario: gorest Get Users jsonPath
    Given url 'https://gorest.co.in/public/v2/posts'
    When method GET
    Then status 200
    And print response[0].id
    * def ids = karate.jsonPath(response, '$..id')
    * print ids
    And match karate.sizeOf(ids) == 10

  @background @smoke
  Scenario: Use of Background
    Given url baseUrl

  @getUser
  Scenario: find specific user
    Given url baseUrl
    And path getUsersPath +  '/'
    When method GET
    Then status 200

  @negative
  Scenario: find specific user
    Given url baseUrl
    And path getUsersPath + '/1'
    When method Get
    Then status 404 
    * match response.message == "Resource not found"

