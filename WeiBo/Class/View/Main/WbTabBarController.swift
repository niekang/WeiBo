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
        setup()
    }
    
    func setup() {
        /// 设置tabbar不透明
        tabBar.barTintColor = UIColor.white
//        tabBar.isTranslucent = false  //也可以
        /// 添加引导页面
        newFeatureView()
    }

}


// MARK: - 添加欢迎视图
extension WbTabBarController {
    //引导图
    func newFeatureView() {
        /// 比较本地的版本与当前版本 判断是否是更新之后进入app
        /// 1> 如果是 显示新特新界面
        /// 2> 如果不是 继续判断是否显示欢迎界面
        if ((UserDefaults.standard.object(forKey: "app_version") as? String) != Bundle.main.version) {
            let newFeatureView = WBNewFeatureView.newFeatureView(enterWB: { [weak self] in
                self?.welcomeView()
            })
            view.addSubview(newFeatureView)
            newFeatureView.frame = UIScreen.main.bounds
            
            UserDefaults.standard.set(Bundle.main.version, forKey: "app_version")
            UserDefaults.standard.synchronize()

        }else {
            welcomeView()
        }
    }
    
    //欢迎界面
    func welcomeView() {
        if WBUserAccont.shared.access_token == nil {
            /// 未登录显示子控制器
            setupTabbar()
            return
        }
        /// 已登录先显示欢迎界面
        let welcomeView = WBWelcomView.welcomeView {[weak self] in
            self?.setupTabbar()
        }
        view.addSubview(welcomeView)
        welcomeView.frame = UIScreen.main.bounds
    }
}


// MARK: - 添加子控制器
extension WbTabBarController {
    
    func setupTabbar() {
        /// 添加子控制器
        setControllers()
        /// 添加加号按钮
        addComposeBtn()
    }
    
    /// 准备子控制器创建信息
    func setControllers() {
        
        let dictArray = [
            ["vc":WBHomeViewController(),"title":"首页","imageName":"tabbar_home","visitor":["image":"","tip":"关注一些人，回这里看看有什么惊喜"]],
            
            ["vc":WBMessageViewController(),"title":"消息","imageName":"tabbar_message_center","visitor":["image":"visitordiscover_image_message","tip":"登录后，别人评论你的微博，发给你的消息，都会在这里收到通知"]],
            
            ["vc":"","title":"","imageName":"","visitor":["image":"","tip":""]],
            
            ["vc":WBDiscoverViewController(),"title":"发现","imageName":"tabbar_discover","visitor":["image":"visitordiscover_image_message","tip":"登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过"]],
            
            ["vc":WBMineViewController(),"title":"我的","imageName":"tabbar_profile","visitor":["image":"visitordiscover_image_profile","tip":"登录后，你的微博、相册、个人资料会显示在这里，展示给别人"]]
        ];
        
        var vcsArray = [UIViewController]()
        for dict in dictArray {
            let vc = controller(dict: dict)
            vcsArray.append(vc)
            vc.view.backgroundColor = UIColor.nk_randomColor()
        }
    
        viewControllers = vcsArray
    }
    
    /// 根据提供的信息创建相应的控制器
    func controller(dict:[String:Any]) -> UIViewController{
        guard let vc = dict["vc"] as? BaseViewController,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let visitorDic = dict["visitor"] as? [String:String] else {
                let vc = UIViewController()
                vc.view.backgroundColor = UIColor.red
                vc.tabBarItem.isEnabled = false
                return vc
        }
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named:imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.orange], for: .selected)
        vc.visitorView.visitorInfoDictionary = visitorDic
        let nav = WBNavigationController(rootViewController: vc)
        return nav
    }
    
    /// 添加加号按钮
    func addComposeBtn(){
        let composeBtn = UIButton().nk_image("tabbar_compose_icon_add").nk_backgroundImage("tabbar_compose_button").nk_action(self, #selector(composeBtnClick(sender:)))
        let w = tabBar.width/5
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        tabBar.addSubview(composeBtn)
    }
    
    //点击加号按钮事件
    @objc func composeBtnClick(sender:UIButton) {
        let composeView = WBComposeView.composeView()
        view.addSubview(composeView)
        composeView.show {[weak self] (clsName) in
            guard let clsName = clsName,
                let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type else {
                return
            }
            
            let vc = cls.init()
            let nav = WBNavigationController(rootViewController: vc)
            self?.present(nav, animated: true, completion: nil)
        }
    }

}

