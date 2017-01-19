//
//  BxInputSectionView.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 17/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSectionView : BxInputSectionViewContent
{
    open var estimatedHeight : CGFloat {
        get { return contentView.frame.size.height }
    }
    
    public var parent: BxInputSection? = nil

    open var contentView: UIView
    
    public init(view: UIView) {
        contentView = view
    }
}
