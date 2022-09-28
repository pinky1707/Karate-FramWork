Feature: Validating UI using Karate

 Background: 
    * def uiUrl = uriUrl
    * def locators = read("classpath:locators.json")

  @chrome
  Scenario: Google Chrome
    Given driver uriUrl
    And driver.maximize()
    And input(locators.searchInput,' electronics ')
    When click(locators.searchButton)
    * def out = text(locators.itemCount)
    Then print out

  @firefox
  Scenario: Firefox
    * configure driver = {type:'geckodriver',executable:"#('C:/Users/Sonjo/eclipse-workspace/karate.framwork/driver/geckodriver.exe')"}
    Given driver 'https://www.costco.com/'

  @edge
  Scenario: EDGE
    * configure driver = {type:'msedge'}
    Given driver 'https://www.costco.com/'
    
    @anotherFeature
  Scenario: call another feature with tag
    Then call read('classpath:uis/helper.feature')

  @scenarioWithTag
  Scenario: call another feature with tag
    Then call read('classpath:uis/helper.feature@tagged')

  @dynamicFeature
  Scenario: call another feature with tag and dynamic input
    Then call read('classpath:uis/helper.feature@dynamic'){input:"#('This is a dynamic input with tag scenario')"}
