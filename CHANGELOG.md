# Copyright

Library BxInputController

ByteriX, 2017. All right reserved.

# Versions

## 0.9.27 (06.02.2017)
##### Improvements
* add picture selector BxInputSelectorPicturesRow
* fix font for BxInputSelectorTextRow
* fix getting back & next row for selector
* add maxSelectedCount param for 
* showing count of pictures
* refactoring
* bug fixing for update placeholder & value of selector cell

## 0.9.26 (03.02.2017)
##### Bug fixing
* sharing resources for Rate

## 0.9.25 (02.02.2017)
##### Bug fixing
* fix accessing for new classes

## 0.9.24 (02.02.2017)
##### Improvements
* change arrow icon for the selector types
* added BxInputRateRow for puting a rating
* added BxInputSelectorTextRow for puting a bigest text
* fix visual showing of BxInputSelectorCell for supporting BxInputSelectorTextRow
* add separatorInset to BxInputSettings

## 0.9.23 (30.01.2017)
##### Bug fixing
* firstable selection of date or variants rows call didChange before showing child row

## 0.9.22 (24.01.2017)
##### Refactoring
* remove tableDelegate with all subclasses

## 0.9.21 (24.01.2017)
##### Bug fixing
* public protocol BxInputStaticHeight
* extract TableDelegate
* fix bug with estimated sizes

## 0.9.20 (23.01.2017)
##### Improvements
* added isEstimatedContent = false for supporting static sizes
* added setEnabled method to BxInputController for enable/desable rows
* added commonInputAccessoryView, and managment of showing this panel above keyboard

## 0.9.19 (20.01.2017)
##### Bug fixing
* refactoring: extract protocol BxInputString for all
* abstraction variant type for component

## 0.9.18 (19.01.2017)
##### Bug fixing
* fixing with scroll insets for 9/10 iOS in different "input tables" screens
* extract estimatedHeight in bases entities
* remove setting scroll to default position when appeared
* creating generic for BxInputSelectorSuggestionsRow

## 0.9.17 (19.01.2017)
##### Improvements
* fixing bug with first date selection
* @discardableResult for resignFirstResponder()

## 0.9.16.1 (18.01.2017)
##### Improvements
* fix deleteSection, reloadSection, updateSection

## 0.9.16 (18.01.2017)
##### Improvements
* added parent to BxInputSectionContent protocol
* added deleteSection
* added reloadSection
* added updateSection

## 0.9.15 (17.01.2017)
##### Improvements
* refactoring code
* change abstraction of BxInputSelectorSuggestionCell

## 0.9.14 (17.01.2017)
##### Bug fixing
* add dependency with BxObjC/Vcl and fix scroll content

## 0.9.13 (17.01.2017)
##### Features
* add selectRow method to BxInputController

## 0.9.12 (17.01.2017)
##### Improvements
* accessing for keyboardWillChange method in BxInputController

## 0.9.11 (17.01.2017)
##### Improvements
* adding BxInputSectionView for headers & footers

## 0.9.10 (16.01.2017)
##### Improvements
* abstraction BxInputActionRow for generic supporting

## 0.9.9 (16.01.2017)
##### Bug fixing
* definition a placeholder color from the settings
* fix autodissmiss from action
* change logic of isImmediatelyDeselect for action type
* fix table header height
* fix header & footer heght for empty section

## 0.9.8 (16.01.2017)
##### Bug fixing
* fix appear keyboard from all selectors
* fix highlighting cells for disabled mode
* correct updating for a setting up enable mode
* inserting sections

## 0.9.7 (16.01.2017)
##### Improvements
* support isEnabled with logic & visual effects

## 0.9.6.1 (15.01.2017)
##### Bug fixing
* supporting itself bundle resources

## 0.9.6 (15.01.2017)
##### Bug fixing
* supporting itself bundle resources

## 0.9.5 (15.01.2017)
##### Improvements
* add didChangedRow method to BxInputController
* fix bug with dissmiss keyboard

## 0.9.4 (15.01.2017)
##### Bug fixing
* change accessing for BxInputSettings

## 0.9.3 (15.01.2017)
##### Bug fixing
* change accessing for BxInputController

## 0.9.2 (15.01.2017)
##### Bug fixing
* change accessing for all classes & protocols

## 0.9.1 (14.01.2017)
##### Start project
* fix Pod::Spec file

## 0.9.0 (14.01.2017)
##### Start project
* maked changelog
* betta version for cocoapods


# Installation

pod 'BxInputController'
