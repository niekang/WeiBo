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
    
    
    /// 加载微博数据
    ///
    /// - Parameters:
    ///   - isHeader: 是否是下拉
    ///   - completion: 回调
    func loadWBStatusListData(isHeader:Bool = true, completion:@escaping (Bool)->Void) {
        
        let since_id = isHeader ? (statusList.first?.status.id ?? 0) : 0 //当since_id存在时返回大于max_id的数据
        let max_id = isHeader ? 0 : ((statusList.last?.status.id ?? 0) - 1) // 当max_id存在时返回小于等于max_id的数据
        
        /// count 不存在默认返回20条数据
        let parameters = ["since_id":"\(since_id)","max_id":"\(max_id)"]
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        WBNetworkManager.shared.request(URLString: urlString, parameters: parameters) { (isSuccess, json) in
            
            if isSuccess == true {
                guard let statuses = ((json as? [String:AnyObject])?["statuses"]) as? [[String:AnyObject]] else{
                    return
                }
                
                var array = [WBStatusViewModel]()
                for dict in statuses {
                    guard let status = WBStatus.yy_model(with: dict) else {
                        continue
                    }
                    array.append(WBStatusViewModel(status: status))
                }
                if isHeader {
                    /// 下拉的时候 将数据拼接到数组前面
                    self.statusList = array + self.statusList
                }else{
                    /// 上拉的时候 将数据拼接到数组后面
                    self.statusList += array
                }

                /// 缓存单张视图
                self.cachSingleImage(statusLsistViewModel: self.statusList, completion: completion)
                
            }else {
                completion(false)
            }
        }
    }
    
    
    /// 缓存单张视图
    ///
    /// - Parameters:
    ///   - statusLsistViewModel: 所有微博数据
    ///   - completion: 所有单张视图缓存完毕之后的回调
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
