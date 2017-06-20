//
//  UIButton+Extension.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

extension UIButton {
    
    func nk_title(_ title:String) -> Self {
        setTitle(title, for: .normal)
        return self
    }
    
    func nk_fontSize(_ fontSize:CGFloat) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    func nk_textColor(_ textColor:UIColor) -> Self {
        setTitleColor(textColor, for: .normal)
        return self
    }
    
    func nk_highlightTextColor(_ highlightTextColor:UIColor) -> Self {
        setTitleColor(highlightTextColor, for: .normal)
        return self
    }
    
    func nk_image(_ imageName:String) -> Self {
        if let image = UIImage(named: imageName) {
            setImage(image, for: .normal)
            if let highLightedImage = UIImage(named: imageName + "_highlighted") {
                setImage(highLightedImage, for: .highlighted)
            }
        }
        return self
    }
    
    func nk_backgroudColor(_ backgroundColor:UIColor) -> Self{
        self.backgroundColor = backgroundColor
        return self
    }
    
    func nk_backgroundImage(_ backgroundImageName:String) -> Self {
       if let backgroundImage = UIImage(named:backgroundImageName) {
            setBackgroundImage(backgroundImage, for: .normal)
            if let highLightedBackgroudImage = UIImage(named: backgroundImageName + "_highlighted") {
                setBackgroundImage(highLightedBackgroudImage, for: .highlighted)
            }
        }
        return self
    }
    
    func nk_action(_ target:Any, _ action:Selector) -> Self{
        addTarget(target, action: action, for: .touchUpInside)
        return self
    }
    
}
