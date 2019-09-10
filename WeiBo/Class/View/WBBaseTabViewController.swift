//
//  WBBaseTabViewController.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/6.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

class WBBaseTabViewController: BaseTableViewController {
    
    lazy var visitorView = VisitorView(frame: self.view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setup()
    }

}

extension WBBaseTabViewController {
    
    func setup() {
        //
        visitorView.logBtn.action(self, #selector(logBtnClick(sender:)))
        visitorView.registerBtn.action(self, #selector(resisterBtnClick(sender:)))
        
        /// 监听登录状态
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: Notification.Name(WBLoginSuccessNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logOut), name: Notification.Name(WBLogOutNotification), object: nil)
        
        /// 判断是否登录
        (WBUserAccont.shared.access_token != nil) ? self.loginSuccess() : self.logOut()

    }
    
    // MARK: - 添加登录通知,处理访客视图
    
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
        self.visitorView.removeFromSuperview()
    }
    
    /// 退出登录监听方法
    @objc func logOut() {
        self.view.addSubview(self.visitorView)
        self.visitorView.bringSubviewToFront(self.visitorView)
    }

}
