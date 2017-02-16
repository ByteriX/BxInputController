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
    internal let enabledVariantsRow = BxInputSwitchRow(title: "variants", value: true)
    internal let enabledSelectorVariantsRow = BxInputSwitchRow(title: "selector variants", value: true)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            BxInputSection(headerText: "Access menegment enabled/disabled",
                           rows: [enabledStringActionRow, enabledCustomActionRow, enabledSwitchRow, enabledCheckRow,
                enabledDateRow, enabledSelectorDateRow, enabledSelectorPicturesRow, enabledRateRow,
                enabledSelectorSuggestionsRow, enabledShortTextRow, enabledSelectorTextRow,
                enabledVariantsRow, enabledSelectorVariantsRow]),
            BxInputSection(headerText: "Rows",
                           rows: [stringActionRow, customActionRow, switchRow, checkRow, dateRow,
                selectorDateRow, selectorPicturesRow, rateRow, selectorSuggestionsRow, shortTextRow,
                selectorTextRow, variantsRow, selectorVariantsRow])
        ]
    }

    
    // for enabled/disabled
    override func didChangedRow(_ row: BxInputRow)
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
        } else if row === enabledVariantsRow {
            setEnabledRow(variantsRow, enabled: enabledVariantsRow.value)
        } else if row === enabledSelectorVariantsRow {
            setEnabledRow(selectorVariantsRow, enabled: enabledSelectorVariantsRow.value)
        }
    }

}
