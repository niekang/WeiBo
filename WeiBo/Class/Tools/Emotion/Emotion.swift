
//
//  Emotion.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/28.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class Emotion: NSObject {

    /// 表情类型 false - 图片表情 / true - emoji
    var type = false
    /// 表情字符串，发送给新浪微博的服务器(节约流量)
    var chs: String?
    /// 表情图片名称，用于本地图文混排
    var png: String?
    /// emoji 的十六进制编码
    var code: String?
    /// 表情使用次数
    var times: Int = 0
    /// emoji 的字符串
    var emoji: String?
    
    /// 表情模型所在的目录
    var directory: String?
    
    /// `图片`表情对应的图像
    var image: UIImage? {
        
        // 判断表情类型
        if type {
            return nil
        }
        
        guard let directory = directory,
            let png = png,
            let path = Bundle.main.path(forResource: "Emotion.bundle", ofType: nil),
            let bundle = Bundle(path: path) else {
                return nil
        }
        
        return UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
    }
    
    override var description: String {
        return yy_modelDescription()
    }

}
