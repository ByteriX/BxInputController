//
//  BxInputSegmentedVariantsCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 28.11.2019.
//  Copyright © 2019 Byterix. All rights reserved.
//

import UIKit

public protocol BxInputSegmentedVariantsDelegate: AnyObject {
    
    func changeSegmentedControl(_ segmentedControl: UISegmentedControl);
    
}

open class BxInputSegmentedVariantsCell : UITableViewCell, BxInputTitleCell {
    
    /// caption of row
    @IBOutlet weak open var titleLabel: UILabel!
    /// caption of title for the row. This is only option field
    @IBOutlet public weak var subtitleLabel: UILabel?
    /// for managment of position subtitle
    @IBOutlet public weak var subtitleBottomMargin: NSLayoutConstraint?
    /// rate control
    @IBOutlet weak open var segmentedControl: UISegmentedControl!
    
    public weak var delegate: BxInputSegmentedVariantsDelegate? = nil
    
    @IBAction func changeSegmentedControl(_ segmentedControl: UISegmentedControl){
        delegate?.changeSegmentedControl(segmentedControl)
    }

}
