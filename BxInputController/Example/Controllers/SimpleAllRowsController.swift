//
//  SimpleAllRowsController.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 15/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


class SimpleAllRowsController: BxInputController {
    
    
    // Action
    internal let stringActionRow = BxInputActionStringRow(title: "string action")
    internal let customActionRow = BxInputActionCustomRow<BxInputActionStringRow>(title: "custom action")
    internal let iconActionRow = BxInputIconActionRow<String>(icon: UIImage(named: "actionIcon"), iconSize: CGSize(width: 32, height: 32), title: "icon row")
    internal let coloredActionRow = BxInputIconActionRow<String>(title: "colored row", titleColor: UIColor.red, value: "It is long value")
    // Boolean
    internal let switchRow = BxInputSwitchRow(title: "boolean switch", value: true)
    internal let checkRow = BxInputCheckRow(title: "boolean check", placeholder: "selected value")
    // Date
    internal let dateRow = BxInputDateRow(title: "date", value: Date().addingTimeInterval(900000))
    internal let selectorDateRow = BxInputSelectorDateRow(title: "selector date")
    // Pictures
    internal let selectorPicturesRow = BxInputSelectorPicturesRow(title: "selector pictures")
    // Rate
    internal let rateRow = BxInputRateRow(title: "rate", maxValue: 10)
    // Suggestions
    internal let selectorSuggestionsRow = BxInputSelectorSuggestionsRow<BxInputChildSelectorSuggestionsRow>(title: "selector suggestions")
    // Text
    internal let shortTextRow = BxInputTextRow(title: "text value", placeholder: "not empty 10 symboles", maxCount: 10)
    internal let phoneTextRow = BxInputFormattedTextRow(title: "phone value", subtitle: "only russian", placeholder: "(___)-___-__-__", prefix: "+7", format: "(###)-###-##-##")
    internal let urlRow = BxInputFormattedTextRow(title: "url value", placeholder: "example", prefix: "http://", sufix: ".byterix.com")
    internal let textMemoRow = BxInputTextMemoRow(placeholder: "big text without selector")
    internal let selectorTextRow = BxInputSelectorTextRow(title: "text with selector", placeholder: "longest text", maxCount: 200)
    
    
    // Variant
    internal let variantRow = BxInputVariantRow<BxInputVariantItem>(title: "variant")
    internal let selectorVariantRow = BxInputSelectorVariantRow<BxInputVariantItem>(title: "selector variant")
    internal let searchVariantRow = BxInputSearchVariantRow<BxInputVariantItem>(title: "search variant")
    internal let segmentedVariantRow = BxInputSegmentedVariantRow<BxInputVariantItem>(title: "Segm.", width: .min)


    private let variantItems : [BxInputVariantItem] = [
        BxInputVariantItem(id: "1", name: "val. A"),
        BxInputVariantItem(id: "2", name: "val. B"),
        BxInputVariantItem(id: "3", name: "val. C"),
        BxInputVariantItem(id: "4", name: "val. D"),
        ]
    private let suggestionItems = [
        BxInputChildSelectorSuggestionsRow(title: "value 1"),
        BxInputChildSelectorSuggestionsRow(title: "value 2"),
        BxInputChildSelectorSuggestionsRow(title: "value 3"),
        BxInputChildSelectorSuggestionsRow(title: "value 4"),
        BxInputChildSelectorSuggestionsRow(title: "value 5")
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
        iconActionRow.isImmediatelyDeselect = true
        coloredActionRow.handler = {[weak self] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            this.coloredActionRow.titleColor = UIColor.green
            this.updateRow(this.coloredActionRow)
        }
        coloredActionRow.isImmediatelyDeselect = true
        selectorDateRow.minimumDate = Date()
        selectorDateRow.defaultDate = Date().addingTimeInterval(900000)
        selectorDateRow.maximumDate = Date().addingTimeInterval(1200000)
        selectorSuggestionsRow.children = suggestionItems
        variantRow.items = variantItems
        selectorVariantRow.items = variantItems
        searchVariantRow.searchHandler = {[weak self] (row, text) -> [BxInputVariantItem] in
            guard let this = self else { return [] }
            return this.variantItems.filter({ (item) -> Bool in
                return item.name.contains(text)
            })
        }
        segmentedVariantRow.items = variantItems
        
        urlRow.patternTextColor = UIColor.gray
        urlRow.enteredTextFont = UIFont.systemFont(ofSize: 14)
        
        textMemoRow.value =
            "# Versions\n## 2.11.0 (11.07.2018)\n##### Improvments\n* added maxCount to BxInputTextRow and inherited for limitation of string putting\n used BxInputTextSourceProtocol for abstarct solution with UITextField and UITextView\n* changed Simple example to show maxCount using\n\n## 2.10.1 (10.07.2018)\n##### Improvments\n* fixed SDK issue with false value of 'adjust to fit'"
        selectorTextRow.value = textMemoRow.value! + "\nNew line"

        self.sections = [
            BxInputSection(headerText: "Action", rows: [stringActionRow, customActionRow, iconActionRow, coloredActionRow]),
            BxInputSection(headerText: "Boolean", rows: [switchRow, checkRow]),
            BxInputSection(headerText: "Date", rows: [dateRow, selectorDateRow]),
            BxInputSection(headerText: "Pictures", rows: [selectorPicturesRow]),
            BxInputSection(headerText: "Rate", rows: [rateRow]),
            BxInputSection(headerText: "Suggestions", rows: [selectorSuggestionsRow]),
            BxInputSection(headerText: "Text", rows: [shortTextRow, phoneTextRow, urlRow, textMemoRow, selectorTextRow]),
            BxInputSection(headerText: "Variant", rows: [variantRow, selectorVariantRow, searchVariantRow, segmentedVariantRow])
        ]
        
        addChecker(BxInputEmptyValueChecker<BxInputTextRow>(row: shortTextRow, placeholder: "Please put short text"), for: shortTextRow)
    }
    
    
}

