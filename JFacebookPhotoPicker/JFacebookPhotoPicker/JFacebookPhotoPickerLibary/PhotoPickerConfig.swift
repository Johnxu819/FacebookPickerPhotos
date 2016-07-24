//
//  PhotoPickerConfig.swift
//  PhotoPicker
//
//  Created by Johnxu on 16/3/6.
//  Copyright © 2016年 Johnxu. All rights reserved.
//

import Foundation
import UIKit

class PhotoPickerConfig {
    // tableView Cell height
    static let AlbumTableViewCellHeight: CGFloat = 90.0
    
    // message when select number more than the max number
    static let ErrorImageMaxSelect = "图片选择最多超过不能超过#张"
    
    
    // message when select controller title  text
    static let ClickSelectAllbum = "点击选择相册"

    
    // button confirm title
    static let ButtonConfirmTitle  = "确定"
    
    // button secelt image done title
    static let ButtonDone = "完成"
    
    // preview view bar background color
    static let PreviewBarBackgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
    
    // button green tin color
    static let GreenTinColor = UIColor(red: 7/255, green: 179/255, blue: 20/255, alpha: 1)
    
    
    static let SelectBorderColor = UIColor(red: 93/255, green: 148/255, blue: 251/255, alpha: 1)
    
    // image total per line
    static let ColNumber: CGFloat = 3
    
    // collceiont cell padding
    static let MinimumInteritemSpacing: CGFloat = 5
    
    
    // fethch single large image max width
    static let PreviewImageMaxFetchMaxWidth:CGFloat = 600
    
    
}