/**
 *    @file UITableViewCell.swift
 *    @namespace BxInputController
 *
 *    @details extension UITableViewCell
 *    @date 22.11.2018
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/ByteriX/BxInputController.git
 *    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *     Copyright (c) 2018 ByteriX. See http://byterix.com
 */

import UIKit

/// extension UITableViewCell
extension UITableViewCell {
    
    /// This needs for showing delete action menu when it call from canPerformAction tableView delegate
    override open func delete(_ sender: Any?) {
        if let tableView = self.superview as? UITableView {
            if let indexPath = tableView.indexPath(for: self) {
                tableView.delegate?.tableView?(tableView, performAction: #selector(delete(_:)), forRowAt: indexPath, withSender: sender)
            }
        }
    }
    
}
