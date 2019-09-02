//
//  UIImageView+Extension.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/22.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import SDWebImage

extension UIImageView {
    
    func nk_setImage(URLString:String?, placeholderImageName:String?, isAvatar:Bool = false) {

        guard let URLString = URLString, let url = URL(string: URLString) else {
            return
        }
        
        var placeholderImage:UIImage?
        
        if let placeholderImageName = placeholderImageName {
            placeholderImage = UIImage(named: placeholderImageName)
        }
        
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) { (image, _, _, _) in
            
            if isAvatar == true {
                self.image = image?.avatarImage()
            }
        }
    }
}
