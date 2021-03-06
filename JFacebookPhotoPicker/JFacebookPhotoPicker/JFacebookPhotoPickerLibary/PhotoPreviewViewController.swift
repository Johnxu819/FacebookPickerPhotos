//
//  PhotoPreviewViewController.swift
//  PhotoPicker
//
//  Created by Johnxu on 16/3/8.
//  Copyright © 2016年 Johnxu. All rights reserved.
//

import UIKit
import Photos


class PhotoPreviewViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,PhotoPreviewToolbarViewDelegate,PhotoPreviewCellDelegate {

    var allSelectImage: PHFetchResult?
    var collectionView: UICollectionView?
    var currentPage: Int = 1
    
    let cellIdentifier = "PhotoPreviewCell"
    weak var fromDelegate: PhotoCollectionViewControllerDelegate?
    
    private var toolbar: PhotoPreviewToolbarView?
    
    private var isAnimation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configCollectionView()
        self.configToolbar()
        self.styleNavBar()
    }
    
    private func styleNavBar() {
        self.navigationController!.navigationBar.barTintColor=UIColor.whiteColor().colorWithAlphaComponent(1)
        
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: UIColor.blackColor(), forKey: NSForegroundColorAttributeName)
        self.navigationController!.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
        let left_button=UIButton(frame: CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: 32,height: 32)))
        left_button.setImage(UIImage(named:"ic_keyboard_arrow_left"), forState: UIControlState.Normal)
        left_button.addTarget(self,action:#selector(PhotoCollectionViewController.eventCancel),forControlEvents:.TouchUpInside)
        
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = left_button
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    // MARK: -  cancel
    func eventCancel(){
        // print("eventCancel")
        PhotoImage.instance.selectedImage.removeAll()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    private func configToolbar(){
        self.toolbar = PhotoPreviewToolbarView(frame: CGRectMake(0, 0, self.view.bounds.width, 50))
        self.toolbar?.delegate = self
        self.toolbar?.sourceDelegate = self
        self.view.addSubview(toolbar!)
    }
    
    // MARK: -  from page delegate 
    func onToolbarBackArrowClicked() {
        self.navigationController?.popViewControllerAnimated(true)
        if let delegate = self.fromDelegate {
            delegate.onPreviewPageBack()
        }
    }
    
    func onSelected(select: Bool) {
        let currentModel = self.allSelectImage![self.currentPage]
        if select {
            PhotoImage.instance.selectedImage.append(currentModel as! PHAsset)
        } else {
            if let index = PhotoImage.instance.selectedImage.indexOf(currentModel as! PHAsset){
                PhotoImage.instance.selectedImage.removeAtIndex(index)
            }
        }
       // self.bottomBar?.changeNumber(PhotoImage.instance.selectedImage.count, animation: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // fullscreen controller
        //self.navigationController?.navigationBarHidden = true
        //UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .None)
        
        self.collectionView?.setContentOffset(CGPointMake(CGFloat(self.currentPage) * self.view.bounds.width, 0), animated: false)
        
        self.changeCurrentToolbar()
    }
    
    func configCollectionView(){
        self.automaticallyAdjustsScrollViewInsets = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSizeMake(self.view.frame.width,self.view.frame.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView!.backgroundColor = UIColor.lightGrayColor()
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.pagingEnabled = true
        self.collectionView!.scrollsToTop = false
        self.collectionView!.showsHorizontalScrollIndicator = false
        self.collectionView!.contentOffset = CGPointMake(0, 0)
        self.collectionView!.contentSize = CGSizeMake(self.view.bounds.width * CGFloat(self.allSelectImage!.count), self.view.bounds.height)
        
        self.view.addSubview(self.collectionView!)
        self.collectionView!.registerClass(PhotoPreviewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
    }
    
    // MARK: -  collectionView dataSource delagate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allSelectImage!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! PhotoPreviewCell
        cell.delegate = self
        if let asset = self.allSelectImage![indexPath.row] as? PHAsset {
            cell.renderModel(asset)
        }
        
        return cell
    }
    
    // MARK: -  Photo Preview Cell Delegate
    func onImageSingleTap() {
        if self.isAnimation {
            return
        }
        
        self.isAnimation = true
        if self.toolbar!.frame.origin.y < 0 {
            UIView.animateWithDuration(0.3, delay: 0, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                self.toolbar!.frame.origin = CGPointMake(0, 0)
                }, completion: { (isFinished) -> Void in
                    if isFinished {
                        self.isAnimation = false
                    }
            })
        } else {
            UIView.animateWithDuration(0.3, delay: 0, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                self.toolbar!.frame.origin = CGPointMake(0, -self.toolbar!.frame.height)
                }, completion: { (isFinished) -> Void in
                    if isFinished {
                        self.isAnimation = false
                    }
            })
        }
        
    }
    
    
    // MARK: -  scroll page
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        self.currentPage = Int(offset.x / self.view.bounds.width)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.changeCurrentToolbar()
    }
    
    private func changeCurrentToolbar(){

    }
    
}
