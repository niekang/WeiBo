
//
//  WBNavigationController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        /// 导航栏设置
        setupNavigationBarAppearance()
    }
    
    func setupNavigationBarAppearance() {
        navigationBar.barTintColor =  UIColor.hexColor(hex: 0xF6F6F6)
    }

    /// 重载push函数 添加统一‘返回’按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            let fixItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: #selector(backAction))
            fixItem.width = -10
            let leftItem =  UIBarButtonItem(title: "返回", target: self, action: #selector(backAction))
            viewController.navigationItem.leftBarButtonItems = [fixItem, leftItem]
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    /// 返回按钮事件
    @objc func backAction() {
        popViewController(animated: true)
    }
}


