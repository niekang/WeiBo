//
//  Const.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/20.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

let WBAPPkey = ""

let WBAppSecret = ""

let WBRedirectURL = "http://baidu.com"

let kWidth = UIScreen.main.bounds.width

let kHeight = UIScreen.main.bounds.height

let kNavHeight = 64 as CGFloat

let kTabBarHeight = 49 as CGFloat

let WBLoginSuccessNotification = "WBLoginNotification"
let WBLogOutNotification = "WBNotLoginNotification"

let WBHomeVCShouldRefresh = "WBHomeVCShouldRefresh" // 有新的微博消息

func WBLog<T>(_ item:T){
    #if DEBUG
        print(item)
    #endif
}
