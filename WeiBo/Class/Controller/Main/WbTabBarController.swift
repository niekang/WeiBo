//
//  WbTabBarController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WbTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
    }
    
    /// 添加子控制器
    func setControllers() {
        let dictArray = [
            ["className":"WBHomeViewController","title":"首页","imageName":"tabbar_home"],
            ["className":"WBMessageViewController","title":"消息","imageName":"tabbar_message_center"],
            ["className":"WBDiscoverViewController","title":"发现","imageName":"tabbar_discover"],
            ["className":"WBMineViewController","title":"我的","imageName":"tabbar_profile"]
        ];
        
        var vcsArray = [UIViewController]()
        for dict in dictArray {
            let vc = controller(dict: dict)
            vcsArray.append(vc)
        }
        
        viewControllers = vcsArray
    }
    
    
    /// 根据提供的信息创建相应的控制器
    func controller(dict:[String:String]) -> UIViewController{
        guard let className = dict["className"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + className) as? UIViewController.Type else {
                return UIViewController()
        }
        
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named:imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .selected)
        
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
}
