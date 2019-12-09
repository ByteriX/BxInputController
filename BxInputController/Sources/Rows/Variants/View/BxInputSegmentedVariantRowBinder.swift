/**
 *    @file BxInputSegmentedVariantRowBinder.swift
 *    @namespace BxInputController
 *
 *    @details Binder for BxInputSegmentedVariantRow
 *    @date 28.11.2019
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/ByteriX/BxInputController.git
 *    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *     Copyright (c) 2019 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputVariantRow
open class BxInputSegmentedVariantRowBinder<T : BxInputStringObject, Cell : BxInputSegmentedVariantCell> : BxInputBaseTitleRowBinder<BxInputSegmentedVariantRow<T>, Cell>
{
    
    /// update cell from model data
    override open func update()
    {
        super.update()
        //
        guard let cell = cell else {
            return
        }
        
        cell.segmentedLeading.isActive = (row.title != nil)

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
        
        switch row.width {
        case .max:
            cell.segmentedControl.setContentHuggingPriority(.defaultLow, for: .horizontal)
        case .min:
            cell.segmentedControl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        case .fixed(let value):
            cell.segmentedControl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            for index in 0..<cell.segmentedControl.numberOfSegments {
                cell.segmentedControl.setWidth(value, forSegmentAt: index)
            }
        }
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

extension BxInputSegmentedVariantRowBinder: BxInputSegmentedVariantDelegate
{
    open func changeSegmentedControl(_ segmentedControl: UISegmentedControl){
        let index = segmentedControl.selectedSegmentIndex
        assert(row.items.count > index)
        row.value = row.items[index]
        didChangeValue()
    }
    
}

extension BxInputSegmentedVariantRowBinder: BxInputRowBinderMenuAll
{

    open var canDeleteValue: Bool {
        return row.isEnabled && row.value != nil
    }
    
    open func deleteValue() {
        row.value = nil
        update()
        didChangeValue()
    }
    
    open var canCopyValue : Bool {
        return row.isEnabled && row.value != nil
    }
    
    open func copyValue(){
        if let stringValue = row.value?.stringValue {
            UIPasteboard.general.string = stringValue
        } else {
            UIPasteboard.general.string = ""
        }
    }
    
    open var canPasteValue : Bool {
        return row.isEnabled && UIPasteboard.general.string != nil
    }
    
    open func pasteValue() {
        if let string = UIPasteboard.general.string, let value = row.items.first(where: { return $0.stringValue == string }) {
            row.value = value
            update()
            didChangeValue()
        }
    }
    
}
