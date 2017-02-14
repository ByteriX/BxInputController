/**
 *	@file BxInputUtils.swift
 *	@namespace BxInputController
 *
 *	@details Utils singleton
 *	@date 14.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation
import UIKit

/// Utils singleton
class BxInputUtils {
    
    /// bundle for local resource this component, you can use the same names of resources and your module will have high priority
    static internal(set) public var currentBundle: Bundle = Bundle(for: BxInputController.self)
    
    /// return UINib for creating view (header/footer/cell) from the resourceId. About the priority see 'currentBundle'
    static public func getNib(resourceId: String) -> UINib
    {
        var bundle = Bundle.main
        if let _ = bundle.path(forResource: resourceId, ofType: "nib") {
            // will be used global bundle
        } else if let _ = currentBundle.path(forResource: resourceId, ofType: "nib") {
            bundle = currentBundle
        }
        return UINib(nibName: resourceId, bundle: bundle)
    }
    
    /// return an image from name. About the priority see 'currentBundle'
    @available(iOS 8.0, *)
    static public func getImage(resourceId: String) -> UIImage
    {
        if let image = UIImage(named: resourceId, in: Bundle.main, compatibleWith: nil) {
            return image
        }
        return UIImage(named: resourceId, in: currentBundle, compatibleWith: nil)!
    }
    
}
