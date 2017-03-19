/**
 *	@file BxInputChildSelectorPicturesRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputChildSelectorPicturesRow subclasses
 *	@date 06.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputChildSelectorPicturesRow subclasses
open class BxInputChildSelectorPicturesRowBinder<Row: BxInputChildSelectorPicturesRow, Cell: BxInputChildSelectorPicturesCell, ParentRow: BxInputSelectorPicturesRow> : BxInputChildSelectorRowBinder<Row, Cell, ParentRow>, UITextFieldDelegate, UIScrollViewDelegate
{

    /// property when animation of moving is complited. Started with true value.
    private var animationComplited: Bool = true
    
    /// call when user selected this cell
    override open func didSelected()
    {
        super.didSelected()
        
        guard let cell = cell else {
            return
        }
        
        cell.picturesPanel.frame = cell.dataSource.picturesCollection.bounds
        cell.dataSource.picturesCollection.autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleBottomMargin]
        cell.picturesPanel.addSubview(cell.dataSource.picturesCollection)
        cell.picturesPanel.clipsToBounds = false
        
        cell.valueTextField.inputView = cell.picturesPanel
        
        cell.dataSource.picturesCollection.reloadData()
        cell.valueTextField.becomeFirstResponder()
    }
    
    /// update cell from model data
    override open func update()
    {
        super.update()
        //
        guard let cell = cell else {
            return
        }
        //
        cell.valueTextField.delegate = self
        cell.dataSource.selectHandler = { [weak self] (picture, cell) -> Void in
            self?.selectPicture(picture, collectionCell: cell)
        }

        // clear:
        for view in cell.selectedPictureViews {
            view.removeFromSuperview()
        }
        cell.selectedPictureViews = []
        

        cell.rowData = parentRow
        cell.size = parentRow.iconSize
        
        //            DispatchQueue.main.async { [weak self] () -> Void in
        //                if let variantsPicker = self?.variantsPicker {
        //                    self?.pickerView(variantsPicker, didSelectRow: index, inComponent: 0)
        //                }
        //            }
        cell.dataSource.rowData = parentRow
        cell.dataSource.owner = owner
        cell.dataSource.updateAssets(size: cell.frame.size.width / CGFloat(parentRow.countInRow) - 2.0)
        
        for picture in parentRow.pictures {
            let pictureView = BxInputSelectorPictureView(picture: picture, size: cell.size, mode: parentRow.iconMode)
            addPictureView(pictureView)
        }
        updatePictures()
        cell.dataSource.picturesCollection.reloadData()

    }
    
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        if !value {
            cell.valueTextField.resignFirstResponder()
        }
        for pictureView in cell.selectedPictureViews {
            pictureView.isEnabled = value
        }
    }
    
    func selectPicture(_ picture: BxInputPictureItem, collectionCell: BxInputPictureCollectionCell) {
        guard let cell = cell else {
            return
        }

        if parentRow.maxSelectedCount > parentRow.pictures.count {
            parentRow.pictures.append(picture)
            let pictureView = BxInputSelectorPictureView(picture: picture, size: cell.size, mode: parentRow.iconMode)
            pictureView.frame = cell.picturesPanel.convert(collectionCell.frame, from: cell.dataSource.picturesCollection)
            cell.picturesPanel.superview?.bringSubview(toFront: cell.picturesPanel)
            cell.picturesPanel.addSubview(pictureView)
            if let indexPath = cell.dataSource.picturesCollection.indexPath(for: collectionCell) {
                cell.dataSource.picturesCollection.reloadItems(at: [indexPath])
            }
            
            UIView.animate(withDuration: 0.35, animations: {[weak self, weak cell] () in
                guard let this = self else {
                    return
                }
                guard let cell = cell else {
                    return
                }
                let x = this.getPictureFrame(from: this.parentRow.pictures.count).origin.x - cell.selectedScrollView.frame.size.width
                if x > 0 && this.animationComplited {
                    cell.selectedScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
                }
                pictureView.frame = cell.picturesPanel.convert(this.getPictureFrame(from: this.parentRow.pictures.count - 1), from: cell.selectedScrollView)
                this.animationComplited = false
                }, completion: {[weak self] (finished) in
                    guard let this = self else {
                        return
                    }
                    this.addPictureView(pictureView)
                    this.owner?.updateRow(this.parentRow)
                    this.animationComplited = true
            })
            
        } else {
            cell.selectedScrollView.shakeX(withOffset: 50, breakFactor: 0.65, duration: 0.75, maxShakes: 5)
        }

    }
    
    func getPictureFrame(from index: Int) -> CGRect {
        guard let cell = cell else {
            return CGRect()
        }
        let x = cell.margin + (cell.size.width + cell.margin) * CGFloat(index)
        return CGRect(x: x, y: cell.margin, width: cell.size.width, height: cell.size.height)
    }
    
    func addPictureView(_ pictureView: BxInputSelectorPictureView) {
        pictureView.removeHandler = {[weak cell, weak self, weak pictureView] () -> Void in
            guard let this = self,
                let pictureView = pictureView else {
                return
            }
            if let index = this.parentRow.pictures.index(where: { (currentPicture) -> Bool in
                return currentPicture === pictureView.picture
            }) {
                this.parentRow.pictures.remove(at: index)
                this.removePictureView(pictureView)
                this.owner?.updateRow(this.parentRow)
                cell?.dataSource.picturesCollection.reloadData()
            }
        }
        pictureView.isEnabled = row.isEnabled
        cell?.selectedPictureViews.append(pictureView)
        updatePictures()
        cell?.selectedScrollView.addSubview(pictureView)
    }
    
    func removePictureView(_ pictureView: BxInputSelectorPictureView) {
        if let index = cell?.selectedPictureViews.index(of: pictureView) {
            cell?.selectedPictureViews.remove(at: index)
        }
        UIView.animate(withDuration: 0.25) {[weak self] () in
            self?.updatePictures()
        }
        pictureView.removeFromSuperview()
    }
    
    func updatePictures() {
        guard let cell = cell else {
            return
        }
        var index = 0
        for view in cell.selectedPictureViews {
            view.frame = getPictureFrame(from: index)
            index = index + 1
        }
        cell.selectedScrollView.contentSize = CGSize(width: getPictureFrame(from: index).origin.x, height: cell.contentView.frame.size.height)
    }
    
    // MARK - UITextFieldDelegate
    
    /// start editing
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        guard let cell = cell else {
            return true
        }
        owner?.activeRow = parentRow
        owner?.activeControl = cell.valueTextField
        cell.dataSource.picturesCollection.reloadData()
        return true
    }
}
