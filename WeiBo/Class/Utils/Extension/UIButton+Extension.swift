//
//  UIButton+Extension.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

extension UIButton {
    
    @discardableResult
    func nk_title(_ title:String) -> Self {
        setTitle(title, for: .normal)
        return self
    }
    
    @discardableResult
    func nk_fontSize(_ fontSize:CGFloat) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func nk_textColor(_ textColor:UIColor) -> Self {
        setTitleColor(textColor, for: .normal)
        return self
    }
    
    @discardableResult
    func nk_highlightTextColor(_ highlightTextColor:UIColor) -> Self {
        setTitleColor(highlightTextColor, for: .normal)
        return self
    }
    
    @discardableResult
    func nk_image(_ imageName:String) -> Self {
        if let image = UIImage(named: imageName) {
            setImage(image, for: .normal)
            if let highLightedImage = UIImage(named: imageName + "_highlighted") {
                setImage(highLightedImage, for: .highlighted)
            }
        }
        return self
    }
    
    @discardableResult
    func nk_backgroudColor(_ backgroundColor:UIColor) -> Self{
        self.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    func nk_backgroundImage(_ backgroundImageName:String) -> Self {
       if let backgroundImage = UIImage(named:backgroundImageName) {
            setBackgroundImage(backgroundImage, for: .normal)
            if let highLightedBackgroudImage = UIImage(named: backgroundImageName + "_highlighted") {
                setBackgroundImage(highLightedBackgroudImage, for: .highlighted)
            }
        }
        return self
    }
    
    @discardableResult
    func nk_action(_ target:Any, _ action:Selector) -> Self{
        addTarget(target, action: action, for: .touchUpInside)
        return self
    }
    
}
