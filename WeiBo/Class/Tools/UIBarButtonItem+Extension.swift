//
//  UIBarButtonItem+Extension.swift
//  WeiBo
//
//  Created by 聂康 on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init (title:String, fontSize:CGFloat = 16, target:AnyObject?, action:Selector){
        let btn = UIButton.nk_textButton(title: title, fontSize: fontSize, normalTextColor: UIColor.darkGray, highLightedTextColor: UIColor.orange)
        btn.sizeToFit()
        self.init(customView: btn)
    }
}
