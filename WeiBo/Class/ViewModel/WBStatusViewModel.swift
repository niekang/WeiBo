//
//  WBStatusViewModel.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBStatusViewModel {
    
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
    /// 缓存行高
    var rowHeight: CGFloat = 0
    
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

        //设置配图
         pictureViewSize = caculatePictureViewHeight(count: picURLs?.count)
        
        // 微博正文的属性文本
        statusAttrText = NSAttributedString(string: status.text ?? "")

        //设置被转发微博的文字
        let retweeted = "@" + (status.retweeted_status?.user?.screen_name ?? "")
     
        retweetedAttrText = NSAttributedString(string: retweeted + ":" + (status.retweeted_status?.text ?? ""))
        //计算行高
        rowHeight = caculateRowHeight()
    }
    

}

extension WBStatusViewModel {
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

    
    /// 计算配图视图高度
    ///
    /// - Parameter count: 配图数量
    /// - Returns: 高度
    func caculatePictureViewHeight(count:Int?) -> CGSize{
        guard let count = count else {
            return CGSize.zero
        }
        if count == 0 {
            return CGSize.zero
        }
        //计算行数
        let row = (count - 1)/3 + 1
        //计算高度
        let viewHeight = outMargin + CGFloat(row) * imageWidth + innerMargin * (CGFloat(row) - 1)
        
        return CGSize(width: picViewWidth, height: viewHeight)
    }
    
    
    /// 单张图片下载完成后更新配图视图高度约束
    ///
    /// - Parameter image:单张缓存配图
    func updateSingleImageSizeAfterDownload (image:UIImage){
        
        var size = image.size
        let maxWidth: CGFloat = 200
        let minWidth: CGFloat = 40
        
        // 过宽图像处理
        if size.width > maxWidth {
            // 设置最大宽度
            size.width = 200
            // 等比例调整高度
            size.height = size.width * image.size.height / image.size.width
        }
        
        // 过窄图像处理
        if size.width < minWidth {
            size.width = minWidth
            
            // 要特殊处理高度，否则高度太大，会印象用户体验
            size.height = size.width * image.size.height / image.size.width / 4
        }
        
        // 过高图片处理，图片填充模式就是 scaleToFill，高度减小，会自动裁切
        if size.height > 200 {
            size.height = 200
        }
        
        // 注意，尺寸需要增加顶部的 12 个点，便于布局
        size.height += outMargin
        
        // 重新设置配图视图大小
        pictureViewSize = size
        //更新行高
        rowHeight = caculateRowHeight()
    }
    
    
    /// 计算行高
    ///
    /// - Returns: 计算结果
    func caculateRowHeight() -> CGFloat{
        // 原创微博：顶部分隔视图(12) + 间距(12) + 图像的高度(34) + 间距(12) + 正文高度(需要计算) + 配图视图高度(计算) + 间距(12) ＋ 底部视图高度(35)
        // 被转发微博：顶部分隔视图(12) + 间距(12) + 图像的高度(34) + 间距(12) + 正文高度(需要计算) + 间距(12)+间距(12)+转发文本高度(需要计算) + 配图视图高度(计算) + 间距(12) ＋ 底部视图高度(35)
        
        let margin: CGFloat = 12
        let iconHeight: CGFloat = 34
        let toolbarHeight: CGFloat = 35
        
        var height: CGFloat = 0
        
        let viewSize = CGSize(width: kWidth - 2 * margin, height: CGFloat(MAXFLOAT))
        
        // 1. 计算顶部位置
        height = 2 * margin + iconHeight + margin
        
        // 2. 正文属性文本的高度
        if let text = statusAttrText {
            
            height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
        }
        
        // 3. 判断是否转发微博
        if status.retweeted_status != nil {
            
            height += 2 * margin
            
            // 转发文本的高度 - 一定用 retweetedText，拼接了 @用户名:微博文字
            if let text = retweetedAttrText {
                
                height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
            }
        }
        
        // 4. 配图视图
        height += pictureViewSize.height
        
        height += margin
        
        // 5. 底部工具栏
        height += toolbarHeight
        
        // 6. 返回计算结果
        return height
    }
}
