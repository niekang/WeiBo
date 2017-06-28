
//
//  EmotionManager.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/28.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class EmotionManager {
    
    /// 表情管理单例
    static let shared = EmotionManager()
    
    ///表情包
    lazy var packages = [EmotionPackage]()
    
    /// 私有init方法 禁止init访问
    private init() {
        loadEmotions()
    }
    
    /// 加载表情数据
    func loadEmotions() {
        // 读取 emoticons.plist
        // 只要按照 Bundle 默认的目录结构设定，就可以直接读取 Resources 目录下的文件
        guard let path = Bundle.main.path(forResource: "Emotion.bundle", ofType: nil),
            let bundle = Bundle(path: path),
            let plistPath = bundle.path(forResource:"emotions.plist", ofType:nil),
            let array = NSArray(contentsOfFile: plistPath) as? [[String: String]],
            let models = NSArray.yy_modelArray(with: EmotionPackage.self, json: array) as? [EmotionPackage] else {
            return
        }
        
        // 设置表情包数据
        // 使用 += 不需要再次给 packages 分配空间，直接追加数据
        packages += models
     
        WBLog(packages)
    }

}
