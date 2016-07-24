 //
//  PhotoCollectionViewController.swift
//  PhotoPicker
//
//  Created by Johnxu on 16/3/6.
//  Copyright © 2016年 Johnxu. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices
import Photos
 
enum PageType{
    case List
    case RecentAlbum
    case AllAlbum
}
 
 
private let reuseIdentifier = "photoCollectionViewCell"

protocol PhotoCollectionViewControllerDelegate:class {
    func onPreviewPageBack()
}
 
protocol PhotoPickerControllerDelegate: class{
    func onImageSelectFinished(images: [PHAsset])
 }

class PhotoCollectionViewController: UICollectionViewController, PHPhotoLibraryChangeObserver,PhotoCollectionViewCellDelegate,PhotoCollectionViewControllerDelegate,AlbumToolbarViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // the select image max number
    static var imageMaxSelectedNum = 4

    // already select total
    static var alreadySelectedImageNum = 0
    
    var imageSelectDelegate: PhotoPickerControllerDelegate?
    
    let type:PageType=PageType.RecentAlbum

	
    let imageManager = PHCachingImageManager()
	private let toolbarHeight: CGFloat = 34.0
	
	var assetGridThumbnailSize: CGSize?
	var fetchResult: PHFetchResult?
	var previousPreheatRect: CGRect?
    
    var albumsTableView:PhotoAlbumsTableView?
    
    //navigation
    var newNavBar:UINavigationBar?
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        let originFrame = self.collectionView!.frame
        self.collectionView!.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y+44, originFrame.size.width, originFrame.height-44)

        self.configPhotoObserver()
        
		self.collectionView?.contentInset = UIEdgeInsetsMake(
            PhotoPickerConfig.MinimumInteritemSpacing,
            PhotoPickerConfig.MinimumInteritemSpacing,
            PhotoPickerConfig.MinimumInteritemSpacing,
            PhotoPickerConfig.MinimumInteritemSpacing
        )
		
		self.collectionView!.registerNib(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
		
		self.configBackground()
        self.configAlbumTableView()
	}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.styleNavBar()
 
        if assetGridThumbnailSize == nil {
            let scale = UIScreen.mainScreen().scale
            let cellSize = (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
            let size = cellSize.width * scale
            assetGridThumbnailSize = CGSizeMake(size/2, size/2)
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.updateCacheAssets()
    }
    
    
    private func configAlbumTableView(){
        albumsTableView = PhotoAlbumsTableView(frame: CGRect(x: 0, y: self.toolbarHeight, width: self.view.frame.width, height: self.view.frame.height-self.toolbarHeight))
        self.view.addSubview(albumsTableView!)
        self.albumsTableView!.frame.origin = CGPointMake(0, -self.albumsTableView!.frame.height)
        albumsTableView?.photoCollectionViewController=self
        albumsTableView?.hidden=true
    }
    
    private func styleNavBar() {
    self.navigationController?.setNavigationBarHidden(true, animated: false)
   
    if(newNavBar == nil){
    newNavBar = UINavigationBar(frame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0))
        newNavBar!.tintColor=UIColor.blackColor()
        
    let newItem = UINavigationItem()
    newItem.title = "Paths"
        
    let titleView=UILabel()
    let width = self.view.frame.width/2
    titleView.frame=CGRect(x: width-50, y: 0, width: 100, height: 50)
    titleView.backgroundColor=UIColor.clearColor()
    titleView.textColor=UIColor.blackColor()
    titleView.font=UIFont.boldSystemFontOfSize(16)
    titleView.text=PhotoPickerConfig.ClickSelectAllbum
    titleView.userInteractionEnabled=true
    newItem.titleView=titleView
        
    let backButtonImage = UIImage(named: "ic_keyboard_arrow_left")
    let backBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .Plain, target: self, action: #selector(PhotoCollectionViewController.eventCancel))
    newItem.leftBarButtonItem = backBarButtonItem

    let rightBarButtonItem = UIBarButtonItem(title: "完成", style: .Plain, target: self, action: #selector(PhotoCollectionViewController.doneClick))
    newItem.rightBarButtonItem = rightBarButtonItem
        
    newNavBar!.setItems([newItem], animated: false)
        
    let gestureFollow = UITapGestureRecognizer(target: self, action: #selector(showAlbumsList(_:)))
        gestureFollow.numberOfTapsRequired = 1
        
        
    let subviews = newNavBar!.subviews
    subviews[1].addGestureRecognizer(gestureFollow)
    subviews[1].backgroundColor=UIColor.clearColor()
        
    self.view.addSubview(newNavBar!)
    }
    }
    
    func configPhotoObserver()  {
        self.resetCacheAssets()
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
    }
    
    // MARK: - AlbumToolbarViewDelegate
    func onFinishedButtonClicked() {
        print("finishbuttonClcik")
    }
    
    
    // MARK: -  allbumClcik
    func allbumClcik(){
       // print("allbumClcik")
    }
    
    // MARK: -  cancel
    func eventCancel(){
       // print("eventCancel")
        PhotoImage.instance.selectedImage.removeAll()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: -  done
    func doneClick(){
       // print("done")
        if self.imageSelectDelegate != nil
        {
        self.imageSelectDelegate?.onImageSelectFinished(PhotoImage.instance.selectedImage)
        self.navigationController?.popViewControllerAnimated(true)
        }
    }
	
	// MARK: -   image caches
    func resetCacheAssets() {
		self.imageManager.stopCachingImagesForAllAssets()
		self.previousPreheatRect = CGRectZero
	}
	
	func updateCacheAssets() {
		let isViewVisible = self.isViewLoaded() && self.view.window != nil;
		if !isViewVisible { return; }
		
		// The preheat window is twice the height of the visible rect.
		var preheatRect = self.collectionView?.bounds
		if preheatRect != nil {
			preheatRect = CGRectInset(preheatRect!, 0, -0.5 * CGRectGetHeight(preheatRect!)) ;
			
			let delta = abs(CGRectGetMidY(preheatRect!) - CGRectGetMidY(self.previousPreheatRect!))
			
			if (delta > CGRectGetHeight(self.collectionView!.bounds) / 3.0) {
				
				var addedIndexPaths = [NSIndexPath]()
				var removedIndexPaths = [NSIndexPath]()
				self.computeDifferenceBetweenRect(self.previousPreheatRect!, newRect: preheatRect!, removedHandler: { (removedRect) -> Void in
						// somde code
						let indexPaths = self.collectionView!.aapl_indexPathsForElementsInRect(removedRect)
						if indexPaths != nil {
							removedIndexPaths.appendContentsOf(indexPaths!)
						}
					}, addedHandler: { (addedRect) -> Void in
						
						let indexPaths = self.collectionView!.aapl_indexPathsForElementsInRect(addedRect)
						if indexPaths != nil {
							addedIndexPaths.appendContentsOf(indexPaths!)
						}
					})
				
				let assetsToStartCaching = self.assetsAtIndexPaths(addedIndexPaths)
				let assetsToStopCaching = self.assetsAtIndexPaths(removedIndexPaths)
				
				if assetsToStartCaching != nil {
					self.imageManager.startCachingImagesForAssets(assetsToStartCaching!, targetSize: self.assetGridThumbnailSize!, contentMode: .AspectFill, options: nil)
				}
				
				if assetsToStopCaching != nil {
					self.imageManager.stopCachingImagesForAssets(assetsToStopCaching!, targetSize: self.assetGridThumbnailSize!, contentMode: .AspectFill, options: nil)
				}
				
				self.previousPreheatRect = preheatRect;
			}
		}
	}
    
    // MARK: -  PhotoCollectionViewCellDelegate
    func eventSelectNumberChange(number: Int) {
        
    }
    
	override func scrollViewDidScroll(scrollView: UIScrollView) {
		self.updateCacheAssets()
	}
	
	func assetsAtIndexPaths(indexPaths: [NSIndexPath]) -> [PHAsset]? {
		if indexPaths.count == 0 { return nil; }
		var assets = [PHAsset]()
		for indexPath in indexPaths {
			if let asset = self.fetchResult![indexPath.item] as? PHAsset {
				assets.append(asset)
			}
		}
		return assets;
	}
	
	func computeDifferenceBetweenRect(oldRect: CGRect, newRect: CGRect, removedHandler: (CGRect) -> Void, addedHandler: (CGRect) -> Void) {
		
		if CGRectIntersectsRect(newRect, oldRect) {
			let oldMaxY = CGRectGetMaxY(oldRect)
			let oldMinY = CGRectGetMaxX(oldRect)
			let newMaxY = CGRectGetMaxY(newRect) ;
			let newMinY = CGRectGetMinY(newRect) ;
			
			if newMaxY > oldMaxY {
				let rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY))
				addedHandler(rectToAdd)
			}
			
			if oldMinY > newMinY {
				let rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY))
				addedHandler(rectToAdd)
			}
			
			if newMaxY < oldMaxY {
				let rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY))
				removedHandler(rectToRemove)
			}
			
			if oldMinY < newMinY {
				let rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY))
				removedHandler(rectToRemove)
			}
		} else {
			addedHandler(newRect) ;
			removedHandler(oldRect) ;
		}
	}
	
	deinit {
		PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
	}
	
	func photoLibraryDidChange(changeInstance: PHChange) {
		if let collectionChanges = changeInstance.changeDetailsForFetchResult(self.fetchResult!) {
			
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
					
					self.fetchResult = collectionChanges.fetchResultAfterChanges
					let collectionView = self.collectionView!;
					
					if !(collectionChanges.hasIncrementalChanges || collectionChanges.hasMoves) {
						collectionView.reloadData()
					} else {
						collectionView.performBatchUpdates({ () -> Void in
								if let removedIndexes = collectionChanges.removedIndexes {
									
									if removedIndexes.count > 0 {
										collectionView.deleteItemsAtIndexPaths(removedIndexes.aapl_indexPathsFromIndexesWithSection(0))
									}
								}
								
								if let insertedIndexes = collectionChanges.insertedIndexes {
									if insertedIndexes.count > 0 {
										collectionView.insertItemsAtIndexPaths(insertedIndexes.aapl_indexPathsFromIndexesWithSection(0))
									}
								}
							}, completion: nil)
					}
					
					self.resetCacheAssets()
				})
		}
	}
	
	private func configBackground() {
		self.collectionView?.backgroundColor = UIColor.whiteColor()
	}
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	class func configCustomCollectionLayout() -> UICollectionViewFlowLayout {
		let collectionLayout = UICollectionViewFlowLayout()
		
		let width = UIScreen.mainScreen().bounds.width - PhotoPickerConfig.MinimumInteritemSpacing * 2
		collectionLayout.minimumInteritemSpacing = PhotoPickerConfig.MinimumInteritemSpacing
		
		let cellToUsableWidth = width - (PhotoPickerConfig.ColNumber - 1) * PhotoPickerConfig.MinimumInteritemSpacing
		let size = cellToUsableWidth / PhotoPickerConfig.ColNumber
		collectionLayout.itemSize = CGSizeMake(size, size)
		collectionLayout.minimumLineSpacing = PhotoPickerConfig.MinimumInteritemSpacing
		return collectionLayout
	}
	
	// MARK: -  UICollectionView delegate
	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.fetchResult != nil ? self.fetchResult!.count : 0
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! photoCollectionViewCell
		
		cell.delegate = self;
        cell.eventDelegate = self
        cell.thumbnail.tag=indexPath.row
        print(indexPath.row)
        
        if(indexPath.row==0){
            cell.thumbnail.image = UIImage(named: "add_from_camera")
            return cell
        }
		
		if let asset = self.fetchResult![indexPath.row] as? PHAsset
        {
			cell.model = asset
			cell.representedAssetIdentifier = asset.localIdentifier
			self.imageManager.requestImageForAsset(asset, targetSize: self.assetGridThumbnailSize!, contentMode: .AspectFill, options: nil) { (image, info) -> Void in
				if cell.representedAssetIdentifier == asset.localIdentifier {
					cell.thumbnail.image = image
				}
			}
            cell.updateSelected(PhotoImage.instance.selectedImage.indexOf(asset) != nil)
		}
		return cell
	}
	
	// MARK: UICollectionViewDelegate
	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.switchToPreView(indexPath.row)
	}
    
    func switchToPreView(index:Int){
        let previewController = PhotoPreviewViewController(nibName: nil, bundle: nil)
        previewController.allSelectImage = self.fetchResult
        previewController.currentPage = index
        previewController.fromDelegate = self
        self.navigationController?.showViewController(previewController, sender: nil)
    
    }
    
    func onPreviewPageBack() {
        
    }
    
    
    func switchToCamera()  {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true,
                                       completion: nil)
        }
    }
    
    
    // MARK: back went camera take a photo
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        if(mediaType==kUTTypeImage as String){
            let image = info[UIImagePickerControllerOriginalImage]as! UIImage
            print(image.accessibilityElementCount())
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(PhotoCollectionViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    
    }
    
    // MARK: save failed
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                                       completion: nil)
        }
    }
    
    
    func showAlbumsList(gestureRecognizer:UIGestureRecognizer)  {
        self.switchAlbums()

   }
 
   func  switchAlbums() {
    if((albumsTableView?.hidden)==true){
        self.albumsTableView!.frame.origin = CGPointMake(0, -100)
        print("x:\(self.albumsTableView!.frame.origin.x) y:\(self.albumsTableView!.frame.origin.y)")
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.albumsTableView!.frame.origin =  CGPointMake(0,24)
            }, completion: { (isFinished) -> Void in
                self.albumsTableView?.hidden=false
        })
        
    }else{
        UIView.animateWithDuration(1.5, delay: 0, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
            self.albumsTableView!.frame.origin = CGPointMake(0, -self.albumsTableView!.frame.height)
            }, completion: { (isFinished) -> Void in
                self.albumsTableView?.hidden=true
        })
    }
    }
 }
 // MARK: -  cancel
