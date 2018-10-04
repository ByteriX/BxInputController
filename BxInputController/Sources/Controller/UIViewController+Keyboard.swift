/**
 *	@file UIViewController+Keyboard.swift
 *	@namespace BxInputController
 *
 *	@details Working with keyboard in UIViewController
 *	@date 10.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

#if swift( >=4.2 )
    let bxKeyboardWillShow = UIResponder.keyboardWillShowNotification
    let bxKeyboardWillHide = UIResponder.keyboardWillHideNotification
    let bxKeyboardFrameEndUserInfoKey = UIResponder.keyboardFrameEndUserInfoKey
#else
    let bxKeyboardWillShow = NSNotification.Name.UIKeyboardWillShow
    let bxKeyboardWillHide = NSNotification.Name.UIKeyboardWillHide
    let bxKeyboardFrameEndUserInfoKey = UIKeyboardFrameEndUserInfoKey
#endif

/// event when keyboard will show or hide.
public protocol BxKeyboardChangeProtocol : NSObjectProtocol {
    
    /// - parameter frame: frame of keyboard to view of controller
    /// - This method need to override in your class, don't forget call registerKeyboardNotification() and unregisterKeyboardNotification(). In iOS 10 last func call not required
    func keyboardWillChange(isShowing: Bool, frame: CGRect)
    
}

/// Working with keyboard in UIViewController
extension BxKeyboardChangeProtocol where Self: UIViewController
{
    
    /// This need after probably controller show/hide keyboard. For example in viewWillAppear
    public func registerKeyboardNotification()
    {
        NotificationCenter.default.addObserver(forName: bxKeyboardWillShow, object: nil, queue: nil) {[weak self] (notification) in
            self?.keyboardWillShown(aNotification: notification)
        }
        NotificationCenter.default.addObserver(forName: bxKeyboardWillHide, object: nil, queue: nil) {[weak self] (notification) in
            self?.keyboardWillHide(aNotification: notification)
        }
    }
    
    /// This need after probably controller show/hide keyboard. For example in viewDidDisappear
    public func unregisterKeyboardNotification()
    {
        NotificationCenter.default.removeObserver(self, name: bxKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: bxKeyboardWillHide, object: nil)
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
        if let frameInfo = data[bxKeyboardFrameEndUserInfoKey] as? NSValue {
            return frameInfo.cgRectValue
        }
        return CGRect()
    }
    
}
