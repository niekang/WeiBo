//
//  WBStatus.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBStatusData: BaseModel {
    var statuses: [WBStatus]?
}

class WBStatus: BaseModel {
    /// Int 类型，在 64 位的机器是 64 位，在 32 位机器就是 32 位
    /// 如果不写 Int64 在 iPad 2/iPhone 5/5c/4s/4 都无法正常运行
    var id: Int64 = 0
    /// 微博信息内容
    var text: String?
    
    /// 微博创建时间字符串
    var created_at: String?
    
    /// 微博创建日期
    var createdDate: Date?
    
    /// 微博来源 - 发布微博使用的客户端
    var source: String? {
        didSet {
            source = "来自于 " + (source?.wb_htmlHref()?.text ?? "")
        }
    }
    
    /// 转发数
    var reposts_count: Int = 0
    /// 评论数
    var comments_count: Int = 0
    /// 点赞数
    var attitudes_count: Int = 0
    
    /// 微博的用户 - 注意和服务器返回的 KEY 要一致
    var user: WBUser?
    
    /// 被转发的原创微博
    var retweeted_status: WBStatus?
    
    /// 微博配图模型数组
    var pic_urls: [WBStatusPicture]?
    
}
