/**
 *	@file BxInputVariant.swift
 *	@namespace BxInputController
 *
 *	@details Row protocol for choosing one item from more
 *	@date 10.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Row protocol for choosing one item from more
protocol BxInputVariant {
    
    /// items for choosing
    var variants: [BxInputStringObject] {get}
    
    /// choosed item
    var selectedVariant: BxInputStringObject? {get set}
    
}


