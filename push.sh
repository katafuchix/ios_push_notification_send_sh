#!/bin/bash
deviceToken=xxxxxx
authKey="path to .p8 file"
authKeyId=[Key ID]
teamId=[Team ID]

# distribution
# bundleId=jp.co.archive-asia.demo
# endpoint=https://api.push.apple.com

# development
bundleId=[Bundle ID]
endpoint=https://api.sandbox.push.apple.com

read -r -d '' payload <<-'EOF'
{
  "aps": {
     "badge": 1,
     "alert": {
        "title": "タイトル",
        "subtitle": "サブタイトル",
        "body": "本文"
     }
  }
}
EOF

base64() {
   openssl base64 -e -A | tr -- '+/' '-_' | tr -d =
}
sign() {
   printf "$1"| openssl dgst -binary -sha256 -sign "$authKey" | base64
}
time=$(date +%s)
header=$(printf '{ "alg": "ES256", "kid": "%s" }' "$authKeyId" | base64)
claims=$(printf '{ "iss": "%s", "iat": %d }' "$teamId" "$time" | base64)
jwt="$header.$claims.$(sign $header.$claims)"
curl --verbose \
   --header "content-type: application/json" \
   --header "authorization: bearer $jwt" \
   --header "apns-topic: $bundleId" \
   --data "$payload" \
   $endpoint/3/device/$deviceToken
