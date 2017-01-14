//
//  BxInputController+Keyboard.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 10/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

extension BxInputController
{
    
    func registerKeyboardNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unregisterKeyboardNotification()
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func keyboardWillShown(aNotification: Notification)
    {
        if let data = aNotification.userInfo {
            onWillChangeWithKeyboard(isShowing: true, data: data)
        }
    }
    
    func keyboardWillHide(aNotification: Notification)
    {
        if let data = aNotification.userInfo {
            onWillChangeWithKeyboard(isShowing: false, data: data)
        }
    }
    
    private func onWillChangeWithKeyboard(isShowing: Bool, data: [AnyHashable: Any])
    {
        var keyBoardRect = getKeyBoardRect(data: data)
        keyBoardRect = view.convert(keyBoardRect, from: nil)
        onWillChangeWithKeyboard(isShowing: isShowing, frame: keyBoardRect)
    }
    
    func onWillChangeWithKeyboard(isShowing: Bool, frame: CGRect)
    {
        if isShowing {
            contentRect = self.view.bounds
            contentRect.size.height = frame.origin.y
        } else {
            contentRect = self.view.bounds
        }
        updateInsets()
    }

    func getKeyBoardRect(data: [AnyHashable: Any]) -> CGRect{
        if let frameInfo = data[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            return frameInfo.cgRectValue
        }
        return CGRect()
    }
    
}
