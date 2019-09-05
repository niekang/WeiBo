//
//  BaseViewController.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/3.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    
    /// 访客视图
    lazy var visitorView = VisitorView(frame: CGRect(x: 0, y: kNavHeight, width: kWidth, height: kHeight - kNavHeight - kTabBarHeight))
    
    public lazy var stateManager = PageStateManager(self.view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - 添加登录通知,处理访客视图
extension BaseViewController {
    
    /// 初始化
    func setup() {
        view.addSubview(visitorView)
        visitorView.logBtn.nk_action(self, #selector(logBtnClick(sender:)))
        visitorView.registerBtn.nk_action(self, #selector(resisterBtnClick(sender:)))
        
        /// 监听登录状态
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: Notification.Name(WBLoginSuccessNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logOut), name: Notification.Name(WBLogOutNotification), object: nil)
        
        /// 判断是否登录
        (WBUserAccont.shared.access_token != nil) ? loginSuccess() : logOut()
        
    }
    
    ///注册
    @objc func resisterBtnClick(sender:UIButton) {
        WBUserAccont.shared.login()
    }
    ///登录
    @objc func logBtnClick(sender:UIButton) {
        WBUserAccont.shared.login()
    }
    
    ///登录成功监听方法
    @objc func loginSuccess() {
        visitorView.removeFromSuperview()
    }
    
    /// 退出登录监听方法
    @objc func logOut() {
        view.addSubview(visitorView)
    }
    
}

