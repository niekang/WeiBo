//
//  Const.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/20.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

let kWidth = UIScreen.main.bounds.width

let kHeight = UIScreen.main.bounds.height

let kNavHeight = 64 as CGFloat

let kTabBarHeight = 49 as CGFloat

func WBLog<T>(item:T){
    #if DEBUG
        print(item)
    #endif
}
