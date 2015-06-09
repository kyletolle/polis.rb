# Polis.rb

Simple Ruby (Sinatra) HTTP listener that logs POST contents to STDERR.

## Install

After cloning, install the gems.

```
bundle install --path=.bundle
```

## Running

```
bundle exec foreman start
```

## Interacting

### GET

Visit `http://localhost:9000` in a browser to see that it's running.

### POST

POST to the URL to see the POST data logged to the command line.

```
curl -X POST -H "Content-Type: application/json" -d '{"hello":"world"}' http://localhost:9000
```

In the console you started the server, you'll see some output:

```
19:57:41 web.1  | I, [2015-06-03T19:57:41.140521 #11892]  INFO -- : Logging POST request:
19:57:41 web.1  | Headers:
19:57:41 web.1  | {"HTTP_USER_AGENT"=>"curl/7.37.1", "HTTP_HOST"=>"localhost:9000", "HTTP_ACCEPT"=>"*/*", "HTTP_VERSION"=>"HTTP/1.1", "HTTP_ORIGIN"=>nil}
19:57:41 web.1  | Body:
19:57:41 web.1  | {"hello":"world"}
```

## Overriding Defaults

To override the default behavior, set the following environment variables

- `PORT`
  - What port this application listens on.
  - Defaults to `9000`.
- `STATUS_CODE`
  - The HTTP status code this application will return on POST requests.
  - Defaults to `200`.
  - Useful to test how the calling application responds to non-successful
    error codes.
- `SECONDS_TO_SLEEP`
  - How many seconds to sleep before responding to the POST requests.
  - Defaults to `0`.
  - Useful to test how the calling application handles requests that time out.

```
PORT=9090 STATUS_CODE=500 SECONDS_TO_SLEEP=2.5 bundle exec foreman start
```

Note: Set the environment variables yourself, like above, or use [dotenv's](https://github.com/bkeepers/dotenv) `.env` file to store them.

## License

MIT

