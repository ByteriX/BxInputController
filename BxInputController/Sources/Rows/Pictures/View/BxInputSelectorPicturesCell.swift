/**
 *	@file BxInputSelectorPicturesCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for selector a picture. This child cell places below parent cell
 *	@date 03.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import AssetsLibrary
import Photos

/// Cell for selector a picture. This child cell places below parent cell
public class BxInputSelectorPicturesCell: BxInputBaseCell {
    

    @IBOutlet weak open var valueTextField: UITextField!
    @IBOutlet weak var selectedScrollView: UIScrollView!
    
    weak var rowData: BxInputSelectorPicturesRow!
    var selectedPictureViews: [BxInputSelectorPictureView] = []
    
    var size : CGSize = CGSize(width: 64, height: 64)
    var margin : CGFloat = 10
    
    let dataSource = BxInputSelectorPicturesLibraryDataSource()
    let picturesPanel = UIView()
    
    private var animationComplited: Bool = true
    
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
        for view in selectedPictureViews {
            view.removeFromSuperview()
        }
        selectedPictureViews = []
        
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
            dataSource.parent = parent
            dataSource.updateAssets(size: self.frame.size.width / CGFloat(parentRow.countInRow) - 2.0)

            for picture in parentRow.pictures {
                let pictureView = BxInputSelectorPictureView(picture: picture, size: size, mode: parentRow.iconMode)
                addPictureView(pictureView)
            }
            updatePictures()
            dataSource.picturesCollection.reloadData()
        }
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        if !value {
            valueTextField.resignFirstResponder()
        }
        for pictureView in selectedPictureViews {
            pictureView.isEnabled = value
        }
    }
    
    func selectPicture(_ picture: BxInputPictureItem, cell: BxInputPictureCollectionCell) {
        if let row = data as? BxInputChildSelectorPicturesRow,
            let parentRow = row.parent as? BxInputSelectorPicturesRow
        {
            if parentRow.maxSelectedCount > parentRow.pictures.count {
                parentRow.pictures.append(picture)
                let pictureView = BxInputSelectorPictureView(picture: picture, size: size, mode: parentRow.iconMode)
                pictureView.frame = picturesPanel.convert(cell.frame, from: dataSource.picturesCollection)
                picturesPanel.superview?.bringSubview(toFront: picturesPanel)
                picturesPanel.addSubview(pictureView)
                if let indexPath = dataSource.picturesCollection.indexPath(for: cell) {
                    dataSource.picturesCollection.reloadItems(at: [indexPath])
                }
                
                UIView.animate(withDuration: 0.35, animations: {[weak self] () in
                    guard let this = self else {
                        return
                    }
                    let x = this.getPictureFrame(from: parentRow.pictures.count).origin.x - this.selectedScrollView.frame.size.width
                    if x > 0 && this.animationComplited {
                        this.selectedScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
                    }
                    pictureView.frame = this.picturesPanel.convert(this.getPictureFrame(from: parentRow.pictures.count - 1), from: this.selectedScrollView)
                    this.animationComplited = false
                }, completion: {[weak self] (finished) in
                    guard let this = self else {
                        return
                    }
                    this.addPictureView(pictureView)
                    this.parent?.updateRow(parentRow)
                    this.animationComplited = true
                })
                
            } else {
                selectedScrollView.shakeX(withOffset: 50, breakFactor: 0.65, duration: 0.75, maxShakes: 5)
            }
        }
    }
    
    func getPictureFrame(from index: Int) -> CGRect {
        let x = margin + (size.width + margin) * CGFloat(index)
        return CGRect(x: x, y: margin, width: size.width, height: size.height)
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
                    self?.dataSource.picturesCollection.reloadData()
                }
            }
            
        }
        pictureView.isEnabled = data?.isEnabled ?? false
        selectedPictureViews.append(pictureView)
        updatePictures()
        self.selectedScrollView.addSubview(pictureView)
    }
    
    func removePictureView(_ pictureView: BxInputSelectorPictureView) {
        if let index = selectedPictureViews.index(of: pictureView) {
            selectedPictureViews.remove(at: index)
        }
        UIView.animate(withDuration: 0.25) {[weak self] () in
            self?.updatePictures()
        }
        pictureView.removeFromSuperview()
    }
    
    func updatePictures() {
        var index = 0
        for view in selectedPictureViews {
            view.frame = getPictureFrame(from: index)
            index = index + 1
        }
        selectedScrollView.contentSize = CGSize(width: getPictureFrame(from: index).origin.x, height: self.contentView.frame.size.height)
    }
    

}

/// Implementation UIScrollViewDelegate for BxInputSelectorPicturesCell
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
        dataSource.picturesCollection.reloadData()
        return true
    }
    
}

/// Implementation UIScrollViewDelegate for BxInputSelectorPicturesCell
extension BxInputSelectorPicturesCell : UIScrollViewDelegate
{
    
    //
    
}
