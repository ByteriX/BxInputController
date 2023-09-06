//
//  BxInputValueItemsRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 07.09.2023.
//  Copyright © 2023 Byterix. All rights reserved.
//

import Foundation
import UIKit

public protocol BxInputValueItemsRow: BxInputRow {
    associatedtype T : BxInputString

    var items: [T] {get set}
    var value: T? {get set}
}

public protocol BxInputValueItemsRowBinderProtocol: BxInputRowBinderMenuAll {

    associatedtype Cell: BxInputFieldCell
    associatedtype Row: BxInputValueItemsRow

    var row: Row {get}
    var cell: Cell? {get}

    func update()
    func didChangeValue()

    func toResetItems()
}

extension BxInputValueItemsRowBinderProtocol {

    public var canDeleteValue: Bool {
        return row.isEnabled && row.value != nil
    }

    public func deleteValue() {
        row.value = nil
        update()
        didChangeValue()
        toResetItems()
    }

    public var canCopyValue : Bool {
        return row.isEnabled && row.value != nil
    }

    public func copyValue(){
        if let stringValue = row.value?.stringValue {
            UIPasteboard.general.string = stringValue
        } else {
            UIPasteboard.general.string = ""
        }
    }

    public var canPasteValue : Bool {
        return row.isEnabled && UIPasteboard.general.string != nil
    }

    public func pasteValue() {
        if let string = UIPasteboard.general.string, let value = row.items.first(where: { return $0.stringValue == string }) {
            row.value = value
            update()
            didChangeValue()
            toResetItems()
        }
    }

}
