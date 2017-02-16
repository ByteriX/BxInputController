# BxInputController

This framework will help iOS developers for simplify development general inputing controllers. Holds a ready-made solutions, such as standard solutions in Apple applications also have custom design such as a photo library, a choice of variants or suggestion. If you need custom inputting view (for example calendar for date putting) then you may add new rows or edit or inherited current rows. The component is limited only to the implementation of the paradigm, it essentially involves the use of SOLID approach. An important limitation is the compulsory use of Interface Builder to implement UI (xib or storyboard, but not from code).

## Gif demo

![Demo Gif](Screenshots/simple_demo.gif)

## Features

- [x] Encapsulation UITableView DataSource/Delegate/Scrolling and other
- [x] Automatical to register resources (xib, pdf, etc) for cells/headers/footer
- [x] Library general types for inputting: string, date, value objects (variants), pictures, rating, boolean
- [x] Two style inputting: from keyboard or from selector
- [x] Easy to use current solution and make a custom
- [x] SOLID decision: easy binding View with data models


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


### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but BxInputController does support its use on supported platforms. 

Once you have your Swift package set up, adding BxInputController as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .Package(url: "https://github.com/ByteriX/BxInputController.git", majorVersion: 1)
]
```

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate 'BxInputController' into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

```bash
$ git init
```

- Add 'BxInputController' as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

```bash
$ git submodule add https://github.com/ByteriX/BxInputController.git
```

- Add all sources and resources from local copy of 'BxInputController' to the build phase of the project.

- And that's it!


## Usage

### Example for `Gif Demo`

```swift

class SimpleAllRowsController: BxInputController {
    
    // Action
    private let stringActionRow = BxInputActionStringRow(title: "string action")
    private let customActionRow = BxInputActionCustomRow<BxInputActionStringRow>(title: "custom action")
    // Boolean
    private let switchRow = BxInputSwitchRow(title: "boolean switch", value: true)
    private let checkRow = BxInputCheckRow(title: "boolean check", placeholder: "selected value")
    // Date
    private let dateRow = BxInputDateRow(title: "date", value: Date().addingTimeInterval(900000))
    private let selectorDateRow = BxInputSelectorDateRow(title: "selector date")
    // Pictures
    private let selectorPicturesRow = BxInputSelectorPicturesRow(title: "selector pictures")
    // Rate
    private let rateRow = BxInputRateRow(title: "rate", maxValue: 10)
    // Suggestions
    private let selectorSuggestionsRow = BxInputSelectorSuggestionsRow<BxInputSelectorSuggestionsItemRow>(title: "selector suggestions")
    // Text
    private let shortTextRow = BxInputTextRow(title: "text value", placeholder: "short text")
    private let selectorTextRow = BxInputSelectorTextRow(title: "text with selector", placeholder: "longest text")
    // Variants
    private let variantsRow = BxInputVariantsRow<BxInputVariantsItem>(title: "variants")
    private let selectorVariantsRow = BxInputSelectorVariantsRow<BxInputVariantsItem>(title: "selector variants")

    private let variantsItems : [BxInputVariantsItem] = [
        BxInputVariantsItem(id: "1", name: "value1"),
        BxInputVariantsItem(id: "2", name: "value2"),
        BxInputVariantsItem(id: "3", name: "value3"),
        BxInputVariantsItem(id: "4", name: "value4"),
        ]
    private let suggestionItems = [
        BxInputSelectorSuggestionsItemRow(title: "value 1"),
        BxInputSelectorSuggestionsItemRow(title: "value 2"),
        BxInputSelectorSuggestionsItemRow(title: "value 3"),
        BxInputSelectorSuggestionsItemRow(title: "value 4"),
        BxInputSelectorSuggestionsItemRow(title: "value 5")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isEstimatedContent = false
        stringActionRow.handler = {[weak self] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            this.stringActionRow.value = "changed"
            this.updateRow(this.stringActionRow)
        }
        stringActionRow.isImmediatelyDeselect = true
        customActionRow.handler = {[weak self] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            this.customActionRow.value = this.stringActionRow
            this.updateRow(this.customActionRow)
        }
        customActionRow.isImmediatelyDeselect = true
        selectorSuggestionsRow.children = suggestionItems
        variantsRow.items = variantsItems
        selectorVariantsRow.items = variantsItems

        self.sections = [
            BxInputSection(headerText: "Action", rows: [stringActionRow, customActionRow]),
            BxInputSection(headerText: "Boolean", rows: [switchRow, checkRow]),
            BxInputSection(headerText: "Date", rows: [dateRow, selectorDateRow]),
            BxInputSection(headerText: "Pictures", rows: [selectorPicturesRow]),
            BxInputSection(headerText: "Rate", rows: [rateRow]),
            BxInputSection(headerText: "Suggestions", rows: [selectorSuggestionsRow]),
            BxInputSection(headerText: "Text", rows: [shortTextRow, selectorTextRow]),
            BxInputSection(headerText: "Variants", rows: [variantsRow, selectorVariantsRow])
        ]
    }
    
}

```


### Get values from inputed

```swift
class InputController: BxInputController {

    private var email = BxInputTextRow(title: "email value", value: "")
    private var birthdayDate = BxInputDateRow(title: "birthday", placeholder: "YOUR BIRTHDAY")
    private var selectedVariants = BxInputSelectorVariantsRow<BxInputVariantsItem>(title: "selected", 
        placeholder: "SELECT")

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedVariants.items = [
            BxInputVariantsItem(id: "1", name: "value1"),
            BxInputVariantsItem(id: "2", name: "value2"),
            BxInputVariantsItem(id: "3", name: "value3")
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
