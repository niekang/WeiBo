//
//  Const.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/20.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

let WBAPPkey = "1205476206"
let WBAppSecret = "bcd661cbc2136f828726e33ba9036003"
let WBRedirectURL = "https://api.weibo.com/oauth2/default.html"

//const
let kWidth = UIScreen.main.bounds.width

let kHeight = UIScreen.main.bounds.height

let kNavHeight = 64 as CGFloat

let kTabBarHeight = 49 as CGFloat

//通知
let WBLoginSuccessNotification = "WBLoginNotification"
let WBLogOutNotification = "WBNotLoginNotification"
let WBHomeVCShouldRefresh = "WBHomeVCShouldRefresh" // 有新的微博消息

let GrayBGColor = UIColor.rgbColor(red: 237, green: 237, blue: 238)



//常用函数
func WBLog<T>(_ item:T){
    #if DEBUG
        print(item)
    #endif
}
