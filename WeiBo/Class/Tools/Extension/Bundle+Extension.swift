//
//  Bundle+Extension.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import Foundation

extension Bundle {
    var nameSpace:String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
