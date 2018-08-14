---
description: Manual com endpoints para utilização da API Agregador/Odoo
---

# Agregador API

{% api-method method="post" host="https://api.cakes.com" path="/book/create" %}
{% api-method-summary %}
Post Book
{% endapi-method-summary %}

{% api-method-description %}
O endpoint foi criado para receber os valores de criação dos livros.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-body-parameters %}
{% api-method-parameter name="json\_config" type="string" required=false %}
Json contendo toda a configuração utilizada para a criação do Livro. \(Enviar como string se possível\)
{% endapi-method-parameter %}

{% api-method-parameter name="hash\_user\_temp" type="string" required=false %}
Hash temporária criada pelo Agregador
{% endapi-method-parameter %}

{% api-method-parameter name="pdf\_id" type="string" required=false %}
Id retornado do post referente ao File enviado
{% endapi-method-parameter %}

{% api-method-parameter name="pids\_scielo" type="string" required=false %}
Ids dos artigos coletados na Scielo
{% endapi-method-parameter %}

{% api-method-parameter name="id\_temporario" type="string" required=false %}
Id temporário do Usuário
{% endapi-method-parameter %}

{% api-method-parameter name="name" type="string" required=false %}
Nome do Livro Criado
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
Cake successfully retrieved.
{% endapi-method-response-example-description %}

```javascript
{
    "id": "id do livro",
    "url_route": "Url para realizar o redirect"
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=400 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
{
    "error": "Não foi possível criar o livro
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=403 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
{
    "error": "Usuario não possui permissão"
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}



