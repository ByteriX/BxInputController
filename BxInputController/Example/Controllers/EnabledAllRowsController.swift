//
//  EnabledAllRowsController.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 16/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class EnabledAllRowsController: SimpleAllRowsController {
    
    
    internal let enabledStringActionRow = BxInputSwitchRow(title: "string action", value: true)
    internal let enabledCustomActionRow = BxInputSwitchRow(title: "custom action", value: true)
    internal let enabledSwitchRow = BxInputSwitchRow(title: "boolean switch", value: true)
    internal let enabledCheckRow = BxInputSwitchRow(title: "boolean check", value: true)
    internal let enabledDateRow = BxInputSwitchRow(title: "date", value: true)
    internal let enabledSelectorDateRow = BxInputSwitchRow(title: "selector date", value: true)
    internal let enabledSelectorPicturesRow = BxInputSwitchRow(title: "selector pictures", value: true)
    internal let enabledRateRow = BxInputSwitchRow(title: "rate", value: true)
    internal let enabledSelectorSuggestionsRow = BxInputSwitchRow(title: "selector suggestions", value: true)
    internal let enabledShortTextRow = BxInputSwitchRow(title: "text value", value: true)
    internal let enabledSelectorTextRow = BxInputSwitchRow(title: "text with selector", value: true)
    internal let enabledVariantRow = BxInputSwitchRow(title: "variant", value: true)
    internal let enabledSelectorVariantRow = BxInputSwitchRow(title: "selector variant", value: true)
    
    internal let isNormalShowingVariantRow = BxInputSwitchRow(title: "isNormalShowingDisabledCell", value: false)
    internal let alphaRow = BxInputFormattedTextRow(title: "alphaForDisabledView", prefix: "0.", format: "###")
    internal let enabledSectionActionRow = BxInputSwitchRow(title: "enabled section", value: true)
    internal let enabledAllActionRow = BxInputSwitchRow(title: "enabled all rows", value: true)
    
    internal let rowsSection = BxInputSection(headerText: "Rows", rows: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        alphaRow.formattingEnteredCharacters = "0123456789"
        
        rowsSection.rows = [stringActionRow, customActionRow, switchRow, checkRow, dateRow,
                            selectorDateRow, selectorPicturesRow, rateRow, selectorSuggestionsRow, shortTextRow,
                            selectorTextRow, variantRow, selectorVariantRow]

        sections = [
            BxInputSection(headerText: "Access menegment enabled/disabled",
                           rows: [enabledStringActionRow, enabledCustomActionRow, enabledSwitchRow, enabledCheckRow,
                enabledDateRow, enabledSelectorDateRow, enabledSelectorPicturesRow, enabledRateRow,
                enabledSelectorSuggestionsRow, enabledShortTextRow, enabledSelectorTextRow,
                enabledVariantRow, enabledSelectorVariantRow]),
            BxInputSection(headerText: "Settings",
                           rows: [isNormalShowingVariantRow, alphaRow, enabledSectionActionRow, enabledAllActionRow]),
            rowsSection
        ]
    }

    
    // for enabled/disabled
    override func didChangeValue(for row: BxInputValueRow)
    {
        if row === enabledStringActionRow {
            setEnabledRow(stringActionRow, enabled: enabledStringActionRow.value)
        } else if row === enabledCustomActionRow {
            setEnabledRow(customActionRow, enabled: enabledCustomActionRow.value)
        } else if row === enabledSwitchRow {
            setEnabledRow(switchRow, enabled: enabledSwitchRow.value)
        } else if row === enabledCheckRow {
            setEnabledRow(checkRow, enabled: enabledCheckRow.value)
        } else if row === enabledDateRow {
            setEnabledRow(dateRow, enabled: enabledDateRow.value)
        } else if row === enabledSelectorDateRow {
            setEnabledRow(selectorDateRow, enabled: enabledSelectorDateRow.value)
        } else if row === enabledSelectorPicturesRow {
            setEnabledRow(selectorPicturesRow, enabled: enabledSelectorPicturesRow.value)
        } else if row === enabledRateRow {
            setEnabledRow(rateRow, enabled: enabledRateRow.value)
        } else if row === enabledSelectorSuggestionsRow {
            setEnabledRow(selectorSuggestionsRow, enabled: enabledSelectorSuggestionsRow.value)
        } else if row === enabledShortTextRow {
            setEnabledRow(shortTextRow, enabled: enabledShortTextRow.value)
        } else if row === enabledSelectorTextRow {
            setEnabledRow(selectorTextRow, enabled: enabledSelectorTextRow.value)
        } else if row === enabledVariantRow {
            setEnabledRow(variantRow, enabled: enabledVariantRow.value)
        } else if row === enabledSelectorVariantRow {
            setEnabledRow(selectorVariantRow, enabled: enabledSelectorVariantRow.value)
        } else if row === enabledSectionActionRow {
            setEnabledSection(rowsSection, enabled: enabledSectionActionRow.value, with: .fade)
        } else if row === enabledAllActionRow {
            setEnabled(enabledAllActionRow.value, with: .fade)
        } else if row === isNormalShowingVariantRow {
            settings.isNormalShowingDisabledCell = isNormalShowingVariantRow.value
            refresh()
        }
    }
    
    override func willChangeActiveRow(to row: BxInputRow?) {
        super.willChangeActiveRow(to: row)
        if activeRow === alphaRow {
            if let alphaString = alphaRow.value, alphaString.isEmpty == false {
                settings.alphaForDisabledView = CGFloat(Float(alphaString)!)
            } else {
                settings.alphaForDisabledView = BxInputSettings().alphaForDisabledView
            }
            refresh()
        }
    }

}
