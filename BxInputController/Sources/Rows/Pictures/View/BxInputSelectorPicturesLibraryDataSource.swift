/**
 *	@file BxInputSelectorPicturesLibraryDataSource.swift
 *	@namespace BxInputController
 *
 *	@details Data source for showing pictures in the selection panel (with keyboard frame)
 *	@date 03.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import AssetsLibrary
import Photos

/// Data source for showing pictures in the selection panel (with keyboard frame)
open class BxInputSelectorPicturesLibraryDataSource : NSObject {
    
    public weak var owner: BxInputController? = nil
    var selectHandler: ((_ picture: BxInputPictureItem, _ cell: BxInputPictureCollectionCell) -> Void)? = nil
    weak var rowData: BxInputSelectorPicturesRow? = nil
    
    internal(set) public var size: CGFloat = 100
    internal(set) public var layoutCollection: UICollectionViewFlowLayout!
    internal(set) public var picturesCollection: UICollectionView!
    
    internal let picturesCellId = "picturesCellId"
    internal var librairyAssets: PHFetchResult<PHAsset> = PHFetchResult()
    
    internal var currentImageView: UIImageView? = nil
    internal var captureSession: AVCaptureSession? = nil
    internal var captureVideoPreviewLayer: AVCaptureVideoPreviewLayer? = nil
    internal var sesionQueue = DispatchQueue(label: "sesionPhotoQueue")
    
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
    
    internal func backCamera() -> AVCaptureDevice?
    {
#if swift ( >=4.0 )
        let devices = AVCaptureDevice.devices(for: AVMediaType.video)
#else
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else {
            return nil
        }
#endif
        for device in devices {
            if device.position == .back {
                return device
            }
        }
        return nil
    }
    
    internal func startCapture()
    {
        sesionQueue.async {[weak self] in
            guard self?.captureSession == nil, self?.captureVideoPreviewLayer == nil else {
                return
            }
            let captureSession = AVCaptureSession()
#if swift ( >=4.0 )
            captureSession.sessionPreset = AVCaptureSession.Preset.high
#else
            captureSession.sessionPreset = AVCaptureSessionPresetHigh
#endif
            let captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
#if swift ( >=4.0 )
            captureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
#else
            captureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
#endif
            do {
                guard let device = self?.backCamera()  else
                {
                    print("Error open input device")
                    return
                }
                let input = try AVCaptureDeviceInput(device: device)
                captureSession.addInput(input)
            } catch {
                print("Error open input device")
                return
            }
            
            let captureOutput = AVCaptureVideoDataOutput()
            captureOutput.alwaysDiscardsLateVideoFrames = true
            let queue = DispatchQueue(label: "CameraQueue")
            captureOutput.setSampleBufferDelegate(self, queue: queue)
            captureOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : kCVPixelFormatType_32BGRA]
            captureSession.addOutput(captureOutput)
            self?.captureSession = captureSession
            self?.captureVideoPreviewLayer = captureVideoPreviewLayer
            captureSession.startRunning()
        }
        
    }
    
    internal func stopCapture()
    {
        sesionQueue.async {[weak self] in
            self?.captureSession?.stopRunning()
            self?.captureSession = nil
            self?.captureVideoPreviewLayer = nil
        }
    }
    
    open func openImagePicker()
    {
        stopCapture()
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        owner?.present(picker, animated: true, completion: nil)
    }
    
    
    
}

/// Implementation UICollectionViewDelegate, UICollectionViewDataSource for BxInputSelectorPicturesLibraryDataSource this need for showing cells and handling user actions
extension BxInputSelectorPicturesLibraryDataSource : UICollectionViewDelegate, UICollectionViewDataSource
{
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return librairyAssets.count + 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0, let cell = cell as? BxInputPictureCollectionCell {
            self.currentImageView = cell.pictureView
            startCapture()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.currentImageView = nil
            stopCapture()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = picturesCollection.dequeueReusableCell(withReuseIdentifier: picturesCellId, for: indexPath) as! BxInputPictureCollectionCell
        if indexPath.row > 0 {
            let asset = librairyAssets[indexPath.row - 1]
            cell.pictureView.image = BxInputPictureLibraryItem.imageFromPHAsset(asset, size: CGSize(width: size, height: size))
            if let data = rowData {
                cell.pictureView.contentMode = data.iconMode
                if isUnSelectable(asset) {
                    cell.pictureView.alpha = 0.25
                } else {
                    cell.pictureView.alpha = 1
                }
            }
        }
        cell.setNeedsDisplay()
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let asset = librairyAssets[indexPath.row - 1]
            if isUnSelectable(asset) {
                return
            }
            if let selectHandler = selectHandler,
                let cell = collectionView.cellForItem(at: indexPath) as? BxInputPictureCollectionCell
            {
                let picture = BxInputPictureLibraryItem(asset: asset, iconSize: CGSize(width: size, height: size))
                selectHandler(picture, cell)
            }
        } else {
            openImagePicker()
        }
        
    }

    
}

/// Implementation AVCaptureVideoDataOutputSampleBufferDelegate for BxInputSelectorPicturesLibraryDataSource. This need for showing picture from camera
extension BxInputSelectorPicturesLibraryDataSource : AVCaptureVideoDataOutputSampleBufferDelegate
{
    
    open func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!)
    {
        guard self.currentImageView != nil else {
            return
        }
        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer)
        
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else
        {
            return
        }
        
        guard let quartzImage = context.makeImage() else {
            return
        }
        
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let image = UIImage(cgImage: quartzImage, scale: 1.0, orientation: .right)
        
        DispatchQueue.main.sync {
            if let currentImageView = self.currentImageView {
                currentImageView.image = image
            }
        }
        
    }
    
}

/// Implementation UIImagePickerControllerDelegate, UINavigationControllerDelegate for BxInputSelectorPicturesLibraryDataSource. This need for showing image picker with camera
extension BxInputSelectorPicturesLibraryDataSource : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if let selectHandler = self.selectHandler,
            let cell = self.picturesCollection.cellForItem(at: IndexPath(item: 0, section: 0)) as? BxInputPictureCollectionCell
        {
            let picture = BxInputPictureImageItem(image: image, iconSize: CGSize(width: self.size, height: self.size))
            selectHandler(picture, cell)
        }
        picker.dismiss(animated: true) { [weak self] in
            self?.owner?.activeControl?.becomeFirstResponder()
        }
    }
    
    open func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true) { [weak self] in
            self?.owner?.activeControl?.becomeFirstResponder()
        }
    }
    
}
