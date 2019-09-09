//
//  UIColor+Extension.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/20.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

extension UIColor {
        
    class func rgbColor(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    class func rgbAlphaColor(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)/255), green: CGFloat(arc4random_uniform(256)/255), blue: CGFloat(arc4random_uniform(256)/255), alpha: 1)
    }

    class func hexColor(hex:UInt32) -> UIColor{
        let r = (hex & 0xff0000) >> 16
        let g = (hex & 0x00ff00) >> 8
        let b = hex & 0x0000ff
        return rgbColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b))
    }
    
    class func hexAlphaColor(hex:UInt32, alpha:CGFloat) -> UIColor{
        let r = (hex & 0xff0000) >> 16
        let g = (hex & 0x00ff00) >> 8
        let b = hex & 0x0000ff
        return rgbAlphaColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha:alpha)
    }
    
}
