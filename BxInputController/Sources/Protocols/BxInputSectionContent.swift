//
//  BxInputSectionContent.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

protocol BxInputSectionContent : AnyObject {
    //
}

protocol BxInputSectionViewContent : BxInputSectionContent {
    
    var contentView: UIView {get}
    
}

protocol BxInputSectionNibContent : BxInputSectionContent {
    
    var resourceId : String {get}
    
}

protocol BxInputSectionStringContent : BxInputSectionNibContent {
    
    var contentText : String {get}
    
}
