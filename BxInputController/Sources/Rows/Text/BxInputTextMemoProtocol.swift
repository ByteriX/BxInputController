//
//  BxInputTextMemoProtocol.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 11.12.2019.
//  Copyright © 2019 Byterix. All rights reserved.
//
/**
*    @file BxInputTextMemoProtocol.swift
*    @namespace BxInputController
*
*    @details protocol for a TextMemo Binder
*    @date 11.12.2019
*    @author Sergey Balalaev
*
*    @version last in https://github.com/ByteriX/BxInputController.git
*    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
*     Copyright (c) 2017 ByteriX. See http://byterix.com
*/

import Foundation
import UIKit
import BxObjC

public protocol BxInputTextMemoCellProtocol {
    
    var textView: BxTextView! {get}
    var bottomShift: CGFloat {get}
    var topShift: CGFloat {get}
}

public protocol BxInputTextMemoRowProtocol : BxInputRow {
    
    var height : CGFloat {get set}
    
}

/// Protocol for a TextMemo Binder
protocol BxInputTextMemoProtocol : BxInputRowBinder {
    
    var textPosition : UITextRange? {get set}
    var memoCell: BxInputTextMemoCellProtocol? {get}
    var memoRow: BxInputTextMemoRowProtocol? {get}
    
}

extension BxInputTextMemoProtocol {
    
    /// update layout and cursore position of textView
    public func updateTextView(){
        guard let cell = memoCell else {
            return
        }
        cell.textView.layoutIfNeeded()
        checkSize(isNeedUpdate: false)
        //row.height = contentHeight

        if let textPosition = textPosition {
            cell.textView.selectedTextRange = textPosition
            self.textPosition = nil
        }
    }
    
    /// check and change only scroll if need
    public func checkScroll()
    {
        #warning("need clear shake from update/reload cell + scroll")
        guard let cell = memoCell else {
            return
        }
        if let position = cell.textView.selectedTextRange?.start,
            let owner = owner
        {
            let caretRect = cell.textView.caretRect(for: position)
            let caretRectInTable = owner.tableView.convert(caretRect, from: cell.textView)
            let caretMaxYInTable = 8 + caretRectInTable.origin.y + caretRectInTable.size.height
            
            var currentPosition = owner.tableView.contentOffset.y + owner.tableView.frame.size.height
            if #available(iOS 11.0, *) {
                currentPosition -= owner.tableView.adjustedContentInset.bottom
            } else {
                currentPosition -= owner.tableView.contentInset.bottom
            }
            let shift = caretMaxYInTable - currentPosition
            
            if shift > 0 {
                let point = CGPoint(x: owner.tableView.contentOffset.x, y: owner.tableView.contentOffset.y + shift + 4)
                owner.tableView.setContentOffset(point, animated: true)
            }
        }
    }
    
    /// Used by checkSize or update() for calculate full size of cell
    public var contentHeight : CGFloat
    {
        guard let cell = memoCell,
            let textView = memoCell?.textView
        else {
            return 0
        }
        //let contentView = cell.contentView
        //print("cell.textView.contentSize.height = \(textView.contentSize.height)")
        
        /// That it's strongest then use textView.frame
        let result = textView.contentSize.height + cell.topShift + cell.bottomShift + 1
        
        //print("contentHeight = \(result)")
        return result
    }
    
    /// check and change only size if need
    @discardableResult
    public func checkSize(isNeedUpdate: Bool = true) -> Bool
    {
        guard let cell = memoCell, let row = memoRow else {
            return false
        }
        let shift = cell.textView.contentSize.height - cell.textView.frame.size.height
        if shift > 0 {
            #warning("это не гарантирует отсутствие зацикленности")
            if isNeedUpdate {
                textPosition = cell.textView.selectedTextRange
                owner?.reloadRow(row, with: .none) // row.height will be updated from update()
                owner?.selectRow(row, at: .none, animated: false)
            } else {
                row.height = contentHeight
            }
            return false
        }
        return true
    }
    
}
