//
//  WBStatusListViewModel.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBStatusListViewModel: NSObject {
    
    func loadWBStatusListData(since_id:Int64 = 0, max_id:Int64 = 0, count:Int = 0) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        WBNetworkManager.shared.request(URLString: urlString, parameters: nil) { (isSuccess, json) in
            WBLog(json)
        }
    }
    
}
