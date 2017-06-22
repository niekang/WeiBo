//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBBaseViewController: WBTableViewController {
    
    lazy var visitorView = VisitorView(frame: CGRect(x: 0, y: kNavHeight, width: kWidth, height: kHeight - kNavHeight - kTabBarHeight))

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: - 添加登录通知,处理访客视图
extension WBBaseViewController {
    
    func setup() {
        view.addSubview(visitorView)
        visitorView.logBtn.nk_action(self, #selector(logBtnClick(sender:)))
        visitorView.registerBtn.nk_action(self, #selector(resisterBtnClick(sender:)))

        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: Notification.Name(WBLoginSuccessNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logOut), name: Notification.Name(WBLogOutNotification), object: nil)
        
        (WBUserAccont.shared.access_token != nil) ? loginSuccess() : logOut()

    }
    
    func resisterBtnClick(sender:UIButton) {
        WBUserAccont.shared.login()
    }
    
    func logBtnClick(sender:UIButton) {
        WBUserAccont.shared.login()
    }
    
    func loginSuccess() {
        visitorView.removeFromSuperview()
    }
    
    func logOut() {
        view.addSubview(visitorView)
    }
}
