/**
 *	@file BxInputSelectorPictureView.swift
 *	@namespace BxInputController
 *
 *	@details View for showing on selector. It is chosen by user and has button for canceling
 *	@date 06.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// View for showing on selector. It is chosen by user and has button for canceling
open class BxInputSelectorPictureView : UIImageView {
    
    public var removeHandler: (() -> Void)? = nil
    
    public var isEnabled: Bool = true {
        didSet {
            //removeButton.isEnabled = isEnabled
            //self.alpha = isEnabled ? 1.0 : 0.5
            removeButton.isHidden = !isEnabled
        }
    }
    
    internal(set) public var picture: BxInputPictureItem
    
    internal(set) public var removeButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    
    public required init(picture: BxInputPictureItem, size: CGSize, mode: UIViewContentMode) {
        self.picture = picture
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.image = picture.icon
        self.clipsToBounds = true
        self.contentMode = mode
        self.isUserInteractionEnabled = true
        
        removeButton.addTarget(self, action: #selector(removeClick), for: .touchUpInside)
        let removeImage = BxInputUtils.getImage(resourceId: "bx_remove_icon")
        removeButton.setImage(removeImage, for: .normal)
        removeButton.imageView?.contentMode = .center
        self.addSubview(removeButton)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func removeClick() {
        if let removeHandler = removeHandler {
            removeHandler()
        }
    }
    
    
}
