/**
*    @file BxInputSegmentedVariantRow.swift
*    @namespace BxInputController
*
*    @details Row for choosing one item from segmented control
*    @date 28.11.2019
*    @author Sergey Balalaev
*
*    @version last in https://github.com/ByteriX/BxInputController.git
*    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
*     Copyright (c) 2019 ByteriX. See http://byterix.com
*/

import Foundation

open class BxInputSegmentedVariantRow<T : BxInputStringObject> : BxInputVariantRow<T> {
    
    open override var binder : BxInputRowBinder {
        return BxInputSegmentedVariantRowBinder<T, BxInputSegmentedVariantCell>(row: self)
    }
    
    open override var resourceId : String {
        get { return "BxInputSegmentedVariantCell" }
    }
//    open var estimatedHeight : CGFloat {
//        get { return 60 }
//    }
    
}
