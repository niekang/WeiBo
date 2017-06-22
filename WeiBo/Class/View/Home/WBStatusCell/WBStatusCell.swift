//
//  WBStatusCell.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/22.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {

    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    
    /// 姓名
    @IBOutlet weak var nameLab: UILabel!
    
    /// 会员图标
    @IBOutlet weak var memberImageView: UIImageView!
    
    /// 时间
    @IBOutlet weak var timeLab: UILabel!
    
    /// 来源
    @IBOutlet weak var sourceLab: UILabel!
    
    /// vip图标
    @IBOutlet weak var vipImageView: UIImageView!
    
    /// 正文
    @IBOutlet weak var contentLab: UILabel!
    
    //底部工具条
    @IBOutlet weak var statusToolBar: WBStatusTooBar!
    
    @IBOutlet weak var statusPicView: WBStatusPictureView!
    
    var statusViewModel:WBStatusViewModel? {
        didSet{
            //姓名
            nameLab.text = statusViewModel?.status.user?.screen_name
            //会员图标
            memberImageView.image = statusViewModel?.memberIcon
            //认证图标
            vipImageView.image = statusViewModel?.vipIcon
            //正文
            contentLab.text = statusViewModel?.status.text
            //设置头像
            iconView.nk_setImage(URLString: statusViewModel?.status.user?.profile_image_url, placeholderImageName: "avatar_default_big", isAvatar: true)
            //设置底部工具条数据
            statusToolBar.statusViewModel = statusViewModel
            //设置配图
            statusPicView.statusViewModel = statusViewModel
        }
    }
}
