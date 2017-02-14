//
//  BxInputSelectorPictureView.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorPictureView : UIImageView {
    
    var removeHandler: (() -> Void)? = nil
    
    internal(set) public var picture: BxInputPicture
    
    internal(set) public var removeButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    
    public required init(picture: BxInputPicture, size: CGSize, mode: UIViewContentMode) {
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
    
    func removeClick() {
        if let removeHandler = removeHandler {
            removeHandler()
        }
    }
    
    
}
