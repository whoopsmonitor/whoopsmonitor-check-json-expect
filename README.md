# whoopsmonitor-check-json-expect

Get remote JSON response and search for some specific results such as string, number.

## Environmental variables

-   `WM_API_ENDPOINT` API endpoint to call.
-   `WM_EXPECT` Comma separated list of items.

### WM_EXPECT

It is separated into four parts separated with a slash.

-   `key` The name of the key to search in response.
-   `rule`
    -   `string`
    -   `number`, `integer`
    -   `boolean`
-   `operator`
    -   string
        -   `eq`, `=` (exact match)
        -   `*=` (partial match)
    -   numbers
        -   `eq`, `=` (exact match)
        -   `gt`, `>` - greater than (numbers)
        -   `lt`, `<` - lower than (numbers)
-   `value` Compared value.

## Example

There is an example of the check at Whoops Monitor configuration tab or the `.env` file.

```yaml
WM_API_ENDPOINT=https://localhost:1337
WM_EXPECT=data.db/boolean/=/true
```

```yaml
WM_API_ENDPOINT=https://localhost:1337
WM_EXPECT=data.db/number/gt/100
```

## Output

-   `0` - Data founded in the format as expected.
-   `2` - Data does not have a proper format.

## Build

```sh
docker build -t whoopsmonitor-check-json-expect .
```

## Run

```bash
docker run --rm --env-file .env whoopsmonitor-check-json-expect
```
