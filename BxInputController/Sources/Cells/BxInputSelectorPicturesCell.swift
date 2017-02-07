//
//  BxInputSelectorPicturesCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 03/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos

public class BxInputSelectorPicturesCell: BxInputStandartCell {
    

    @IBOutlet weak open var valueTextField: UITextField!
    @IBOutlet weak var selectedScrollView: UIScrollView!
    
    weak var rowData: BxInputSelectorPicturesRow!
    var pictureViews: [BxInputSelectorPictureView] = []
    
    var size : CGSize = CGSize(width: 64, height: 64)
    var margin : CGFloat = 10
    
    let dataSource = BxInputSelectorPicturesLibraryDataSource()
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override open func didSelected()
    {
        super.didSelected()
        
        valueTextField.inputView = dataSource.picturesCollection
        dataSource.picturesCollection.reloadData()
        valueTextField.becomeFirstResponder()
    }
    
    override open func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        dataSource.selectHandler = {[weak self](picture) -> Void in
            if let row = self?.data as? BxInputChildSelectorPicturesRow,
                let parentRow = row.parent as? BxInputSelectorPicturesRow
            {
                if parentRow.maxSelectedCount > parentRow.pictures.count {
                    parentRow.pictures.append(picture)
                    self?.addPicture(picture)
                    self?.parent?.updateRow(parentRow)
                } else {
                    self?.selectedScrollView.shakeX(withOffset: 50, breakFactor: 0.65, duration: 0.75, maxShakes: 5)
                }
            }
            
        }

        // clear:
        for view in pictureViews {
            view.removeFromSuperview()
        }
        pictureViews = []
        
        if let row = data as? BxInputChildSelectorPicturesRow,
            let parentRow = row.parent as? BxInputSelectorPicturesRow
        {
            rowData = parentRow
            size = parentRow.iconSize
            
            //            DispatchQueue.main.async { [weak self] () -> Void in
            //                if let variantsPicker = self?.variantsPicker {
            //                    self?.pickerView(variantsPicker, didSelectRow: index, inComponent: 0)
            //                }
            //            }
            dataSource.rowData = parentRow
            dataSource.updateAssets(size: self.frame.size.width / CGFloat(parentRow.countInRow) - 2.0)
            for picture in parentRow.pictures {
                self.addPicture(picture)
            }
        }
    }
    
    func addPicture(_ picture: BxInputPicture) {
        let pictureView = BxInputSelectorPictureView(picture: picture, size: size)
        if let row = data as? BxInputChildSelectorPicturesRow,
            let parentRow = row.parent as? BxInputSelectorPicturesRow
        {
            pictureView.contentMode = parentRow.iconMode
        }
        pictureView.removeHandler = {[weak self, weak pictureView] () -> Void in
            if let row = self?.data as? BxInputChildSelectorPicturesRow,
                let parentRow = row.parent as? BxInputSelectorPicturesRow,
                let pictureView = pictureView
            {
                if let index = parentRow.pictures.index(where: { (currentPicture) -> Bool in
                    return currentPicture === pictureView.picture
                }) {
                    parentRow.pictures.remove(at: index)
                    self?.removePictureView(pictureView)
                    self?.parent?.updateRow(parentRow)
                }
            }
            
        }
        pictureViews.append(pictureView)
        updatePictures()
        self.selectedScrollView.addSubview(pictureView)
    }
    
    func removePictureView(_ pictureView: BxInputSelectorPictureView) {
        if let index = pictureViews.index(of: pictureView) {
            pictureViews.remove(at: index)
        }
        UIView.animate(withDuration: 0.25) {[weak self] () in
            self?.updatePictures()
        }
        pictureView.removeFromSuperview()
    }
    
    func updatePictures() {
        var x : CGFloat = margin
        for view in pictureViews {
            view.frame = CGRect(x: x, y: margin, width: size.width, height: size.height)
            x = x + margin + size.width
        }
        selectedScrollView.contentSize = CGSize(width: x, height: self.contentView.frame.size.height)
    }
    

}

extension BxInputSelectorPicturesCell : UITextFieldDelegate
{
    
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if let row = data as? BxInputChildSelectorPicturesRow,
            let parentRow = row.parent as? BxInputSelectorPicturesRow
        {
            parent?.activeRow = parentRow
        }
        parent?.activeControl = valueTextField
        return true
    }
    
}


extension BxInputSelectorPicturesCell : UIScrollViewDelegate
{
    
    //
    
}
