# Реализация простейшей модели Авторизации\Аутентификации при помощи Elixir + Phoenix Framework + Guardian + JWT + Comeonin
## Регистрация

URL: 

http://localhost:8000/api/v1/sign_up

Запрос принимает объект следущего вида:

``` json
// POST
// Пароль не менее 6 символов
// Уникальный login

{
        "user": {
                  "name": "name",
                 "login": "login",
                 "password": "password"
        } 
}
```

На выходе:

``` json
{
    "jwt": "eyJhbGciOiJIUz...",
    "status": "ok",
    "user": {
        "id": 1,
        "inserted_at": "2021-03-01T10:31:19",
        "login": "login",
        "name": "name",
        "password_hash": "$2b$12$CJST7u0lhV....",
        "updated_at": "2021-03-01T10:31:19"
    }
}
```

## Вход по логину и паролю

URL: 

http://localhost:8000/api/v1/sign_in

Запрос принимает объект следущего вида:

``` json
// POST

{
	"user": {
		"login": "login",
		"password": "password"
	}
}
```

На выходе:

``` json
{
    "jwt": "eyJhbGciOiJIUz...",
    "status": "ok",
    "user": {
        "id": 1,
        "inserted_at": "2021-03-01T20:54:26",
        "login": "login",
        "name": "Vname",
        "password_hash": "$2b$12$HxsQ5...",
        "updated_at": "2021-03-01T20:55:55"
    }
}
```

## Вход по токену

URL: 

http://localhost:8000/api/sign_in_jwt

Запрос принимает объект следущего вида:

``` json
// GET
// Необходима авторизация через Bearer токен

```

На выходе:

``` json
{
    "jwt": "eyJhbGciOiJIUzUx...,
    "status": "ok",
    "user": {
        "id": 1,
        "inserted_at": "2021-03-01T20:54:26",
        "login": "login",
        "name": "name",
        "password_hash": "$2b$12$HxsQ5...,
        "updated_at": "2021-03-01T20:55:55"
    }
}
```

## Обновление данных

URL: 

http://localhost:8000/api/v1/update

Звпрос принимает объект следущего вида:

``` json
// POST
// Права на изменения есть только при вводе правильного пароля
// Уникальный login

{
         "login": "login",
         "password": "password",
        "user": {
                  "name": "name123",
                 "login": "login123",
                 "password": "password123"
        } 
}
```

На выходе:

``` json
{
    "status": "ok",
    "user": {
        "id": 1,
        "inserted_at": "2021-03-01T10:31:19",
        "login": "login123",
        "name": "name123",
        "password_hash": "$2b$12$3Ui...",
        "updated_at": "2021-03-02T10:41:20"
    }
}
```

## Удаление пользователя

URL: 

http://localhost:8000/api/v1/delete

Запрос принимает объект следущего вида:

``` json
// DELETE
// Права на удаление пользователя есть только при вводе правильного пароля

{
     "login": "login",
     "password": "password"
}
```

На выходе:

``` json
{
    "status": "ok",
    "user": {
        "id": 1,
        "inserted_at": "2021-03-01T10:31:19",
        "login": "login",
        "name": "name",
        "password_hash": "$2b$12$3Ui...",
        "updated_at": "2021-03-01T10:41:20"
    }
}
```

## Вывод списка пользователей

URL: 

http://localhost:8000/api/v1/list_users
``` json 
// GET
```

На выходе:

``` json
{
    "List_Users": [
        {
            "id": 2,
            "inserted_at": "2021-03-01T20:54:33",
            "login": "login2",
            "name": "name",
            "password_hash": "$2b$12...",
            "updated_at": "2021-03-01T20:54:33"
        },
        {
            "id": 3,
            "inserted_at": "2021-03-03T20:54:26",
            "login": "login3",
            "name": "name",
            "password_hash": "$2b$12$HxsQ5...",
            "updated_at": "2021-03-02T20:55:55"
        }
    ]
}
```
## Получить пользователя по id

URL: 

localhost:8000/api/v1/by_id

Запрос принимает объект следущего вида:

``` json
// POST

{

    "id": "1"

}
```

На выходе:

``` json
{
    "user": {
        "id": 1,
        "inserted_at": "2021-03-01T16:47:10",
        "login": "login",
        "name": "name",
        "password_hash": "$2b$12$ZtCAT9...",
        "updated_at": "2021-03-01T16:47:10"            
}
```
