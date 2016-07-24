//
//  PhotoPreviewToolbarView.swift
//  PhotoPicker
//
//  Created by Johnxu on 16/3/9.
//  Copyright © 2016年 Johnxu. All rights reserved.
//

import UIKit

protocol PhotoPreviewToolbarViewDelegate: class {
    func onToolbarBackArrowClicked();
    func onSelected(select:Bool)
}

class PhotoPreviewToolbarView: UIView {
    
    weak var delegate: PhotoPreviewToolbarViewDelegate?
    weak var sourceDelegate: PhotoPreviewViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configView()
    }
    
    private func configView(){
        //self.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        self.backgroundColor=UIColor.whiteColor()
        // back arrow buttton
        let backArrow = UIButton(frame: CGRectMake(5,10,40,40))
        let backArrowImage = UIImage(named: "ic_keyboard_arrow_left")
        backArrow.setImage(backArrowImage, forState: UIControlState.Normal)
        backArrow.addTarget(self, action: #selector(PhotoPreviewToolbarView.eventBackArrow), forControlEvents: .TouchUpInside)
        self.addSubview(backArrow)
        

    }
    
    // MARK: -  Event
    func eventBackArrow(){
        if let delegate = self.delegate {
            delegate.onToolbarBackArrowClicked()
        }
    }
    
}
