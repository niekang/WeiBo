//
//  WBStatusViewModel.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBStatusViewModel:CustomStringConvertible{
    
    var status:WBStatus
    //会员图标 (内存换CPU)
    var memberIcon:UIImage?
    //认证图标
    var vipIcon:UIImage?
    
    /// 转发文字
    var retweetedStr: String?
    /// 评论文字
    var commentStr: String?
    /// 点赞文字
    var likeStr: String?
    
    /// 配图视图大小
    var pictureViewSize = CGSize()
    
    /// 如果是被转发的微博，原创微博一定没有图
    var picURLs: [WBStatusPicture]? {
        // 如果有被转发的微博，返回被转发微博的配图
        // 如果没有被转发的微博，返回原创微博的配图
        // 如果都没有，返回 nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    /// 微博正文的属性文本
    var statusAttrText: NSAttributedString?
    /// 转发文字的属性文本
    var retweetedAttrText: NSAttributedString?

    
    init(status:WBStatus) {
        
        self.status = status
        
        // 计算会员图标/会员等级 0-6
        if (status.user?.mbrank)! > 0 && (status.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(status.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        // 计算认证图标
        switch status.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2,3,5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }
        
        // 设置底部计数字符串
        // 测试超过一万的数字
        // model.reposts_count = Int(arc4random_uniform(100000))
        retweetedStr = countString(count: status.reposts_count, defaultStr: "转发")
        commentStr = countString(count: status.comments_count, defaultStr: "评论")
        likeStr = countString(count: status.attitudes_count, defaultStr: "赞")

        //配图

        
    }
    
    var description: String {
        return status.description
    }

}

fileprivate extension WBStatusViewModel {
    /**
     如果数量 == 0，显示默认标题
     如果数量超过 10000，显示 x.xx 万
     如果数量 < 10000，显示实际数字
     */

    /// 根据数据返回对应的描述结果
    ///
    /// - parameter count:      数量
    /// - parameter defaultStr: 默认字符串，转发／评论／赞
    ///
    /// - returns: 应该显示的字符窜
     func countString(count: Int, defaultStr: String) -> String {
        
        if count == 0 {
            return defaultStr
        }
        
        if count < 10000 {
            return count.description
        }
        
        return String(format: "%.02f 万", Double(count) / 10000)
    }

}
