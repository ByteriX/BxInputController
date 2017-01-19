//
//  BxInputSectionContent.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

public protocol BxInputSectionContent : AnyObject {
    
    var parent: BxInputSection? {get set}
    
    var estimatedHeight : CGFloat {get}
}

public protocol BxInputSectionViewContent : BxInputSectionContent {
    
    var contentView: UIView {get}
    
}

public protocol BxInputSectionNibContent : BxInputSectionContent {
    
    var resourceId : String {get}
    
}

public protocol BxInputSectionStringContent : BxInputSectionNibContent {
    
    var contentText : String {get}
    
}
