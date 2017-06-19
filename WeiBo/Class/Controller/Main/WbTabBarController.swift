//
//  WbTabBarController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WbTabBarController: UITabBarController {
    
    lazy var composeBtn = UIButton.nk_imageButton(normalImage: UIImage(named:"tabbar_compose_icon_add"), highLightedImage:UIImage(named:"tabbar_compose_icon_add_highlighted") ,normalBackgroudImage: UIImage(named:"tabbar_compose_button"), highLightedBackgroudImage:UIImage(named:"tabbar_compose_button_highlighted"))

    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        addComposeBtn()
    }
    
    /// 添加子控制器
    func setControllers() {
        let dictArray = [
            ["className":"WBHomeViewController","title":"首页","imageName":"tabbar_home"],
            ["className":"WBMessageViewController","title":"消息","imageName":"tabbar_message_center"],
            ["className":"","title":"","imageName":""],
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
                let vc = UIViewController()
                vc.tabBarItem.isEnabled = false
                return vc
        }
        
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named:imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .selected)
        
        let nav = WBNavigationController(rootViewController: vc)
        return nav
    }
    
    func addComposeBtn(){
        let w = tabBar.width/5
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        tabBar.addSubview(composeBtn)
    }
}

