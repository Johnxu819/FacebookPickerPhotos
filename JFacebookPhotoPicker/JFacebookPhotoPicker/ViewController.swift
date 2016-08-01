//
//  ViewController.swift
//  JFacebookPhotoPicker
//
//  Created by John on 16/6/14.
//  Copyright © 2016年 John. All rights reserved.
//



import UIKit
import Photos

class ViewController: UIViewController ,PhotoPickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet weak var collection_view: UICollectionView!
    // the select image max number
    static var imageMaxSelectedNum = 4
    
    // already select total
    static var alreadySelectedImageNum = 0
    
    let screenWidth = UIScreen .mainScreen().bounds.width
    let screenHeight = UIScreen .mainScreen().bounds.height
    let idenContentString = "MCollectionCell"
    
    
    //data
    var images:NSMutableArray=NSMutableArray()
    var cellHeight:CGFloat=80
    var cellWidth:CGFloat=80
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self .makeUICollectionView()
    }
        
    @IBAction func photoPickerClick(sender: AnyObject) {
        self.showLocalPhotoGallery()
        self.automaticallyAdjustsScrollViewInsets = true
        
    }
    
    func makeUICollectionView()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.itemSize = CGSizeMake(cellWidth, cellHeight)
        collection_view.delegate = self
        collection_view.dataSource = self
        collection_view.backgroundColor = UIColor.clearColor()
        collection_view.registerNib(UINib(nibName: idenContentString,bundle: nil), forCellWithReuseIdentifier: idenContentString)
        collection_view.registerClass(MCollectionCell.self, forCellWithReuseIdentifier: "MCollectionCell")
    }
    
    //MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCellWithReuseIdentifier(idenContentString, forIndexPath: indexPath) as! MCollectionCell
        let phasset=self.images[indexPath.row] as!PHAsset
        
        let options:PHImageRequestOptions = PHImageRequestOptions()
        options.deliveryMode = .HighQualityFormat
        options.networkAccessAllowed=true
        
        PHImageManager.defaultManager().requestImageForAsset(phasset, targetSize: CGSize(width: cellWidth,height: cellHeight), contentMode: .AspectFit, options: options, resultHandler: {
        (result,info) in
            if(nil != result){
                cell.setImage(result!, index: indexPath.row)
            }
        })
        
        return cell;
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("tap ==\(indexPath.row)")
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }

    private func showLocalPhotoGallery(){
        print("showLocalPhotoGallery")
        let picker = PhotoCollectionViewController( collectionViewLayout: PhotoCollectionViewController.configCustomCollectionLayout())
        
        let results = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype:PHAssetCollectionSubtype.SmartAlbumUserLibrary , options: nil)
        
        if results.count > 0
        {
            let model = PHAsset.fetchAssetsInAssetCollection(results[0] as! PHAssetCollection, options: PhotoFetchOptions.shareInstance)
            if ( model.count > 0 )
            {
                
                picker.fetchResult = model
            }
        }
        
        picker.modalPresentationStyle = .Popover
        
        //delegate
        picker.imageSelectDelegate=self
        
        // max select number
        PhotoCollectionViewController.imageMaxSelectedNum = 12
        
        // already selected image num
        //let realModel = self.getModelExceptButton()
        //PhotoPickerController.alreadySelectedImageNum = realModel.count
        
        self.navigationController?.pushViewController(picker, animated: true)
   }
    
    
    func onImageSelectFinished(images: [PHAsset]){
        print("onImageSelectFinished \(images.count)")
        self.images=NSMutableArray(array: images)
        self.collection_view.reloadData()
    }
    
    private func showNoPermissionDailog(){
        let alert = UIAlertController.init(title: nil, message: "没有打开相册的权限", preferredStyle: .Alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }


    

}

