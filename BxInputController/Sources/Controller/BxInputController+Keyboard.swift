/**
 *	@file BxInputController+Keyboard.swift
 *	@namespace BxInputController
 *
 *	@details Working with keyboard in BxInputController
 *	@date 10.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Working with keyboard in BxInputController
extension BxInputController
{
    
    internal func registerKeyboardNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    internal func unregisterKeyboardNotification()
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    internal func keyboardWillShown(aNotification: Notification)
    {
        if let data = aNotification.userInfo {
            keyboardWillChange(isShowing: true, data: data)
        }
    }
    
    internal func keyboardWillHide(aNotification: Notification)
    {
        if let data = aNotification.userInfo {
            keyboardWillChange(isShowing: false, data: data)
        }
    }
    
    private func keyboardWillChange(isShowing: Bool, data: [AnyHashable: Any])
    {
        var keyBoardRect = getKeyBoardRect(data: data)
        keyBoardRect = view.convert(keyBoardRect, from: nil)
        keyboardWillChange(isShowing: isShowing, frame: keyBoardRect)
    }

    private func getKeyBoardRect(data: [AnyHashable: Any]) -> CGRect{
        if let frameInfo = data[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            return frameInfo.cgRectValue
        }
        return CGRect()
    }
    
    /// event when keyboard will show or hide. 
    /// - parameter frame: frame of keyboard to view of controller
    open func keyboardWillChange(isShowing: Bool, frame: CGRect)
    {
        if isShowing {
            contentRect = self.view.bounds
            contentRect.size.height = frame.origin.y
        } else {
            contentRect = self.view.bounds
        }
        updateInsets()
    }
    
}
