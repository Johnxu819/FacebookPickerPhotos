//
//  PhotoImageSelected.swift
//  PhotoPicker
//
//  Created by Johnxu on 16/3/9.
//  Copyright © 2016年 Johnxu. All rights reserved.
//

import Foundation
import Photos

class PhotoImage {
    
    // singleton
    static let instance = PhotoImage()
    private init(){}
    
    var selectedImage = [PHAsset]()
    
}