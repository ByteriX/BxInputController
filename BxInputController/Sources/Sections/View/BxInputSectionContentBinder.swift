//
//  BxInputSectionContentBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 18/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

public protocol BxInputSectionContentBinder : AnyObject
{
    
    /// reference to owner
    weak var owner: BxInputController? {get set}
    /// reference to model data
    var contentData: BxInputSectionContent {get set}
    /// view
    var contentView: UIView? {get set}
    /// call before showing view when need update content
    func update()
    
}

open class BxInputBaseSectionContentBinder<Content: BxInputSectionContent, View : UIView> : NSObject, BxInputSectionContentBinder
{
    
    /// owner
    public weak var owner: BxInputController? = nil
    /// reference to model data
    public var contentData: BxInputSectionContent {
        get { return content }
        set { content = newValue as! Content}
    }
    /// view
    public var contentView: UIView? {
        get { return view }
        set { view = newValue as? View }
    }
    
    /// data model of section content
    internal(set) public var content: Content
    public weak var view: View? = nil
    
    
    
    init(content: Content)
    {
        self.content = content
    }
    
    /// call before showing view when need update content
    open func update()
    {
        // empty
    }
    
}
