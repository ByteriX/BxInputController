# BxInputController

This framework will help iOS developers for simplify development general inputing controllers

## Features

- [x] Encapsulation UITableView DataSource/Delegate 
- [x] Automatical to register cells/headers/footer for tableView
- [x] Library general types for inputting: string, date, value objects, pictures, rating, boolean
- [x] Easy to use current solution and make a custom
- [x] SOLID decision

## Requirements

- iOS 8.0+
- Swift 3.0+


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate BxInputController into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
pod 'BxInputController', '~> 0.9'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

### Showing simple input

```swift
class InputController: BxInputController {

    private var email = BxInputTextRow(title: "email value", value: "")
    private var birthdayDate = BxInputDateRow(title: "birthday", placeholder: "YOUR BIRTHDAY")
    private var selectedVariants = BxInputSelectorVariantsRow<BxInputVariantsItem>(title: "selected", placeholder: "SELECT")

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedVariants.items = [
            BxInputVariantsItem(id: "1", name: "value1"),
            BxInputVariantsItem(id: "2", name: "value2"),
            BxInputVariantsItem(id: "3", name: "value3"),
            BxInputVariantsItem(id: "4", name: "value4"),
        ]

        self.sections = [
            BxInputSection(rows: [email, birthdayDate, selectedVariants])
        ]
    }

    func showInputedValues() {
        print(email.value)
        print(birthdayDate.value)
        print(selectedVariants.selectedVariant.name)
    }
}

```

## License

BxInputController is released under the MIT license. See LICENSE for details.
