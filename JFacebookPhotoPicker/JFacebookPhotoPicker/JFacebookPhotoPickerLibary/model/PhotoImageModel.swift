//
//  ImageModel.swift
//  PhotoPicker
//
//  Created by Johnxu on 16/3/11.
//  Copyright © 2016年 Johnxu. All rights reserved.
//

import Foundation
import Photos

enum ModelType{
    case Button
    case Image
}

struct PhotoImageModel {
    var type: ModelType?
    var data: PHAsset?
    
    init(type: ModelType?,data:PHAsset?){
        self.type = type
        self.data = data
    }
}