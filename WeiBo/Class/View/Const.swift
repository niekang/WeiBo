//
//  Const.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/20.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

let WBAPPkey = "1205476206"

let WBAppSecret = "491d493c293d8946fbb6459d4c3f8deb"

let WBRedirectURL = "http://baidu.com"

let kWidth = UIScreen.main.bounds.width

let kHeight = UIScreen.main.bounds.height

let kNavHeight = 64 as CGFloat

let kTabBarHeight = 49 as CGFloat

let WBLoginSuccessNotification = "WBLoginNotification"
let WBLogOutNotification = "WBNotLoginNotification"


func WBLog<T>(_ item:T){
    #if DEBUG
        print(item)
    #endif
}