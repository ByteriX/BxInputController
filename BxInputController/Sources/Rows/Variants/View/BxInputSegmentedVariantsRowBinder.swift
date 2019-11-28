/**
 *    @file BxInputSegmentedVariantsRowBinder.swift
 *    @namespace BxInputController
 *
 *    @details Binder for BxInputSegmentedVariantsRow
 *    @date 28.11.2019
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/ByteriX/BxInputController.git
 *    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *     Copyright (c) 2019 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputVariantsRow
open class BxInputSegmentedVariantsRowBinder<T : BxInputStringObject, Cell : BxInputSegmentedVariantsCell> : BxInputBaseTitleRowBinder<BxInputSegmentedVariantsRow<T>, Cell>
{
    
    /// update cell from model data
    override open func update()
    {
        super.update()
        //
        guard let cell = cell else {
            return
        }
        
        cell.delegate = self

        cell.selectionStyle = .none
        
        cell.segmentedControl.removeAllSegments()
        for (index, variant) in row.items.enumerated() {
            cell.segmentedControl.insertSegment(withTitle: variant.stringValue, at: index, animated: false)
        }
        
        let index = row.items.firstIndex { item -> Bool in
            return row.value === item
        }
        
        cell.segmentedControl.selectedSegmentIndex = index ?? -1
    }
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        cell.segmentedControl.isUserInteractionEnabled = value
        // UI part
        #warning("Код повторяется всюду")
        if needChangeDisabledCell {
            if let changeViewEnableHandler = owner?.settings.changeViewEnableHandler {
                changeViewEnableHandler(cell.segmentedControl, isEnabled)
            } else {
                cell.segmentedControl.alpha = value ? 1 : alphaForDisabledView
            }
        } else {
            cell.segmentedControl.alpha = 1
        }
    }
    
}

extension BxInputSegmentedVariantsRowBinder: BxInputSegmentedVariantsDelegate
{
    open func changeSegmentedControl(_ segmentedControl: UISegmentedControl){
        let index = segmentedControl.selectedSegmentIndex
        assert(row.items.count > index)
        row.value = row.items[index]
        didChangeValue()
    }
    
}
