//
//  MCollecationCell.swift
//  JFacebookPhotoPicker
//
//  Created by John on 16/8/1.
//  Copyright © 2016年 John. All rights reserved.
//

import UIKit

class MCollectionCell: UICollectionViewCell {
    var imageView:UIImageView?
    var imageLabel:UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imageView?.image=UIImage(named: "add_from_camera")
        self.addSubview(imageView!)
        
        imageLabel = UILabel(frame: CGRect(x: 0, y: 70, width: 80, height: 10))
        self.addSubview(imageLabel!)
    }

    
    func setImage(image:UIImage,index:Int)
    {
        imageView?.image=image
        imageLabel?.text="\(index)"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
