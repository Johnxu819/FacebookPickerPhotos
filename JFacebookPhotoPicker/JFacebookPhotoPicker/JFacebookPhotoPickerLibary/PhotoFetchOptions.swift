//
//  PhotoFetchOptions.swift
//  PhotoPicker
//
//  Created by Johnxu on 16/3/11.
//  Copyright © 2016年 Johnxu. All rights reserved.
//

import UIKit
import Photos

class PhotoFetchOptions: PHFetchOptions {
    static let shareInstance: PhotoFetchOptions = PhotoFetchOptions()
    private override init() {
        super.init()
        self.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.Image.rawValue)
        self.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    }
}
