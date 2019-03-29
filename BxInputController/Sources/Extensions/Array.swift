/**
 *    @file Array.swift
 *    @namespace BxInputController
 *
 *    @details Array extension for BxTextField
 *    @date 29.03.2019
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/ByteriX/BxInputController.git
 *    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *     Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Array extension for BxInputController with supporing Swift 3/4/5
public extension Array {
    
#if swift(>=4.2)
#else
    @inlinable func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Int?
    {
        return try self.index(where: predicate)
    }
#endif
    
}
