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
    internal var asset: PHAsset
    
    public var iconSize: CGSize
    
    public var icon: UIImage {
        get { return BxInputPictureLibraryItem.imageFromPHAsset(asset, size: iconSize)! }
    }
    
    public init (asset: PHAsset, iconSize: CGSize){
        self.asset = asset
        self.iconSize = iconSize
    }
    
    public init? (asset: ALAsset, iconSize: CGSize){
        guard let phAsset = BxInputPictureLibraryItem.converterALAssetToPHAsset(asset) else {
            return nil
        }
        self.asset = phAsset
        self.iconSize = iconSize
    }
    
    public static func converterALAssetToPHAsset(_ alAsset: ALAsset) -> PHAsset?
    {
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeHiddenAssets = true
        let url = alAsset.value(forProperty: ALAssetPropertyAssetURL) as! URL
        let result = PHAsset.fetchAssets(withALAssetURLs: [url], options: fetchOptions)
        return result.firstObject
    }
    
    public static func imageFromPHAsset(_ asset: PHAsset, size: CGSize) -> UIImage? {
        var image: UIImage? = nil
        
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
        return left.asset.localIdentifier == right.asset.localIdentifier
    }
    return result
}

func == (left: BxInputPictureLibraryItem, right: PHAsset) -> Bool {
    let result = (left.asset === right)
    if !result {
        return left.asset.localIdentifier == right.localIdentifier
    }
    return result
}
