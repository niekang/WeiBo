//
//  WBManager.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import Foundation

class WBManager: NSObject {
    
    static let shared:WBManager = {
        let instance = WBManager()
        return instance
    }()
    
    var login:fals
}
