//
//  BxInputDisabledRowDecorator.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 27/04/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

import UIKit
import BxObjC

/// Standart decoration for showing error message in row
open class BxInputDisabledRowDecorator : BxInputRowDecorator {
    
    /// highlighed color for marking a value
    public var subtitleColor : UIColor? = nil
    /// if is defined, will change existing subtitle of row to this value.
    public var subtitle : String? = nil
    
    /// method calls when need show activation of something event
    open func activate(binder: BxInputRowBinder)
    {
        // common changes
        update(binder: binder)
    }
    
    /// method calls when binder update row
    open func update(binder: BxInputRowBinder) {
        if let cell = binder.viewCell as? BxInputTitleCell {
            if let subtitleLabel = cell.subtitleLabel {
                if let subtitleColor = subtitleColor {
                    subtitleLabel.textColor = subtitleColor
                }
                if let subtitle = subtitle {
                    subtitleLabel.text = subtitle
                }
            }
        }
        binder.owner?.setEnabledRow(binder.rowData, enabled: false)
    }
    
    /// method calls when need show activation of something event
    open func deactivate(binder: BxInputRowBinder)
    {
        // common changes
        binder.owner?.setEnabledRow(binder.rowData, enabled: true)
    }
    
}
