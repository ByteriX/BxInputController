//
//  BxInputSelectorPicturesLibraryDataSource.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 03/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos

open class BxInputSelectorPicturesLibraryDataSource : NSObject {
    
    var selectHandler: ((_ picture: BxInputPicture, _ cell: BxInputPictureCollectionCell) -> Void)? = nil
    weak var rowData: BxInputSelectorPicturesRow? = nil
    
    private static let assetLibrary = ALAssetsLibrary()
    
    internal(set) public var size: CGFloat = 100
    internal(set) public var layoutCollection: UICollectionViewFlowLayout!
    internal(set) public var picturesCollection: UICollectionView!
    
    internal let picturesCellId = "picturesCellId"
    
    var librairyAssets: PHFetchResult<PHAsset> = PHFetchResult()
    
    override init() {
        super.init()
        layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.minimumLineSpacing = 2
        layoutCollection.minimumInteritemSpacing = 2
        layoutCollection.scrollDirection = .vertical
        let rect = CGRect(x: 0, y: 0, width: 320, height: 216)
        picturesCollection = UICollectionView(frame: rect, collectionViewLayout: layoutCollection)
        picturesCollection.register(BxInputPictureCollectionCell.self, forCellWithReuseIdentifier: picturesCellId)
        picturesCollection.backgroundColor = UIColor.clear
        picturesCollection.delegate = self
        picturesCollection.dataSource = self
    }
    
    internal lazy var fetchOptions: PHFetchOptions = {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOptions
    }()
    
    internal func requestPhotoAccessIfNeeded(_ status: PHAuthorizationStatus) {
        guard status == .notDetermined else { return }
        PHPhotoLibrary.requestAuthorization { [weak self] (authorizationStatus) in
            DispatchQueue.main.async { [weak self] in
                self?.update()
            }
        }
    }
    
    internal func update() {
        librairyAssets = PHAsset.fetchAssets(with: fetchOptions)
        self.picturesCollection.reloadData()
    }
    
    open func updateAssets(size: CGFloat)
    {
        self.size = size
        layoutCollection.itemSize = CGSize(width: size, height: size)
        
        requestPhotoAccessIfNeeded(PHPhotoLibrary.authorizationStatus())
         update()
    }
    
    open func isUnSelectable(_ picture: PHAsset) -> Bool
    {
        guard let data = rowData,
         data.isUniqueue == true else
        {
            return false
        }
        if let _ = data.pictures.index(where: { (currentPicture) -> Bool in
            if let currentPicture = currentPicture as? BxInputPictureLibraryItem {
                return currentPicture == picture
            } else {
                return false
            }
            
        }) {
            return true
        }
        return false
    }
    
}

extension BxInputSelectorPicturesLibraryDataSource : UICollectionViewDelegate, UICollectionViewDataSource
{
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return librairyAssets.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //
    }
    
    open func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = picturesCollection.dequeueReusableCell(withReuseIdentifier: picturesCellId, for: indexPath) as! BxInputPictureCollectionCell
        let asset = librairyAssets[indexPath.row]
        cell.pictureView.image = BxInputPictureLibraryItem.imageFromPHAsset(asset, size: CGSize(width: size, height: size))
        if let data = rowData {
            cell.pictureView.contentMode = data.iconMode
            if isUnSelectable(asset) {
                cell.pictureView.alpha = 0.25
            } else {
                cell.pictureView.alpha = 1
            }
        }
        cell.setNeedsDisplay()
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = librairyAssets[indexPath.row]
        if isUnSelectable(asset) {
            return
        }
        if let selectHandler = selectHandler,
            let cell = collectionView.cellForItem(at: indexPath) as? BxInputPictureCollectionCell
        {
            let picture = BxInputPictureLibraryItem(asset: asset, iconSize: CGSize(width: size, height: size))
            selectHandler(picture, cell)
        }
    }

    
}
