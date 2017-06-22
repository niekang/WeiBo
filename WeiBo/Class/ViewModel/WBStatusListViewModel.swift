//
//  WBStatusListViewModel.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit
import SVProgressHUD

class WBStatusListViewModel {
    
    var statusList = [WBStatusViewModel]()
    
    func loadWBStatusListData(since_id:Int64 = 0, max_id:Int64 = 0, count:Int = 0, completion:@escaping (Bool)->Void) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        WBNetworkManager.shared.request(URLString: urlString, parameters: nil) { (isSuccess, json) in
            
            if isSuccess == true {
                guard let statuses = ((json as? [String:AnyObject])?["statuses"]) as? [[String:AnyObject]] else{
                    return
                }
                
                for dict in statuses {
                    guard let status = WBStatus.yy_model(with: dict) else {
                        continue
                    }
                    self.statusList.append(WBStatusViewModel(status: status))
                }

            }
            WBLog(self.statusList)
            completion(isSuccess)
        }
    }
    
}
