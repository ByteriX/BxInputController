/**
 *	@file BxInputPictureLibraryItem.swift
 *	@namespace BxInputController
 *
 *	@details Implementation picture item as PHAsset owner. It may be image from Library
 *	@date 06.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import AssetsLibrary
import Photos

/// Implementation picture item as PHAsset owner. It may be image from Library
public class BxInputPictureLibraryItem : BxInputPictureItem
{
    /// storge of icon
    internal var asset: PHAsset
    /// From BxInputPictureItem icon size
    public var iconSize: CGSize
    /// From BxInputPictureItem icon data
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

/// operator return is equal two BxInputPictureLibraryItem
func == (left: BxInputPictureLibraryItem, right: BxInputPictureLibraryItem) -> Bool {
    let result = (left === right)
    if !result {
        return left.asset.localIdentifier == right.asset.localIdentifier
    }
    return result
}

/// operator return is equal BxInputPictureLibraryItem and PHAsset
func == (left: BxInputPictureLibraryItem, right: PHAsset) -> Bool {
    let result = (left.asset === right)
    if !result {
        return left.asset.localIdentifier == right.localIdentifier
    }
    return result
}
