/**
 *	@file BxInputSectionContentBinder.swift
 *	@namespace BxInputController
 *
 *	@details Protocol and base class for binding data model with view of section content
 *	@date 18.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Protocol for binding data model with view of section content
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

/// Base class for binding data model with view of section content
open class BxInputBaseSectionContentBinder<Content: BxInputSectionContent, View : UIView> : NSObject, BxInputSectionContentBinder
{
    
    /// owner
    public weak var owner: BxInputController? = nil
    /// reference to model data
    public var contentData: BxInputSectionContent {
        get { return content }
        //set { content = newValue as! Content}
        set {
            if let content = newValue as? Content {
                self.content = content
            } else {
                assertionFailure("Error View class from \(type(of: self)).\nExpected: \(Content.self) actual: \(type(of: newValue)).")
            }
        }
    }
    /// view of content
    public var contentView: UIView? {
        get { return view }
        //set { view = newValue as? View }
        set {
            if let view = newValue as? View {
                self.view = view
            } else {
                if let view = newValue{
                    assertionFailure("Error View class from \(type(of: self)).\nExpected: \(View.self) actual: \(type(of: view)).\nThis use from section content with class \(type(of: content)).")
                } else {
                    assertionFailure("Error from \(type(of: self)) get nil section content from tableView.\nThis use from section content with class \(type(of: content)).")
                }
            }
        }
    }
    
    /// data model of section content
    internal(set) public var content: Content
    /// view of section content
    public weak var view: View? = nil
    
    /// new value should map with data model
    public init(content: Content)
    {
        self.content = content
    }
    
    /// call before showing view when need update content
    open func update()
    {
        // empty
    }
    
}
