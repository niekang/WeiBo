//
//  EmotionPackage.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/28.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class EmotionPackage: BaseModel {
    
//    weak var manager:EmotionManager?
    /// 表情包的分组名
    var groupName: String?
    /// 背景图片名称
    var bgImageName: String?
    
    /// 表情包目录，从目录下加载 info.plist 可以创建表情模型数组
    @objc var directory: String? {
        didSet {
//            manager = EmotionManager.shared;
            // 当设置目录时，从目录下加载 info.plist
            guard let directory = directory,
                let path = Bundle.main.path(forResource: "Emotion.bundle", ofType: nil),
                let bundle = Bundle(path: path),
                let infoPath = bundle.path(forResource:"info.plist", ofType: nil, inDirectory: directory),
                let array = NSArray(contentsOfFile: infoPath) as? [[String: String]] else {
                    return
            }
            
            let models: [Emotion?]? = HttpClient.parseJSONArray(array)
            guard let modelArray = models as? [Emotion] else {
                return
            }
            // 遍历 models 数组，设置每一个表情符号的目录
            for m in modelArray {
                m.directory = directory
            }
            
            // 设置表情模型数组
            emotions += modelArray
        }
    }

    /// 懒加载的表情模型的空数组
    /// 使用懒加载可以避免后续的解包
    lazy var emotions = [Emotion]()

    /// 表情页面数量
    var page: Int {
        return (emotions.count - 1) / 20 + 1
    }
    
    /// page页 对应的所有表情
    ///
    /// - Parameter page: indexPath.row
    func emotions(page:Int) ->[Emotion]{
        //每页的表情数量
        let count = 20
        let location = count * page
        var length = count
        if location + length > emotions.count {
            length = emotions.count - location
        }
        
        let subRange = NSRange(location: location, length: length)
        
        let array = (emotions as NSArray).subarray(with: subRange)
        
        return array as! [Emotion]
    }
}
