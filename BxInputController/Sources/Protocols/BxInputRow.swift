//
//  BxInputRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation
import UIKit

public protocol BxInputRow : AnyObject{
    
    var title : String? {get}
    
    var placeholder : String? {get}
    
    var isEnabled : Bool {get set}
    
    var resourceId : String {get}
    
    var estimatedHeight : CGFloat {get}
    
}
