# Dynamic API Base URL

## Client config (live)
- Endpoint: `https://raw.githubusercontent.com/hisham-bassam/app-config/refs/heads/main/config.json`
- Method: `GET`
- Response:
```json
{
  "base_url": "https://rta-parking-staging-38199597.dev.odoo.com"
}
```

## App behaviour
- On startup, app fetches this JSON.
- Host is normalized to `.../api/` automatically.
- Value is cached locally.
- Client updates the JSON when staging/production URL changes — no new app build.
