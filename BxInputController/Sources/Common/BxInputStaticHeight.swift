/**
 *	@file BxInputStaticHeight.swift
 *	@namespace BxInputController
 *
 *	@details Implemention with this protocol garanted using stable size for a header/footer/row content
 *	@date 23.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Implementation with this protocol should ensure using stable size for a header/footer/row content
public protocol BxInputStaticHeight {
    
    /// size for a header/footer/row content
    var height : CGFloat {get}
    
}
