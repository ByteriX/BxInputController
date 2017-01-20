//
//  BxInputVariants.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 10/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

protocol BxInputVariants {
    
    var variants: [BxInputStringObject] {get}
    var selectedVariant: BxInputStringObject? {get set}
    
}


