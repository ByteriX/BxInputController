//
//  BxInputPictureLibraryItem.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos


public class BxInputPictureLibraryItem : BxInputPicture
{
    internal var asset: ALAsset
    
    public var iconSize: CGSize
    
    public var icon: UIImage {
        get { return getImage(from: asset) }
    }
    
    public init (asset: ALAsset, iconSize: CGSize){
        self.asset = asset
        self.iconSize = iconSize
    }
    
    public func getImage(from asset: ALAsset) -> UIImage
    {
        //        if let image = asset.thumbnail(){
        //            return UIImage(cgImage: image as! CGImage)
        //        }
        return imageFromPHAsset(converterALAssetToPHAsset(asset))!
    }
    
    public func converterALAssetToPHAsset(_ alAsset: ALAsset) -> PHAsset
    {
        let fetchOptions = PHFetchOptions()
        let url = alAsset.value(forProperty: ALAssetPropertyAssetURL) as! URL
        let result = PHAsset.fetchAssets(withALAssetURLs: [url], options: fetchOptions)
        return result.firstObject!
    }
    
    public func imageFromPHAsset(_ asset: PHAsset) -> UIImage? {
        var image: UIImage? = nil
        let size = iconSize
        
        let options = PHImageRequestOptions()
        options.resizeMode = .exact
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        let imageSize = CGSize(width: size.width * UIScreen.main.scale, height: size.height * UIScreen.main.scale)
        PHImageManager.default().requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: options) { (result, info) in
            image = result
        }
        return image
    }
}

func == (left: BxInputPictureLibraryItem, right: BxInputPictureLibraryItem) -> Bool {
    let result = (left === right)
    if !result {
        let leftId = left.converterALAssetToPHAsset(left.asset).localIdentifier
        let rightId = right.converterALAssetToPHAsset(right.asset).localIdentifier
        return leftId == rightId
    }
    return result
}
