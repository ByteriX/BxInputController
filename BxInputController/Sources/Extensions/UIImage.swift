//
//  UIImage.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 02/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

extension UIImage
{
    
    static func multiplyImage(_ image: UIImage, by color: UIColor) -> UIImage {
        let backgroundSize = image.size
        UIGraphicsBeginImageContext(backgroundSize)
        
        let ctx = UIGraphicsGetCurrentContext()!
        
        var backgroundRect=CGRect()
        backgroundRect.size = backgroundSize
        backgroundRect.origin.x = 0
        backgroundRect.origin.y = 0
        
        let myFloatForR = 0
        var r = CGFloat(myFloatForR)
        let myFloatForG = 0
        var g = CGFloat(myFloatForG)
        let myFloatForB = 0
        var b = CGFloat(myFloatForB)
        let myFloatForA = 0
        var a = CGFloat(myFloatForA)
        
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        ctx.setFillColor(red: r, green: g, blue: b, alpha: a)
        ctx.fill(backgroundRect)
        
        var imageRect=CGRect()
        imageRect.size = image.size
        imageRect.origin.x = (backgroundSize.width - image.size.width)/2
        imageRect.origin.y = (backgroundSize.height - image.size.height)/2
        
        // Unflip the image
        ctx.translateBy(x: 0, y: backgroundSize.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        
        ctx.setBlendMode(.multiply)
        ctx.draw(image.cgImage!, in: imageRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func multiplyImage(by color:UIColor) -> UIImage {
        return type(of: self).multiplyImage(self, by: color)
    }
    
    func maskedImage(by color: UIColor) -> UIImage {
        let image = self
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()!
        color.setFill()
        context.translateBy(x: 0, y: image.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        context.clip(to: rect, mask: image.cgImage!)
        context.fill(rect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()

        return result!
    }
    
    func halfMaskedImage(by color: UIColor) -> UIImage {
        let image = self
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()!
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        color.setFill()
        context.translateBy(x: 0, y: image.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        context.setBlendMode(.normal)
        context.draw(image.cgImage!, in: rect)

        let halfRect = CGRect(x: 0, y: 0, width: image.size.width / 2.0, height: image.size.height)
        context.clip(to: rect, mask: image.cgImage!)
        context.fill(halfRect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        
        return result!
    }
    
}
