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
        
    }
    
    var description: String {
        return status.description
    }

}
