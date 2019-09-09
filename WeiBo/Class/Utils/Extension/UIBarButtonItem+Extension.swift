//
//  UIBarButtonItem+Extension.swift
//  WeiBo
//
//  Created by 聂康 on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init (title:String,
                      fontSize:CGFloat = 16,
                      target:AnyObject,
                      action:Selector){
        
        let btn = UIButton().title(title).fontSize(fontSize).textColor(UIColor.darkGray).highlightTextColor(UIColor.orange).action( target,action)
        btn.sizeToFit()
        self.init(customView: btn)
    }
    
    convenience init (imageName:String, target:Any, action:Selector){
        let btn = UIButton().image(imageName).action(target, action)
        btn.sizeToFit()
        self.init(customView: btn)
    }
}
