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
    public var parent: BxInputSection? = nil

    open var contentView: UIView
    
    public init(view: UIView) {
        contentView = view
    }
}
