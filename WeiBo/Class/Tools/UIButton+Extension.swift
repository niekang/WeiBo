//
//  UIButton+Extension.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

extension UIButton {
    
    class func nk_textButton(title:String?, fontSize:CGFloat?) -> UIButton{
        return UIButton.nk_Button(title: title, fontSize: fontSize, normalTextColor: nil, highLightedTextColor: nil, normalImage: nil, highLightedImage: nil, normalBackgroudImage: nil, highLightedBackgroudImage: nil)
        
    }
    
    class func nk_textButton(title:String?, fontSize:CGFloat?, normalTextColor:UIColor?, highLightedTextColor:UIColor?) -> UIButton{
        return UIButton.nk_Button(title: title, fontSize: fontSize, normalTextColor: normalTextColor, highLightedTextColor: highLightedTextColor, normalImage: nil, highLightedImage: nil, normalBackgroudImage: nil, highLightedBackgroudImage: nil)
        
    }
    
    class func nk_imageButton(normalImage:UIImage?) -> UIButton{
        return UIButton.nk_Button(title: nil, fontSize: nil, normalTextColor: nil, highLightedTextColor: nil, normalImage: normalImage, highLightedImage: nil, normalBackgroudImage: nil, highLightedBackgroudImage: nil)
    }
    
    class func nk_imageButton(normalImage:UIImage?, highLightedImage:UIImage?) -> UIButton{
        return UIButton.nk_Button(title: nil, fontSize: nil, normalTextColor: nil, highLightedTextColor: nil, normalImage: normalImage, highLightedImage: highLightedImage, normalBackgroudImage: nil, highLightedBackgroudImage: nil)
    }
    
    class func nk_imageButton(normalImage:UIImage?, normalBackgroudImage:UIImage?) -> UIButton{
        return UIButton.nk_Button(title: nil, fontSize: nil, normalTextColor: nil, highLightedTextColor: nil, normalImage: normalImage, highLightedImage: nil, normalBackgroudImage: normalBackgroudImage, highLightedBackgroudImage: nil)
    }
    
    class func nk_imageButton(normalImage:UIImage?, normalBackgroudImage:UIImage?, highLightedBackgroudImage:UIImage?) -> UIButton{
        return UIButton.nk_Button(title: nil, fontSize: nil, normalTextColor: nil, highLightedTextColor: nil, normalImage: normalImage, highLightedImage: nil, normalBackgroudImage: normalBackgroudImage, highLightedBackgroudImage: highLightedBackgroudImage)
    }
    
    class func nk_imageButton(normalImage:UIImage?, highLightedImage:UIImage?, normalBackgroudImage:UIImage?, highLightedBackgroudImage:UIImage?) -> UIButton{
        return UIButton.nk_Button(title: nil, fontSize: nil, normalTextColor: nil, highLightedTextColor: nil, normalImage: normalImage, highLightedImage: highLightedImage, normalBackgroudImage: normalBackgroudImage, highLightedBackgroudImage: highLightedBackgroudImage)
    }
    
    class func nk_Button(title:String?, fontSize:CGFloat?, normalTextColor:UIColor?, highLightedTextColor:UIColor?, normalImage:UIImage?, highLightedImage:UIImage?, normalBackgroudImage:UIImage?, highLightedBackgroudImage:UIImage?) -> UIButton{
        
        let btn = UIButton(type:.custom)
        
        if let title = title {
            btn.setTitle(title, for: .normal)
        }
        if let fontSize = fontSize {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
        
        if let normalTextColor = normalTextColor {
            btn.setTitleColor(normalTextColor, for: .normal)
        }
        
        if let highLightedTextColor = highLightedTextColor {
            btn.setTitleColor(highLightedTextColor, for: .highlighted)
        }
        
        if let normalImage = normalImage {
            btn.setImage(normalImage, for: .normal)
        }
        
        if let highLightedImage = highLightedImage {
            btn.setImage(highLightedImage, for: .highlighted)
        }
        
        if let normalBackgroudImage = normalBackgroudImage {
            btn.setBackgroundImage(normalBackgroudImage, for: .normal)
        }
        
        if let highLightedBackgroudImage = highLightedBackgroudImage {
            btn.setBackgroundImage(highLightedBackgroudImage, for: .highlighted)
        }

        
        return btn
    }
    
}
