# Learning Mongodb

## API Endpoints

1) **User#create** (Create a new user)

---------------------------------------------------------------------------------------
```
curl -v -H "Content-type: application/json" -X POST http://localhost:3000/api/v1/users -d '{"user":{"name":"nitin misra", "email":"nitin@example.com", "password":"12345", "password_confirmation":"12345"}}'
```

**Response**

```
> POST /api/v1/users HTTP/1.1
> User-Agent: curl/7.35.0
> Host: localhost:3000
> Accept: */*
> Authorization: Token token='abc'
> Content-type: application/json
> Content-Length: 125
>
* upload completely sent off: 125 out of 125 bytes
< HTTP/1.1 200 OK
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< Content-Type: application/json; charset=utf-8
< ETag: W/"b514d7dcc455dac518a721aee508e207"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: 78a627f3-47fc-4cae-a6da-969038e4440f
< X-Runtime: 0.106091
< Connection: close
* Server thin is not blacklisted
< Server: thin
<
{"user":{"name":"Nitin Misra","email":"nitin.misra@example.com","auth_token":"d81ec0f1_6214_4a96_81fb_1914169d8e7c"}}
```
---------------------------------------------------------------------------------------

2) **Session#create** (Generate API token)

---------------------------------------------------------------------------------------
```
curl -v -H "Content-type: application/json" -X POST http://localhost:3000/api/v1/sessions -d '{"email":"nitin.misra@example.com", "password":"12345"}'
```

**Response**
```
> POST /api/v1/sessions HTTP/1.1
> User-Agent: curl/7.35.0
> Host: localhost:3000
> Accept: */*
> Authorization: Token token='abc'
> Content-type: application/json
> Content-Length: 74
>
* upload completely sent off: 74 out of 74 bytes
< HTTP/1.1 200 OK
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< Content-Type: application/json; charset=utf-8
< ETag: W/"b3ad26e4a1b5c1d9c920f0438a454ee9"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: 739a4b71-dafc-496f-838b-ca135a9ef1f0
< X-Runtime: 0.104140
< Connection: close
* Server thin is not blacklisted
< Server: thin
<
* Closing connection 0
{"user":{"name":"Nitin Misra","email":"nitin.misra@example.com","auth_token":"d881b7d3_c806_4ce4_aa54_f37fa50feb91"}}
```
---------------------------------------------------------------------------------------

3) **Product#index** (Get all products)

---------------------------------------------------------------------------------------
```
curl -v -H "Authorization: Token token=d881b7d3_c806_4ce4_aa54_f37fa50feb91" -H "Content-type: application/json" -X GET http://localhost:3000/api/v1/products
```

**Response**
```
> GET /api/v1/products HTTP/1.1
> User-Agent: curl/7.35.0
> Host: localhost:3000
> Accept: */*
> Authorization: Token token=d881b7d3_c806_4ce4_aa54_f37fa50feb91
> Content-type: application/json
>
< HTTP/1.1 200 OK
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< Content-Type: application/json; charset=utf-8
< ETag: W/"d25c9d682e971aede809f01d94dd94fa"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: 898aa0e7-a6ba-49a2-9546-4b113f138ae6
< X-Runtime: 0.028268
< Connection: close
* Server thin is not blacklisted
< Server: thin
<
* Closing connection 0
{"products":[{"id":{"$oid":"54e1b5fc6e697439aa010000"},"name":"ghee rice","price":299.95,"availability":true},{"id":{"$oid":"54e1b6216e697439aa020000"},"name":"jeera rice","price":199.95,"availability":true},{"id":{"$oid":"54e1b62d6e697439aa030000"},"name":"biryani rice","price":99.95,"availability":true}]}
```
---------------------------------------------------------------------------------------

4) **Product#create** (Create a new product)

---------------------------------------------------------------------------------------
```
curl -v -H "Authorization: Token token=d881b7d3_c806_4ce4_aa54_f37fa50feb91" -H "Content-type: application/json" -X POST http://localhost:3000/api/v1/products -d '{"product":{"name":"bisibelle bath", "price":19.95, "availability":true}}'
```

**Response**
```
> POST /api/v1/products HTTP/1.1
> User-Agent: curl/7.35.0
> Host: localhost:3000
> Accept: */*
> Authorization: Token token=d881b7d3_c806_4ce4_aa54_f37fa50feb91
> Content-type: application/json
> Content-Length: 73
>
* upload completely sent off: 73 out of 73 bytes
< HTTP/1.1 200 OK
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< Content-Type: application/json; charset=utf-8
< ETag: W/"94840b2e5e9f7a49994639923c9be712"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: eac17d29-c949-47ee-b95d-16def3188852
< X-Runtime: 0.011206
< Connection: close
* Server thin is not blacklisted
< Server: thin
<
* Closing connection 0
{"product":{"id":{"$oid":"54eef9686e69746778010000"},"name":"bisibelle bath","price":19.95,"availability":true}}
```
---------------------------------------------------------------------------------------

5) **Product#show** (View a product)

---------------------------------------------------------------------------------------
```
curl -v -H "Authorization: Token token=d881b7d3_c806_4ce4_aa54_f37fa50feb91" -H "Content-type: application/json" -X GET http://localhost:3000/api/v1/products/54eef9686e69746778010000
```

**Response**
```
> GET /api/v1/products/54eef9686e69746778010000 HTTP/1.1
> User-Agent: curl/7.35.0
> Host: localhost:3000
> Accept: */*
> Authorization: Token token=d881b7d3_c806_4ce4_aa54_f37fa50feb91
> Content-type: application/json
>
< HTTP/1.1 200 OK
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< Content-Type: application/json; charset=utf-8
< ETag: W/"94840b2e5e9f7a49994639923c9be712"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: acbbe5c8-a29c-4937-a6e4-c65623233a0f
< X-Runtime: 0.007577
< Connection: close
* Server thin is not blacklisted
< Server: thin
<
* Closing connection 0
{"product":{"id":{"$oid":"54eef9686e69746778010000"},"name":"bisibelle bath","price":19.95,"availability":true}}
```
---------------------------------------------------------------------------------------
