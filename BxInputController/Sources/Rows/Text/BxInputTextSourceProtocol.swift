//
//  BxInputTextSourceProtocol.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 11/07/2018.
//  Copyright © 2018 Byterix. All rights reserved.
//

import UIKit
import BxObjC

public protocol BxInputTextSourceProtocol {
    
    var text: String? {get set}
    
}

extension UITextField : BxInputTextSourceProtocol {}
extension BxTextView : BxInputTextSourceProtocol {
    
    override open var text: String? {
        get {
            return super.text
        }
        set {
            super.text = newValue
        }
    }
    
}

extension BxInputTextSourceProtocol {
    
    mutating public func cutText(maxCount: Int, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var count = 0
        if let text = self.text, text.isEmpty == false {
            count = text.count + string.count - range.length
        } else {
            count = string.count
        }
        if count > maxCount {
            #warning("I don't know what is the best")
//            let cutLenght = count - maxCount
//            if string.count > 1 && cutLenght < string.count {
//                let resultString = string[string.startIndex..<string.index(string.endIndex, offsetBy: -cutLenght)]
//                if let text = self.text, text.isEmpty == false {
//                    if let range = text.makeRange(from: range) {
//                        self.text = text.replacingCharacters(in: range, with: resultString)
//                    }
//                } else {
//                    self.text = String(resultString)
//                }
//            }
            if string.count > 1 {
                if var text = self.text, text.isEmpty == false {
                    if let range = text.makeRange(from: range) {
                        text = text.replacingCharacters(in: range, with: string)
                    }
                    let result = text[text.startIndex..<text.index(text.endIndex, offsetBy: -count + maxCount)]
                    self.text = String(result)
                } else {
                    let result = string[string.startIndex..<string.index(string.endIndex, offsetBy: -count + maxCount)]
                    self.text = String(result)
                }
            }
            return true
        }
        return false
    }
    
}
