//
//  EmotionPackage.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/28.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class EmotionPackage:NSObject {
    
    /// 表情包的分组名
    var groupName: String?
    /// 背景图片名称
    var bgImageName: String?
    
    /// 表情包目录，从目录下加载 info.plist 可以创建表情模型数组
    var directory: String? {
        didSet {
            // 当设置目录时，从目录下加载 info.plist
            guard let directory = directory,
                let path = Bundle.main.path(forResource: "Emotion.bundle", ofType: nil),
                let bundle = Bundle(path: path),
                let infoPath = bundle.path(forResource:"info.plist", ofType: nil, inDirectory: directory),
                let array = NSArray(contentsOfFile: infoPath) as? [[String: String]],
                let models = NSArray.yy_modelArray(with: Emotion.self, json: array) as? [Emotion] else {
                    return
            }
            
            // 遍历 models 数组，设置每一个表情符号的目录
            for m in models {
                m.directory = directory
            }
            
            // 设置表情模型数组
            emotions += models
        }
    }

    /// 懒加载的表情模型的空数组
    /// 使用懒加载可以避免后续的解包
    lazy var emotions = [Emotion]()

}
