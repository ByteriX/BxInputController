//
//  BxInputPictureCollectionCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 03/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputPictureCollectionCell : UICollectionViewCell
{

    internal(set) public var pictureView: UIImageView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        pictureView = UIImageView(frame: self.contentView.bounds)
        pictureView.autoresizingMask = [.flexibleBottomMargin, .flexibleHeight, .flexibleTopMargin,
                                        .flexibleRightMargin, .flexibleWidth, .flexibleLeftMargin]
        self.contentView.addSubview(pictureView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        pictureView.image = nil
    }

}
