# goodsdb-api

## `GET /items`

* Needs authorization: yes
* Content-Type: `application/json`

```json
[
    {
        "id": 1,
        "name": "the-name",
        "createdAt", "2014-12-13T14:49:15+09:00",
        "updatedAt", "2014-12-13T14:49:15+09:00",
        "tags": [{
            "id": 1,
            "name": "tag-1",
            "createdAt", "2014-12-13T14:49:15+09:00",
            "updatedAt", "2014-12-13T14:49:15+09:00"
        }, {
            "id": 2,
            "name": "tag-2",
            "createdAt", "2014-12-13T14:49:15+09:00",
            "updatedAt", "2014-12-13T14:49:15+09:00"
        }],
        "pictures": [{
            "id": 1,
            "url": "http://mysuperserver/mysuperimage.jp",
            "createdAt", "2014-12-13T14:49:15+09:00",
            "updatedAt", "2014-12-13T14:49:15+09:00"
        }, {
            "id": 2,
            "url": "http://mysuperserver/mysuperimage2.jp",
            "createdAt", "2014-12-13T14:49:15+09:00",
            "updatedAt", "2014-12-13T14:49:15+09:00"
        }]
    }
]
```

## `POST /items`

* Needs authorization: yes
* Content-Type: `multipart/form-data`

```
items[name] = "the-name"
items[tags][] = "tag-1"
items[tags][] = "tag-2"
items[picture][] = FILE_1_CONTENT
items[picture][] = FILE_2_CONTENT
```

Android sample:

```java
MultipartEntity data = new MultipartEntity(HttpMultipartMode.BROWSER_COMPATIBLE);
data.addPart("items[name]", new StringBody("the-name"));
data.addPart("items[tags][]", new StringBody("tag-1"));
data.addPart("items[tags][]", new StringBody("tag-2"));
data.addPart("items[picture][]", new FileBody(new File("gimmethatfile.jpg")));
data.addPart("items[picture][]", new FileBody(new File("gimmethatfile2.jpg")));
```
