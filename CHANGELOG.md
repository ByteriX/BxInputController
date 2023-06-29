# Copyright

Library BxInputController

ByteriX, 2017. All right reserved.

# Versions

## 2.21.9 (29.06.2023)
##### Improvements
* revert adding BxInputSelectorPicturesRow for SPM
##### Bug fix
* fixed all xib for supporting SPM

## 2.21.8 (28.06.2023)
##### Improvements
* fixed resources for SPM

## 2.21.6 (27.06.2023)
##### Improvements
* try to fix build for SPM

## 2.21.5 (21.06.2023)
##### Improvements
* add function removeAllCheckers

## 2.21.4 (14.06.2023)
##### Improvements
* fixed SPM with master branch

## 2.21.3 (13.06.2023)
##### Improvements
* try to fix SPM

## 2.21.2 (12.06.2023)
##### Improvements
* Supporting SPM

## 2.21.1 (10.06.2023)
##### Bug fix
* fixed build

## 2.21 (09.06.2023)
##### Improvements
* renamed isFirstShownSelect to isFirstShownAutoselect from the BxInputSelectorVariantRow
* added isOnlyOneAutoselect to the BxInputSelectorVariantRow

## 2.20 (08.06.2023)
##### Bug fix
* Reverted isFirstShownSelect selection to false from the BxInputSearchVariantRow
* Updated target to iOS 11

## 2.19.1 (29.10.2021)
##### Bug fix
* Fixed the issue with updating incorrected viewCell from a Binder
* Added function getRowBinder with selected cell

## 2.19.0 (20.01.2021)
##### Bug fix
* Fixed date picker from BxInputSelectorDateRow for iOS 14

## 2.18.4 (27.04.2020)
##### Bug fix
* The PodSpec support all versions of Swift

## 2.18.3 (11.12.2019)
##### Improvements
* extracted common logic to BxInputTextMemoProtocol

## 2.18.2 (10.12.2019)
##### Bug fix
* fixed issue with bring cursore from TextMemo
* fixed TextMemo scrolling for iPhone X/Xs/11 when using iOS 11 and later

## 2.18.1 (09.12.2019)
##### Improvements
* added width param to BxInputSegmentedVariantRow
* impovement of design of BxInputSegmentedVariantCell when title is empty

## 2.18.0 (06.12.2019)
##### Improvements
* added BxInputSegmentedVariantRow: new row with segmented
* added example for BxInputSegmentedVariantRow
* made context menu for BxInputSegmentedVariantRow
* renamed all class and exaples code with 'Variants' to 'Variant' : BxInputVariant, BxInputVariantItem, BxInputVariantRow, BxInputSearchVariantRow, BxInputSelectorVariantRow, BxInputSegmentedVariantRow
* changed gender from Example to Segmented
* fixed warning from a header and foother layouts and background color

## 2.17.2 (30.10.2019)
##### Improvements
* added two new methods: getSectionIndex(for: currentRow) and getSection(for: currentRow)
* fixed method updateSection(). That don't update contented rows

## 2.17.1 (29.10.2019)
##### Improvements
* public mode colors in Settings

## 2.17.0 (28.10.2019)
##### Improvements
* fixed background of rate
* supporting iOS 13 and dark mode


## 2.16.6 (24.10.2019)
##### Bug fix
* fixed call didChangeValue() from BxInputCheckRow

## 2.16.5 (27.06.2019)
##### Improvements
* change handler from BxInputActionRow as editable

## 2.16.4 (11.06.2019)
##### Improvements
* updated build script

## 2.16.3 (10.06.2019)
##### Improvements
* opened BxInputBaseRowChecker.isOK()
* pods update Swift version

## 2.16.2 (03.05.2019)
##### Bug fix
* fixed bottom layout for keyboard of iPhone X and iOS 11 and later
* added TabBar to example for testing bottom layout

## 2.16.1 (16.04.2019)
##### Improvements
* extracted method getForegenView from BxInputStandartErrorRowDecorator
* published textView from BxInputTextMemoCell
* fixed BxInputStandartErrorRowDecorator for shake view

## 2.16.0 (29.03.2019)
##### Bug fix
* Swift 5, iOS 12.2, XCode 10.2 supporting
* fixed warnings

## 2.15.3 (19.03.2019)
##### Bug fix
* fixed issue with multiline subtitle. Thanks to Vlad Markov.

## 2.15.2 (25.02.2019)
##### Improvements
* added isErrorHasShake & isErrorSubtitleAlignment to Settings for the error decorators
* fixed deprecated from BxInputStandartErrorRowDecorator
* refactory all TODO to warnings

## 2.15.1 (10.01.2019)
##### Bug fix
* fixed issue with field of a selector (localization Search)
* fixed issue with dissmissing selectors

## 2.15 (10.01.2019)
##### Improvements
* new row BxInputSearchVariantRow for searching variant
* added isFirstShownSelect to variant selector
* updated example

## 2.14.1 (24.11.2018)
##### Bug fix
* fixed crash with selector

## 2.14 (22.11.2018)
##### Improvements
* added to RowSelectors functions: toOpen(), toClose()
* new protocols BxInputRowBinderMenu for organization action menu: copy/past/cut/delete
* added all menu action for Date rows
* added delete menu action for Variants and Actions rows

## 2.13.4 (21.11.2018)
##### Improvements
* fixed reloadRow with animation
* added beginUpdates(), endUpdates() for safy table animation

## 2.13.3 (09.11.2018)
##### Improvements
* default date property for rows of the same type

## 2.13.2 (06.11.2018)
##### Improvements
* Checker: update decarator only when isActivated chenged
* Refactoring: BxInputController extension for checker
* Refactoring BxInputBaseRowBinder: extract deacivate(for checker) acivate(for checker), added deacivateCheckers()
* Added new methods to BxInputController: deactivateRowCheckers, deactivateSectionCheckers, deactivateAllRowsCheckers
* Change logic of BxInputController.checkAllRows(willSelect:) as is was with reactivated decoration of checker


## 2.13.1 (05.10.2018)
##### Bug fix
* Supporting Swift 4.1 fixed

## 2.13 (04.10.2018)
##### Improvements
* Supporting Swift 4.2 and iOS 12
* Refactoring older version supporting, but left it

## 2.12.2 (25.08.2018)
##### Bug fix
* fixed issues with calculation memo height

## 2.12.1 (13.08.2018)
##### Improvments
* added maxCount to BxInputFormattedTextRow
* added new constructor to BxInputFormattedTextRow for filtered symboles

## 2.12.0 (03.08.2018)
##### Bug fix
* fixed issues from checking of a selector row
* made full size of memo immediate when showed
* changed logic of SelectorText as Memo
* renamed didChangedValue to didChangeValue
* removed param from didChangeValue(for row: BxInputValueRow)

## 2.11.0 (11.07.2018)
##### Improvments
* added maxCount to BxInputTextRow and inherited for limitation of string putting
* used BxInputTextSourceProtocol for abstarct solution with UITextField and UITextView
* changed Simple example to show maxCount using

## 2.10.1 (10.07.2018)
##### Improvments
* fixed SDK issue with false value of "adjust to fit"

## 2.10.0 (26.06.2018)
##### Improvments
* added new row: BxInputIconActionRow. It's the same BxInputActionCustomRow but is easy and has icon,titleColor and more each other

## 2.9.4 (17.06.2018)
##### Improvments
* default checker init call with standart decorator. If you don't want decarate, please use decorator: nil

## 2.9.3 (16.06.2018)
##### Bug fix
* fixed crash when Variant's rows have empty list

## 2.9.2 (13.06.2018)
##### Bug fix
* true updateInsets() with who is who

## 2.9.1 (13.06.2018)
##### Bug fix
* true contentOffset from updating insets of the table

## 2.9.0 (17.05.2018)
##### Improvments
* added init to BxInputSection with view content of header/footer
* changed BxInputSectionView init as is as BxInputSectionStringHeader/BxInputSectionStringFooter
* rewritten Readme with new changes


## 2.8.2 (15.05.2018)
##### Improvments
* added tableFrame, tableInsets for change tableView showing
* pick down updateInsets from open to publuc method. You shouldn't override this yet

## 2.8.1 (15.05.2018)
##### Bug fix
* Fixed calculation keyboardRect

## 2.8.0 (15.05.2018)
##### Improvments
* New property keyboardRect
* Fixed contentRect for layout changing (without keyboard showing)
* Fixed Header and Footer xibs: using contentView

## 2.7.11 (10.05.2018)
##### Improvments
* New property in BxInputFormattedTextRow: enteredValue without patterns and format

## 2.7.10 (03.05.2018)
##### Improvments
* remove weak from protocols

## 2.7.9 (02.04.2018)
##### Bug fix
* fixed updating value of MemoTextRow (didn't call didChangedValue event)

## 2.7.8 (14.03.2018)
##### Bug fix
* made BxInputActionRow as activeRow when selected

## 2.7.7 (10.01.2018)
##### Improvments
* fixed all warnings

## 2.7.6 (21.12.2017)
##### Improvments
* updated build script

## 2.7.5 (20.12.2017)
##### Improvments
* tried to update README and CHANGELOG from cocoapods 1.4.0

## 2.7.4 (20.12.2017)
##### Improvments
* seporated Photo library module to submodule "BxInputController/Photo". General will be "BxInputController/Common"
* fixed README gif url

## 2.7.3 (15.12.2017)
##### Improvments
* added Swift version

## 2.7.2 (08.12.2017)
##### Improvments
* changed only description

## 2.7.1 (13.11.2017)
##### Bug fix
* supporting Swift 4.0 with 3.2

## 2.7.0 (09.11.2017)
##### Bug fix
* fixed intererface of FormatedText row

## 2.6.1 (14.09.2017)
##### Improvments
* return open func valueChanged(valueTextField: UITextField)

## 2.6.0 (14.09.2017)
##### Improvments
* removed delegate from BxInputStandartTextCell for easaly supporting View Cells
* made changeTarget for replease target from UIControl
* removed unnecessary entities

## 2.5.5 (13.09.2017)
##### Improvments
* abstract BxInputStandartTextCell as BxInputStandartTextCellProtocol

## 2.5.4 (11.09.2017)
##### Improvments
* revomed extra frameworks from dependency

## 2.5.3 (02.09.2017)
##### Bug fix
* fixed hasEmptyValue for formatted text row

## 2.5.2 (01.09.2017)
##### Bug fix
* rewrote features for activation checker

## 2.5.1 (31.08.2017)
##### Bug fix
* introduced double check pattern into decarator activation

## 2.5.0 (10.08.2017)
##### Bug fix
* introduced BxInputTextSettings for change text input style global/local
* fixed bug with changing isSecureTextEntry on standart cell as result: rewriting first symbole from password field after checking on empty value

## 2.4.6 (07.08.2017)
##### Bug fix
* made BxInputSectionView as BxInputStaticHeight

## 2.4.5 (02.08.2017)
##### Improvements
* changed the accesse of BxInputTextMemoCell
* changed BxInputStandartErrorRowDecorator for supporting BxInputTextMemoRow

## 2.4.4 (01.08.2017)
##### Improvements
* small internal changes BxInputSelectorTextRow
* added BxInputTextMemoRow for bigest text without selector
* added BxInputTextMemoRow to example

## 2.4.3 (31.07.2017)
##### Improvements
* fixed BxInputEmptyValueChecker for BxInputFormattedTextRow
* added BxInputBlockChecker for universal checking
* added errorColor to BxInputController for global using BxInputStandartErrorRowDecorator

## 2.4.2 (26.07.2017)
##### Bug fix
* change select/deselect row logic with bug fixes 
* checking select/deselect row

## 2.4.1 (21.07.2017)
##### Bug fix
* published isNormalShowingDisabledCell, changeViewEnableHandler, alphaForDisabledView
* fixed mistake in the word isNormalShowingDisabledCell

## 2.4.0 (20.07.2017)
##### Features
* new methods setEnableSection, setEnable for batching process of dissable/enable rows
* add to setEnableRow param for animating
* new methods reloadSections for reload array of sections
* new params in Settings for managment dissable/enable rows: isNormalShowingDisabledCell, changeViewEnableHandler, alphaForDisabledView
* edit example project for showing the changes regarging dissable/enable rows

## 2.3.11 (22.06.2017)
##### Improvements
* fixed placeholder color from formatted text

## 2.3.10 (05.06.2017)
##### Improvements
* added public init to Section class

## 2.3.9 (05.06.2017)
##### Improvements
* added public init for Settings struct

## 2.3.8 (31.05.2017)
##### Improvements
* change keyboard show/hide logic. Tranport this to UIViewController extension

## 2.3.7.1 (30.05.2017)
##### Bug fix
* change BxInputSettings.standart

## 2.3.7 (30.05.2017)
##### Improvements
* added rows property for section
* changed settings to structure for correctly copying

## 2.3.6 (29.05.2017)
##### Bug fix
* changed build script

## 2.3.5 (05.05.2017)
##### Improvements
* added BxInputEqualValuesChecker
* update example & README

## 2.3.4 (05.05.2017)
##### Bug fix
* fixed issue with .always type checking
* fixed issue with activation multiply checkers set

## 2.3.3 (04.05.2017)
##### Improvements
* change public/open accessible on any classes
* added param willSelect: Bool to all check functions.

## 2.3.2 (03.05.2017)
##### Improvements
* added functions: checkRow, checkSection checkAllRows

## 2.3.1 (03.05.2017)
##### Bug fix
* fixed isEnabled and value setters in suggestion row type
* fixed README

## 2.3.0 (28.04.2017)
##### Improvements
* abstracted BxInputRowChecker (remove row assignation from check function)
* made generic Row class for BxInputBaseRowChecker
* added to BxInputRowDecorator the 'deactivate' method
* created BxInputDisabledRowDecorator as alternative decorator
* created BxInputDependencyRowsChecker for check dependency rows
* renamed didChangedValue to didChangeValue (removed 'd' char), changeRow to willChangeActiveRow in BxInputController
* changed BxInputRowCheckerPriority
* updated example and README

## 2.2.1 (26.04.2017)
##### Bug fix
* fixed bug with active UITextField in selector rows
* added default init to Checker

## 2.2.0 (26.04.2017)
##### Features
* added decorator entity for marking a row
* added checker entity for finding mistake in value of a row
* made BxInputStandartErrorRowDecorator for default marking mistakes
* made BxInputEmptyValueChecker for not empty checking
* made BxInputEmailChecker for testing an email
* added possibility change priority of checking
* extracted base interface for cells BxInputTitleCell and BxInputFieldCell
* added subtitle to base row
* added subtitle to all rows with init
* refactoring base Binder: added BxInputBaseTitleRowBinder, BxInputBaseFieldRowBinder subclasses
* illustrated marking of putting error in the example
* updated README and CHANGELOG

## 2.1.2 (24.03.2017)
##### Bug fix
* fixed call didChangedValue if start editing Variant & Date rows with simple type & selector too

## 2.1.1 (23.03.2017)
##### Improvements
* renamed globalCellHeight to cellHeight in BxInputSettings
* added headerHeight & footerHeight to BxInputSettings as global values of content size

## 2.1.0 (23.03.2017)
##### Change logic
* extracted BxInputValueRow for didChangedValue
* removed BxInputStringRow
* rename didChangedRow(_) to didChangedValue(row)
* added didChangedValue(row) to base Binder
* added didChangedValue() to Row protocol

## 2.0.2 (21.03.2017)
##### Improvements
* added checking of expected Cell, Row and View, ContentSection templates classes from Binders.

## 2.0.1 (21.03.2017)
##### Bug fixing
* made resourceId in SectionContent as getter property
* made public inits for all binder
* made open all binder getter in Row & SectionContent
* added template View to BxInputStringHeaderSectionContentBinder

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
* extract item classes from suggestion & variant's rows
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
* firstable selection of date or variant's rows call didChange before showing child row

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
