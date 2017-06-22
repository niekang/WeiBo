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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
