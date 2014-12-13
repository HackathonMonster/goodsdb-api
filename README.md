# goodsdb-api [![Build Status](https://travis-ci.org/HackathonMonster/goodsdb-api.svg?branch=master)](https://travis-ci.org/HackathonMonster/goodsdb-api)

## About authentication

To authenticate, the request should contain the following header:

```
X-Token: USER_TOKEN
```

The token is received on login.

## Items

### GET `/items`

#### Request

* Needs authorization: yes

#### Response

* Content-Type: `application/json`
* Status: 200

```json
[
    {
        "id": 1,
        "name": "the-name",
        "createdAt": "2014-12-13T14:49:15+09:00",
        "updatedAt": "2014-12-13T14:49:15+09:00",
        "tags": [{
            "id": 1,
            "name": "tag-1",
            "createdAt": "2014-12-13T14:49:15+09:00",
            "updatedAt": "2014-12-13T14:49:15+09:00"
        }, {
            "id": 2,
            "name": "tag-2",
            "createdAt": "2014-12-13T14:49:15+09:00",
            "updatedAt": "2014-12-13T14:49:15+09:00"
        }],
        "pictures": [{
            "id": 1,
            "image_url": "http://mysuperserver/mysuperimage.jp",
            "createdAt": "2014-12-13T14:49:15+09:00",
            "updatedAt": "2014-12-13T14:49:15+09:00"
        }, {
            "id": 2,
            "image_url": "http://mysuperserver/mysuperimage2.jp",
            "createdAt": "2014-12-13T14:49:15+09:00",
            "updatedAt": "2014-12-13T14:49:15+09:00"
        }]
    }
]
```

### POST `/items`

#### Request

* Needs authorization: yes
* Content-Type: `multipart/form-data`

```
item[name] = "the-name"
item[tags][] = "tag-1"
item[tags][] = "tag-2"
item[picture][] = FILE_1_CONTENT
item[picture][] = FILE_2_CONTENT
```

Android sample:

```java
MultipartEntity data = new MultipartEntity(HttpMultipartMode.BROWSER_COMPATIBLE);
data.addPart("item[name]", new StringBody("the-name"));
data.addPart("item[tags][]", new StringBody("tag-1"));
data.addPart("item[tags][]", new StringBody("tag-2"));
data.addPart("item[picture][]", new FileBody(new File("gimmethatfile.jpg")));
data.addPart("item[picture][]", new FileBody(new File("gimmethatfile2.jpg")));
```

#### Response

* Content-Type: `application/json`
* Status: 201

```json
{
    "id": 1,
    "name": "the-name",
    "createdAt": "2014-12-13T14:49:15+09:00",
    "updatedAt": "2014-12-13T14:49:15+09:00",
    "tags": [{
        "id": 1,
        "name": "tag-1",
        "createdAt": "2014-12-13T14:49:15+09:00",
        "updatedAt": "2014-12-13T14:49:15+09:00"
    }, {
        "id": 2,
        "name": "tag-2",
        "createdAt": "2014-12-13T14:49:15+09:00",
        "updatedAt": "2014-12-13T14:49:15+09:00"
    }],
    "pictures": [{
        "id": 1,
        "image_url": "http://mysuperserver/gimmethatfile.jp",
        "createdAt": "2014-12-13T14:49:15+09:00",
        "updatedAt": "2014-12-13T14:49:15+09:00"
    }, {
        "id": 2,
        "image_url": "http://mysuperserver/gimmethatfile2.jp",
        "createdAt": "2014-12-13T14:49:15+09:00",
        "updatedAt": "2014-12-13T14:49:15+09:00"
    }]
}
```

## Authentication

### POST `/login`

#### Request

* Needs authorization: no
* Content-Type: `application/json`

```json
{
    "facebook_id": "67123214",
    "facebook_token": "jkwqejh71y273h21uehwje1237wheqwjhe217312"
}
```

#### Response

* Content-Type: `application/json`
* Status: 200 on success, 401 on not authorized

```json
{
    "id": 1,
    "first_name": "first name",
    "last_name": "last name",
    "display_name": "display name",
    "profile_picture": "https://www.facebook.com/mypicture.jpg",
    "token": "jkwqejh71y273h21uehwje1237wheqwjhe217312",
    "created_at": "2014-12-13T14:49:15+09:00",
    "updated_at": "2014-12-13T14:49:15+09:00"
}
```
