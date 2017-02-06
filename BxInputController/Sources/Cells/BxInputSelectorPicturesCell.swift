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
    
    var rowData: BxInputSelectorPicturesRow!
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
                parentRow.pictures.append(picture)
            }
            self?.addPicture(picture)
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
            
            dataSource.updateAssets(size: self.frame.size.width / CGFloat(parentRow.countInRow) - 2.0)
            for picture in parentRow.pictures {
                self.addPicture(picture)
            }
        }
    }
    
    func addPicture(_ picture: BxInputPicture) {
        let pictureView = BxInputSelectorPictureView(picture: picture, size: size)
        pictureView.removeHandler = {[weak self, weak pictureView] () -> Void in
            if let row = self?.data as? BxInputChildSelectorPicturesRow,
                let parentRow = row.parent as? BxInputSelectorPicturesRow,
                let pictureView = pictureView
            {
                if let index = parentRow.pictures.index(where: { (currentPicture) -> Bool in
                    return currentPicture === pictureView.picture
                }) {
                    parentRow.pictures.remove(at: index)
                }
                self?.removePictureView(pictureView)
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
    
    open func autoselection() {
        if let row = data as? BxInputChildSelectorTextRow,
            let parentRow = row.parent
        {
            if parentRow.isOpened {
                parentRow.isOpened = false
                parent?.deleteRow(row)
                parent?.updateRow(parentRow)
            }
        }
    }
    
    
    
    open func check()
    {
//        if checkContent() {
//            checkScroll()
//        }
    }
    
//    open func checkScroll()
//    {
//        if let position = textView.selectedTextRange?.start,
//            let parent = parent
//        {
//            let rect = textView.caretRect(for: position)
//            let rectInTable = parent.tableView.convert(rect, from: textView)
//            let shift =  8 + rectInTable.origin.y + rectInTable.size.height - ( parent.tableView.contentOffset.y + parent.tableView.frame.size.height - parent.tableView.contentInset.bottom)
//            if shift > 0 {
//                let point = CGPoint(x: parent.tableView.contentOffset.x, y: parent.tableView.contentOffset.y + shift + 4)
//                parent.tableView.setContentOffset(point, animated: true)
//            }
//        }
//    }
//    
//    open func checkContent() -> Bool
//    {
//        let shift = textView.contentSize.height - textView.frame.size.height
//        if shift > 0 {
//            if let row = data as? BxInputChildSelectorTextRow
//            {
//                row.height = row.height + shift + 1
//                parent?.reloadRow(row, with: .none)
//                parent?.selectRow(row, at: .none, animated: false)
//                return false
//            }
//        }
//        return true
//    }
    
}

extension BxInputSelectorPicturesCell : UITextFieldDelegate
{
    
    open func textFieldDidBeginEditing(_ textField: UITextField)
    {
        parent?.activeControl = valueTextField
        self.perform(#selector(check), with: nil, afterDelay: 0.1)
    }
    
    // Please change it
    open func textViewDidChange(_ textView: UITextView)
    {
        if let row = data as? BxInputChildSelectorTextRow,
            let parentRow = row.parent as? BxInputSelectorTextRow
        {
            parentRow.value = textView.text
            parent?.updateRow(parentRow)
            check()
        }
    }
    
}


extension BxInputSelectorPicturesCell : UIScrollViewDelegate
{
    
    //
    
}
