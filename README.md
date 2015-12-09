# Fake Twitter
creates a docker image that will fake the twitter endpoint https://api.twitter.com/1.1/direct_messages/new.json


# Running
 -------
`$ docker run -it -p "9494:9494" sdb1228/fake-twitter`
Note that `VIRTUAL_HOST` environment variables can be added if run with dinghy client
`$ docker run -it -p "9494:9494" -e "VIRTUAL_HOST=twitter.docker" sdb1228/fake-twitter`

Or from docker-compose.yml:
```
twitter:
  image: sdb1228/fake-twitter
  ports:
    - "9494:9494"
  environment:
    VIRTUAL_HOST: "twitter.docker"
```

Getting started
---------------
The following curl command (taken from the twitter API page) can be run to verify that it is working (assumes host is 'twitter.docker'):

`$ curl --request 'POST' 'http://twitter.docker:9494/1.1/direct_messages/new.json' --data 'screen_name=theseancook&text=hello%2C+tworld.+welcome+to+1.1.' --header 'Authorization: OAuth oauth_consumer_key="KEY", oauth_nonce="OAUTH", oauth_signature="SIGNATURE", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1449679310", oauth_version="1.0"' --verbose"`
