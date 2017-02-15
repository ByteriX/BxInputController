/**
 *	@file BxInputPictureCollectionCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for collection of Photos. Used for picture selector
 *	@date 03.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Cell for collection of Photos. Used for picture selector. See BxInputSelectorPicturesLibraryDataSource
open class BxInputPictureCollectionCell : UICollectionViewCell
{

    internal(set) public var pictureView: UIImageView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        pictureView = UIImageView(frame: self.contentView.bounds)
        pictureView.contentMode = .scaleAspectFit
        pictureView.clipsToBounds = true
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
