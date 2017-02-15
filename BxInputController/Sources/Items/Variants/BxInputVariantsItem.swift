/**
 *	@file BxInputVariantsItem.swift
 *	@namespace BxInputController
 *
 *	@details Simple item class for showing variant in BxInputVariantsRow
 *	@date 15.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit


/// Simple item class for showing variant in BxInputVariantsRow
open class BxInputVariantsItem: BxInputStringObject
{
    public var id: String
    public var name: String
    
    open var stringValue: String? {
        get { return name }
    }
    
    public init(id: String, name: String)
    {
        self.id = id
        self.name = name
    }
}
