# ios_push_notification_send_sh

## getting device token Swift

```
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
    print("device_token = \(deviceTokenString)")
}
```

## in iOS Dev center

after getting Key, .p8 file,  Team ID,  edit push.sh


## done

```
$ sh push.sh
```


## Other confirmation methods

- development 

```
curl -v -d '{"aps":{"alert":"hello"}}' -H "apns-topic: [Bundle ID]" --http2 --cert [pem file] https://api.sandbox.push.apple.com/3/device/[device token]
```

- production
```
curl -v -d '{"aps":{"alert":"hello"}}' -H "apns-topic: [Bundle ID]" --http2 --cert [pem file] https://api.push.apple.com/3/device/[device token]
```


