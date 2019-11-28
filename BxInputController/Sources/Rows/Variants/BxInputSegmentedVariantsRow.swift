/**
*    @file BxInputSegmentedVariantsRow.swift
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

open class BxInputSegmentedVariantsRow<T : BxInputStringObject> : BxInputVariantsRow<T> {
    
    open override var binder : BxInputRowBinder {
        return BxInputSegmentedVariantsRowBinder<T, BxInputSegmentedVariantsCell>(row: self)
    }
    
    open override var resourceId : String {
        get { return "BxInputSegmentedVariantsCell" }
    }
//    open var estimatedHeight : CGFloat {
//        get { return 60 }
//    }
    
}
