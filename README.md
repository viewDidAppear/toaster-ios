# Toaster ![alt text](https://github.com/cocotutch/toaster-ios/raw/master/src/common/images/toast_bro.png "Sir Toaster of Kitchenshire")
Open-Source Toast Notification class and protocol for iOS, written in Swift.

## What is Toaster?
Toaster is a Swift module for popping in-app toast notifications to users, without polluting Notification Center with errant nonsense.

## How do I use Toaster?
Declare a `let toaster = Toaster.store()` somewhere, such as in a Constants file or your AppDelegate, and give it a few ~slices of bread~ instantiated Toasts to store.
Toast objects can have severity, message, icon and gravity properties set, as follows:
```swift
let genericToast = Toast(withGravity: .Top, severity: .Info, 
