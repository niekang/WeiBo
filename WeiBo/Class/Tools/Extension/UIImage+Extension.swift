//
//  UIImage+Extension.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/22.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    /// 圆角图片
    ///
    /// - Parameters:
    ///   - targetSize: 图片目标大小
    ///   - backgroundColor: 图片背景
    ///   - lineColor: 图片边框颜色
    /// - Returns: 画好的图片
    func avatarImage(targetSize:CGSize = CGSize.zero, backgroundColor:UIColor? = UIColor.white, lineColor:UIColor? = UIColor.lightGray) -> UIImage?{

        var targetSize = targetSize
        
        if targetSize == CGSize.zero {
            targetSize = size
        }
        
        let rect = CGRect(origin: CGPoint.zero, size: targetSize)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        if let backgroundColor = backgroundColor {
            backgroundColor.setFill()
            UIRectFill(rect)
        }
        
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        draw(in: rect)
        
        if let lineColor =  lineColor {
            let ovalPath = UIBezierPath(ovalIn: rect)
            ovalPath.lineWidth = 2
            lineColor.setStroke()
            ovalPath.stroke()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
