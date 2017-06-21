//
//  WBRefreshControl.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit
import MJRefresh

class WBRefreshControl: NSObject {
    
    func header(target:Any, refreshingAction:Selector) -> MJRefreshNormalHeader{
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: refreshingAction)
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.setTitle("", for: .idle)
        header?.setTitle("松开就可以刷新", for: .pulling)
        header?.setTitle("正在刷新", for: .refreshing)
        header?.setTitle("再拉就刷新给你看看", for: .willRefresh)
        header?.setTitle("", for: .noMoreData)
        return header!
    }
    
    
    func footer(target:Any, refreshingAction:Selector) -> MJRefreshAutoNormalFooter{
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: refreshingAction)
        footer?.setTitle("", for: .idle)
        footer?.setTitle("", for: .noMoreData)
        footer?.setTitle("松开就可以刷新", for: .pulling)
        footer?.setTitle("正在刷新", for: .refreshing)
        footer?.setTitle("再拉就刷新给你看看", for: .willRefresh)
        return footer!
    }
}
