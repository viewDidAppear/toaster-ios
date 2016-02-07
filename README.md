![alt text](https://github.com/cocotutch/toaster-ios/blob/master/toast_bro.png "Sir Toaster of Kitchenshire") 
# Toaster 
Open-Source Toast Notification class and protocol for iOS, written in Swift.

## What is Toaster?
Toaster is a Swift module for popping in-app toast notifications to users, without polluting Notification Center with errant nonsense.

## How do I use Toaster?
Give X amount of Toast objects to ~~Sir Toaster of Kitchenshire~~ the Toaster in some area of your app, making sure they have an `toastCode`. Then, simply call `Toaster.sharedInstance.pop(withErrorCode: XXXXXX)` when you wish to show one! Alternatively, just call the `pop()` method which allows you to create one on the fly, without needing a pre-existing reference.

Toast objects can have severity, message, icon and gravity properties set, as follows:
```swift
let thirdPartyHomeButtonError = Toast(withDuration: ToastDuration.Short,
            gravity: ToastGravity.Top,
            severity: ToastSeverity.Error,
            style: ToastStyle.Brief,
            message: "Your home button is not an official Apple component. We've bricked your phone!",
            code: 53,
            animated: true
        )
```

## Disambiguation

- Duration:
	You can set custom duration lengths for the Toasts. `.Short` is equal to 2 seconds, `.Normal` is 5 seconds, and `.Long` is 10.
- Gravity:
	Toasts can be pinned to the `.Top` or the `.Bottom` of the screen.

- Severity:
	When you set the severity to `.Warning` or `.Error` the Toast will be ~~burnt~~ coloured Orange or Red.
	When it's `.Info`, the Toast will be White.

- Style:
	At the moment, I only support `.Brief` which is the device's screen height, divided by 12. Add more of these to make the Toasts ~~bigger slices of bread~~ longer, and even use this to ask for user input before dismissal! (set a really high value for the timer expiry if you do this, such as 86400 seconds)
- Code:
	Referencable error code.
- Message:
	A variable length message. ~~I still can't figure out how I got such a long message to appear on a piece of Toast and still have it be legible.~~ Be descriptive!
- Animated:
	Let's face it, this will _always_ be true. But just in case, I added the ability to disable animations while you show and hide the Toasts.

## TL;DR:

![alt text](https://github.com/cocotutch/toaster-ios/blob/master/toast_piece.png "His Loyal Subject") ![alt text](https://github.com/cocotutch/toaster-ios/blob/master/toast_piece.png "His Loyal Subject") ![alt text](https://github.com/cocotutch/toaster-ios/blob/master/toast_piece.png "His Loyal Subject")

Get given to...

![alt text](https://github.com/cocotutch/toaster-ios/blob/master/toast_bro.png "Sir Toaster of Kitchenshire")

Who then brings oh such happy days!

## Lastly..

This code is being released under the MIT licence, which means you can use it and modify it without payment to me. But I would still appreciate it if you credited me in your App, or tweeted me @cocotutch to say Thanks, and to show me how you used Sir Toaster of Kitchenshire and His Loyal Subject(s) to make your App awesome!

I also welcome any pull requests you may have, which will improve this little module.

Thanks, and enjoy! 

