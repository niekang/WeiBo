
//
//  UILab+Extension.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/20.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

extension UILabel {
    
    func nk_text(_ text:String) -> Self {
        self.text = text
        return self
    }
    
    func nk_fontSize(_ fontSize:CGFloat) -> Self {
        font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    func nk_textColor(_ textColor:UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    func nk_textAlignment(_ textAlignment:NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    func nk_backgroundColor(_ backgroundColor:UIColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }
}
