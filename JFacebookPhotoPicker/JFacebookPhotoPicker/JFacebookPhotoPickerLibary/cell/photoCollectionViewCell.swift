//
//  photoCollectionViewCell.swift
//  PhotoPicker
//
//  Created by Johnxu on 16/3/6.
//  Copyright © 2016年 Johnxu. All rights reserved.
//

import UIKit
import Photos
protocol PhotoCollectionViewCellDelegate: class {
    func eventSelectNumberChange(number: Int);
    
}
class photoCollectionViewCell: UICollectionViewCell {
	
    @IBOutlet weak var add_btn: UIButton!
	@IBOutlet weak var thumbnail: UIImageView!
    
	weak var delegate: PhotoCollectionViewController?
    weak var eventDelegate: PhotoCollectionViewCellDelegate?
	
	var representedAssetIdentifier: String?
	var model : PHAsset?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.thumbnail.contentMode = .ScaleAspectFill
		self.thumbnail.clipsToBounds = true
        self.initLongPressGesture()
	}
    
    func updateSelected(select:Bool){
        if select {
            thumbnail.layer.borderColor=PhotoPickerConfig.SelectBorderColor.CGColor
            thumbnail.layer.borderWidth=5
        } else {
            thumbnail.layer.borderWidth=0
        }
    }
    
    
    func initLongPressGesture()  {
        let gesture=UILongPressGestureRecognizer(target: self, action:#selector(btnLong(_:)))
        add_btn.addGestureRecognizer(gesture)
    }
    
    func btnLong(gestureRecognizer:UILongPressGestureRecognizer ){
        if delegate != nil{
            
            if(gestureRecognizer.state == UIGestureRecognizerState.Began){
                if(thumbnail.tag==0){
                    if delegate != nil{
                        delegate?.switchToCamera()
                    }
                    return
                }
                
                delegate?.switchToPreView(thumbnail.tag)
            }
        }    
    }
	
	@IBAction func eventImageSelect(sender: UIButton)
    {
        if(thumbnail.tag==0){
            if delegate != nil{
                delegate?.switchToCamera()
            }
           return
        }
        
		if sender.selected {
            thumbnail.layer.borderWidth=0
			sender.selected = false
			if delegate != nil {
				if let index = PhotoImage.instance.selectedImage.indexOf(self.model!) {
					PhotoImage.instance.selectedImage.removeAtIndex(index)
				}
                
                if self.eventDelegate != nil {
                    self.eventDelegate!.eventSelectNumberChange(PhotoImage.instance.selectedImage.count)
                }
			}
		} else {
			
			if delegate != nil {
                sender.selected = true
				if PhotoImage.instance.selectedImage.count >= PhotoCollectionViewController.imageMaxSelectedNum - PhotoCollectionViewController.alreadySelectedImageNum {
					self.showSelectErrorDialog() ;
					return;
				} else {
					PhotoImage.instance.selectedImage.append(self.model!)
                    if self.eventDelegate != nil {
                    self.eventDelegate!.eventSelectNumberChange(PhotoImage.instance.selectedImage.count)
                    }
				}
			}
            thumbnail.layer.borderColor=PhotoPickerConfig.SelectBorderColor.CGColor
            thumbnail.layer.borderWidth=5
            thumbnail.transform = CGAffineTransformMakeScale(0.98, 0.98)
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                self.thumbnail.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: nil)
		}
	}
	
	private func showSelectErrorDialog() {
		if self.delegate != nil {
            let less = PhotoCollectionViewController.imageMaxSelectedNum - PhotoCollectionViewController.alreadySelectedImageNum
            
            let range = PhotoPickerConfig.ErrorImageMaxSelect.rangeOfString("#")
            var error = PhotoPickerConfig.ErrorImageMaxSelect
            error.replaceRange(range!, with: String(less))
            
			let alert = UIAlertController.init(title: nil, message: error, preferredStyle: UIAlertControllerStyle.Alert)
			let confirmAction = UIAlertAction(title: PhotoPickerConfig.ButtonConfirmTitle, style: .Default, handler: nil)
			alert.addAction(confirmAction)
			self.delegate?.presentViewController(alert, animated: true, completion: nil)
		}
	}
}
