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
    private let stringActionRow = BxInputActionStringRow(title: "string action")
    private let customActionRow = BxInputActionCustomRow<BxInputActionStringRow>(title: "custom action")
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
            BxInputSection(headerText: "Date", rows: [dateRow, selectorDateRow]),
            BxInputSection(headerText: "Pictures", rows: [selectorPicturesRow]),
            BxInputSection(headerText: "Rate", rows: [rateRow]),
            BxInputSection(headerText: "Suggestions", rows: [selectorSuggestionsRow]),
            BxInputSection(headerText: "Text", rows: [shortTextRow, selectorTextRow]),
            BxInputSection(headerText: "Variants", rows: [variantsRow, selectorVariantsRow])
        ]
    }
    
    
}

