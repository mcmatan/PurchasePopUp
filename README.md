

[![Language](https://img.shields.io/badge/language-swift-orange.svg?style=flat)](https://developer.apple.com/swift)

<p align = "center"><img src="https://media.giphy.com/media/8PvFv3lrOh1vEDh6zr/giphy.gif" alt="ImageOpenTransition Icon"/></p>


## Description


* **Fully customizable pop up**

* **Easy to use**

## Usage: EasyList

```Swift
//As Static
PurchasePopUpPresentor.show(contentView: someView,
                            title: "Your amazing title",
                            cancelHandler: {
//User pressed cancel button
})

//As Instance veriable
self.purchasePopUpPresentor = PurchasePopUpPresentor(contentView: contentView, title: title)
        self.purchasePopUpPresentor?.show(cancelHandler: {
            //User pressed cancel button
        })
        
 //Dismiss
self.purchasePopUpPresentor?.dismissViews()
})
        
```


## Installation

#### Cocoapods
**ImageScaleTransition** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PurchasePopUp'
```

#### Manually
1. Download and drop ```/PurchasePopUp``` folder in your project.  
2. Congratulations!  

## Author

[Matan](https://github.com/mcmatan) made this with ❤️.
