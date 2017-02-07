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
    var insertRect: CGRect = CGRect()
    
    let dataSource = BxInputSelectorPicturesLibraryDataSource()
    let picturesPanel = UIView()
    
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
        
        picturesPanel.frame = dataSource.picturesCollection.bounds
        dataSource.picturesCollection.autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleBottomMargin]
        picturesPanel.addSubview(dataSource.picturesCollection)
        picturesPanel.clipsToBounds = false
        
        valueTextField.inputView = picturesPanel
        
        dataSource.picturesCollection.reloadData()
        valueTextField.becomeFirstResponder()
    }
    
    override open func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        dataSource.selectHandler = { [weak self] (picture, cell) -> Void in
            self?.selectPicture(picture, cell: cell)
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
                let pictureView = BxInputSelectorPictureView(picture: picture, size: size, mode: parentRow.iconMode)
                addPictureView(pictureView)
            }
            updatePictures()
        }
    }
    
    func selectPicture(_ picture: BxInputPicture, cell: BxInputPictureCollectionCell) {
        if let row = data as? BxInputChildSelectorPicturesRow,
            let parentRow = row.parent as? BxInputSelectorPicturesRow
        {
            if parentRow.maxSelectedCount > parentRow.pictures.count {
                parentRow.pictures.append(picture)
                let pictureView = BxInputSelectorPictureView(picture: picture, size: size, mode: parentRow.iconMode)
                pictureView.frame = picturesPanel.convert(cell.frame, from: dataSource.picturesCollection)
                picturesPanel.superview?.bringSubview(toFront: picturesPanel)
                picturesPanel.addSubview(pictureView)
                UIView.animate(withDuration: 0.5, animations: {[weak self] () in
                    guard let this = self else {
                        return
                    }
                    pictureView.frame = this.dataSource.picturesCollection.convert(this.insertRect, from: this.selectedScrollView)
                }, completion: {[weak self] (finished) in
                    guard let this = self else {
                        return
                    }
                    this.addPictureView(pictureView)
                    let x = this.insertRect.origin.x - this.selectedScrollView.frame.size.width
                    if x > 0 {
                        this.selectedScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
                    }
                    this.parent?.updateRow(parentRow)
                })
                
            } else {
                selectedScrollView.shakeX(withOffset: 50, breakFactor: 0.65, duration: 0.75, maxShakes: 5)
            }
        }
    }
    
    func addPictureView(_ pictureView: BxInputSelectorPictureView) {
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
        insertRect = CGRect(x: x, y: margin, width: size.width, height: size.height)
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
