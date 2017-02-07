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
    
    var selectHandler: ((_ picture: BxInputPicture) -> Void)? = nil
    weak var rowData: BxInputSelectorPicturesRow? = nil
    
    private static let assetLibrary = ALAssetsLibrary()
    
    internal(set) public var size: CGFloat = 100
    internal(set) public var layoutCollection: UICollectionViewFlowLayout!
    internal(set) public var picturesCollection: UICollectionView!
    
    internal let picturesCellId = "picturesCellId"
    
    internal(set) public var librairyPictures: [BxInputPictureLibraryItem] = []
    
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
    
    open func updateAssets(size: CGFloat)
    {
        self.size = size
        layoutCollection.itemSize = CGSize(width: size, height: size)
        
        librairyPictures = []
        let assetLibrary = type(of: self).assetLibrary
        assetLibrary.enumerateGroupsWithTypes(ALAssetsGroupSavedPhotos, usingBlock: {[weak self] (group, stop) in
            group?.setAssetsFilter(ALAssetsFilter.allPhotos())
            group?.enumerateAssets(options: .reverse, using: {[weak self] (alAsset, index, innerStop) in
                if let alAsset = alAsset {
                    let picture = BxInputPictureLibraryItem(asset: alAsset, iconSize: CGSize(width: size, height: size))
                    self?.librairyPictures.append(picture)
                    self?.picturesCollection.reloadData()
                }
            })
        }) { (error) in
            //
        }
    }
    
}

extension BxInputSelectorPicturesLibraryDataSource : UICollectionViewDelegate, UICollectionViewDataSource
{
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return librairyPictures.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //
    }
    
    open func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = picturesCollection.dequeueReusableCell(withReuseIdentifier: picturesCellId, for: indexPath) as! BxInputPictureCollectionCell
        cell.pictureView.image = librairyPictures[indexPath.row].icon
        if let data = rowData {
            cell.pictureView.contentMode = data.iconMode
        }
        cell.setNeedsDisplay()
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectHandler = selectHandler {
            selectHandler(librairyPictures[indexPath.row])
        }
    }

    
}
