//
//  BxInputPicture.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

public protocol BxInputPicture: AnyObject
{
    var icon: UIImage {get}
    
    var iconSize: CGSize {get}
    
}
