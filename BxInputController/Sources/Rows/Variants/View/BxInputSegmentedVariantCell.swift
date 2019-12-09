//
//  BxInputSegmentedVariantCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 28.11.2019.
//  Copyright © 2019 Byterix. All rights reserved.
//

import UIKit

public protocol BxInputSegmentedVariantDelegate: AnyObject {
    
    func changeSegmentedControl(_ segmentedControl: UISegmentedControl);
    
}

open class BxInputSegmentedVariantCell : UITableViewCell, BxInputTitleCell {
    
    /// caption of row
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet var titleLeading: NSLayoutConstraint!
    /// caption of title for the row. This is only option field
    @IBOutlet public weak var subtitleLabel: UILabel?
    /// for managment of position subtitle
    @IBOutlet public weak var subtitleBottomMargin: NSLayoutConstraint?
    /// rate control
    @IBOutlet weak open var segmentedControl: UISegmentedControl!
    @IBOutlet public var segmentedLeading: NSLayoutConstraint!
    
    public weak var delegate: BxInputSegmentedVariantDelegate? = nil
    
    @IBAction func changeSegmentedControl(_ segmentedControl: UISegmentedControl){
        delegate?.changeSegmentedControl(segmentedControl)
    }

}
