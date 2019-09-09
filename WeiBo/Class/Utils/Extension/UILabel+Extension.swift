
//
//  UILab+Extension.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/20.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit


extension UILabel {
    
    @discardableResult
    func text(_ text:String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func fontSize(_ fontSize:CGFloat) -> Self {
        font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func textColor(_ textColor:UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment:NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    
    @discardableResult
    func numberOfLines(_ numberOfLines:Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    @discardableResult
    func backgroundColor(_ backgroundColor:UIColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }
}
