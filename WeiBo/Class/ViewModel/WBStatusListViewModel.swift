//
//  WBStatusListViewModel.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class WBStatusListViewModel {
    
    var statusList = [WBStatusViewModel]()
    
    func loadWBStatusListData(since_id:Int64 = 0, max_id:Int64 = 0, count:Int = 20, completion:@escaping (Bool)->Void) {
        
        let parameters = ["since_id":"\(since_id)","max_id":"\(max_id)","count":"\(count)"]
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        WBNetworkManager.shared.request(URLString: urlString, parameters: parameters) { (isSuccess, json) in
            
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
                
                self.cachSingleImage(statusLsistViewModel: self.statusList, completion: completion)
                
            }else {
                completion(false)
            }
        }
    }
    
    
    func cachSingleImage(statusLsistViewModel:[WBStatusViewModel], completion:@escaping (Bool) -> Void) {
        
        if statusList.count > 0 {
            let group = DispatchGroup()
            group.enter()
            for statusViewModel in statusLsistViewModel {
                guard let pic_urls = statusViewModel.picURLs else {
                    continue
                }
                if pic_urls.count == 1 {
                    SDWebImageDownloader.shared().downloadImage(with: URL(string: pic_urls[0].thumbnail_pic!), options: [], progress: nil, completed: { (image, _, _, _) in
                        
                        if let image = image {
                            
                            statusViewModel.updateSingleImageSizeAfterDownload(image: image)
                        }
                        
                    })

                }
            }
            group.leave()
            group.notify(queue: DispatchQueue.main, execute: { 
                completion(true)
            })
        }else{
            completion(true)
        }
    }
    
    
    
}
