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
    
    init(status:WBStatus) {
        self.status = status
    }
    
    var description: String {
        return status.description
    }

}
