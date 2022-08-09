@parallel=false
Feature:  Creacion de articulos

  Background:

    * url baseUrl

  Scenario Outline: Creacion de articulo exitosa

    * def loginRequest = {"user":{"email":"<usuario>", "password":"<clave>"}}

    * def esperado =
      """{
    "user": {
    "id": #notnull,
    "email": "#notnull",
    "username": "#notnull",
    "bio": #null,
    "image": #null,
    "token": "#notnull"
    }
    } """


    Given path '/users/login'
    And request loginRequest
    And header Content-Type = 'application/json'
    And header X-Requested-With = 'XMLHttpRequest'
    When method post
    Then status 200
    And match response == esperado

    * def tokenSesion = response.user.token

    * def requestCreateArticle =
    """
    {
      "article": {
        "title": "<titulo>",
        "description": "<descripcion>",
        "body": "<cuerpo>",
        "tagList": [
          "<etiqueta1>",
          "<etiqueta2>"
        ]
      }
    }
    """

    Given path '/articles'
    And header Content-Type = 'application/json'
    And header X-Requested-With = 'XMLHttpRequest'
    And header Authorization = 'Token ' + tokenSesion
    And request requestCreateArticle
    When method post
    Then status 201

    * def slug = response.article.slug

    Given path '/articles'
    And header Content-Type = 'application/json'
    And header X-Requested-With = 'XMLHttpRequest'
    And header Authorization = 'Token ' + tokenSesion
    When method get
    Then status 200
    And match each response.articles.slug == slug

    #borrar articulo
    Given path '/articles/'+slug
    And header Content-Type = 'application/json'
    And header X-Requested-With = 'XMLHttpRequest'
    And header Authorization = 'Token ' + tokenSesion
    When method delete
    Then status 200

    Examples:

      | usuario         | clave    | titulo                                           | descripcion                                                                     | cuerpo                 | etiqueta1    |etiqueta2|
      | kike@correo.com | 12345678 | Características principales de la versión Java 8 | resalta los cambios que afectan a los usuarios finales en esta versión de Java. | Contenido sobre Java 8 | programacion |   Java 8      |
