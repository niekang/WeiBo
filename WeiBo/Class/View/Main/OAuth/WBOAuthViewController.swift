//
//  WBOAuthViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class WBOAuthViewController: WBSuperViewController {
    
    private var webview =  WKWebView()
    
    override func loadView() {
        webview.navigationDelegate = self
        webview.scrollView.isScrollEnabled = false
        view = webview
        navigationItem.title = "新浪微博"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebview()
    }
    
    func loadWebview(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(backAction))
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAPPkey)&redirect_uri=\(WBRedirectURL)"
        guard let url = URL(string: urlString) else {
            return
        }
        webview.load(URLRequest(url: url))
    }
    
    @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }

}

extension WBOAuthViewController:WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        if webView.url?.absoluteString.hasPrefix(WBRedirectURL) == false {
            decisionHandler(WKNavigationResponsePolicy.allow)
            return
        }
        
        if webView.url?.query?.hasPrefix("code=") == false {
            decisionHandler(WKNavigationResponsePolicy.allow)
            return
        }
        
        if let code = webView.url?.query?.substring(from: "code.".endIndex) {
            WBUserAccont.shared.requestToken(code: code, completion: { (isSuccess) in
                if isSuccess == true {
                    SVProgressHUD.showSuccess(withStatus: "登录成功!")
                    NotificationCenter.default.post(name: Notification.Name(rawValue: WBLoginSuccessNotification), object: nil)
                    self.dismiss(animated: true, completion: nil)
                }else{
                    SVProgressHUD.showError(withStatus: "登录失败!")
                }
            })
        }
    
        decisionHandler(WKNavigationResponsePolicy.cancel)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show(withStatus: "加载中")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.showError(withStatus: "页面加载失败")
    }
}
