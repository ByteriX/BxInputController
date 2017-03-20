# Copyright

Library BxInputController

ByteriX, 2017. All right reserved.

# Versions

## 2.0.0 (20.03.2017)
##### Improvements
* new paradigm supported MVVM
* added RowBinder entity between Row and Cell, SectionContent and HeaderView/FooterView
* rename all Selector classes
* refactored all row.parent to parentRow
* remove base View classes: BxInputBaseCell, BxInputBaseHeaderFooterView
* fixed bug with header and footer confusion


## 1.1.2 (17.03.2017)
##### Bug fixing
* fix bug with header and footer in BxInputSection

## 1.1.1 (14.03.2017)
##### Bug fixing
* phone field has had number Pad type

## 1.1.0 (14.03.2017)
##### Features
* added BxInputFormattedTextRow with url & phone formatting
* clear warnings

## 1.0.8 (02.03.2017)
##### Improvements
* update description

## 1.0.7 (01.03.2017)
##### Improvements
* Paradigm update

## 1.0.6 (27.02.2017)
##### Improvements
* finished description of paradigm in the readme

## 1.0.5 (25.02.2017)
##### Improvements
* to started description of paradigm in the readme

## 1.0.4 (19.02.2017)
##### Improvements
* update description of udating/transformation rows/sections in the readme

## 1.0.3 (16.02.2017)
##### Improvements
* update description of settings in the readme
* fix showing enabled/disabled for all selector rows
* add to example enabled/disabled texting

## 1.0.2 (16.02.2017)
##### Improvements
* update descriptions

## 1.0.1 (15.02.2017)
##### Improvements
* update readme

## 1.0.0 (15.02.2017)
##### Bug fixing
* fix bug with accessories for rate row (dissmiss keyboard)
* added Switch row with boolean value
* added Check row with boolean value

## 0.9.38 (15.02.2017)
##### Improvements
* documentation for action, date, pictures, rate, suggestions, variants, text row.
* move & rename all picture items
* extract item classes from suggestion & variants rows
* rename folder items to rows

## 0.9.37 (15.02.2017)
##### Improvements
* add documentation for section
* rename all section's classes
* rename base cell

## 0.9.36 (15.02.2017)
##### Bug fixing
* add documentation for BxInputController extension
* fix signature of deselectRow

## 0.9.35 (14.02.2017)
##### Bug fixing
* fix resource using

## 0.9.34 (14.02.2017)
##### Refactoring
* extract BxInputUtils singleton for working with resources
* add documentation for settings & BxInputController

## 0.9.33 (14.02.2017)
##### Refactoring
* move to the new directories

## 0.9.32 (13.02.2017)
##### Implementing
* start testing documentation for example BxInputRow protocol

## 0.9.31 (09.02.2017)
##### Improvements
* made loading of the photo library faster
* add working with camera

## 0.9.30 (08.02.2017)
##### Improvements
* use library + stream photos for BxInputSelectorPicturesRow

## 0.9.29 (07.02.2017)
##### Improvements
* added iconMode to BxInputSelectorPicturesRow for the selection an icon showing
* added isUniqueue to BxInputSelectorPicturesRow for single choosing a picture
* animated adding of a pictures
* improvement adding animation
* fix bug with identical photo in the library

## 0.9.28 (06.02.2017)
##### Bug fixing
* fix rate update value

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
