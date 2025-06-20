@REQ_BP
Feature: Character

  Background:
      * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/gdelosri/api/'
  
  #delete
  @id:1 @marvelCharactersAPI @delete
  Scenario: API-MARVELCHARACTERS-0000-CA1 Delete Character - Unsuccess, not found
    Given path 'characters/4'
    When method DELETE
    Then status 404
    And match response contains {"error":"Character not found"}

  @id:2 @marvelCharactersAPI @delete
  Scenario: API-MARVELCHARACTERS-0000-CA2 Delete Character - Success
    Given path 'characters/5'
    When method DELETE
    Then status 204
  
  #create
  @id:3 @marvelCharactersAPI @create
  Scenario: API-MARVELCHARACTERS-0000-CA3 Create Character - Success
    Given path 'characters'
    And def character = read('classpath:./data/char.json')
    And request character
    When method POST
    Then status 201

  @id:4 @marvelCharactersAPI @create
  Scenario: API-MARVELCHARACTERS-0000-CA4 Create Character - Unsuccess, incomplete, bad request
    Given path 'characters'
    And def character = read('classpath:./data/char_incomplete.json')
    And request character
    When method POST
    Then status 400

  @id:5 @marvelCharactersAPI @create
  Scenario: API-MARVELCHARACTERS-0000-CA5 Create Character - Unsuccess, duplicate name, bad request
    Given path 'characters'
    And def character = read('classpath:./data/char.json')
    And request character
    When method POST
    Then status 400
    And match response contains {"error": "Character name already exists"}

  #update
  @id:6 @marvelCharactersAPI @update
  Scenario: API-MARVELCHARACTERS-0000-CA6 Update Character - Unsuccess, not found
    Given path 'characters/5'
    And def character_updated = read('classpath:./data/char_update.json')
    And request character_updated
    When method PUT
    Then status 404

  @id:7 @marvelCharactersAPI @update
  Scenario: API-MARVELCHARACTERS-0000-CA7 Update Character - Success
    Given path 'characters/6'
    And def character_updated = read('classpath:./data/char_update.json')
    And request character_updated
    When method PUT
    Then status 200

  #list
  @id:8 @marvelCharactersAPI @list
  Scenario: API-MARVELCHARACTERS-0000-CA7 List Characters
    Given path 'characters'
    When method GET
    Then status 200
    And print response

  #search
  @id:9 @marvelCharactersAPI @search
  Scenario: API-MARVELCHARACTERS-0000-CA8 Search character by ID - Success, 200
  Given path 'characters/6'
  When method GET
  Then status 200
  And print response

  @id:10 @marvelCharactersAPI @search
  Scenario: API-MARVELCHARACTERS-0000-CA9 Search character by ID - Failure, 404
  Given path 'characters/7'
  When method GET
  Then status 404
  And print response

