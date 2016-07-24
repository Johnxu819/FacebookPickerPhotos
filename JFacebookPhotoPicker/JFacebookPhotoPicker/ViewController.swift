//
//  ViewController.swift
//  JFacebookPhotoPicker
//
//  Created by John on 16/6/14.
//  Copyright © 2016年 John. All rights reserved.
//



import UIKit
import Photos

class ViewController: UIViewController ,PhotoPickerControllerDelegate{
    
    // the select image max number
    static var imageMaxSelectedNum = 4
    
    // already select total
    static var alreadySelectedImageNum = 0
    
    @IBAction func photoPickerClick(sender: AnyObject) {
        self.showLocalPhotoGallery()
        
//        PHPhotoLibrary.requestAuthorization { (status) -> Void in
//            switch status {
//            case .Authorized:
//                self.showLocalPhotoGallery()
//                break
//            default:
//                self.showNoPermissionDailog()
//                break
//            }
//        }
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
    
    }
    
    private func showNoPermissionDailog(){
        let alert = UIAlertController.init(title: nil, message: "没有打开相册的权限", preferredStyle: .Alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

