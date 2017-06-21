//
//  WBUserAccont.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import Foundation
import YYModel

class WBUserAccont: NSObject {
    
    static let shared : WBUserAccont = WBUserAccont()
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("/user")

    var access_token:String?
    
    var expires_in:Int?
    
    var remind_in:Int?

    var uid:Int?
    
    private override init() {
        super.init()
        //从本地加载用户信息
        guard let json = NSData(contentsOfFile: path),
            let dict = try? JSONSerialization.jsonObject(with: json as Data, options: []) as? [String:AnyObject] else {
            return
        }
        yy_modelSet(with:dict ?? [:])
    }
    
    //跳转登录界面
    func login(modelVC:UIViewController? = UIApplication.shared.keyWindow?.rootViewController) {
        guard let modelVC = modelVC else{
            return
        }
        let oauthVC = WBOAuthViewController()
        let nav = WBNavigationController(rootViewController: oauthVC)
        modelVC.present(nav, animated: true, completion: nil)
    }

    override var description: String {
        return yy_modelDescription()
    }
    
}


// MARK: - OAuth授权
extension WBUserAccont {
    
    /// 请求用户授权信息
    ///
    /// - Parameters:
    ///   - code: 授权码
    ///   - completion: 返回授权是否成功
    func requestToken(code:String, completion:@escaping ((Bool) -> Void)) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id": WBAPPkey,
                      "client_secret": WBAppSecret,
                      "grant_type": "authorization_code",
                      "code": code,
                      "redirect_uri": WBRedirectURL]
        
        WBNetworkManager.shared.request(URLString: urlString, parameters: params, completion:{ (isSuccess, json) in
            completion(isSuccess)
            guard let dict = json as? [String:AnyObject] else {
                return
            }
            //给当前模型赋值
            self.yy_modelSet(with: dict)
            //将用户信息保存在本地
            self.saveAccout(json: dict)
        })
        
    }
    
    
    /// 保存用户信息
    ///
    /// - Parameter json: 用户信息的json数据
    func saveAccout(json:Any) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
            return
        }
        (jsonData as NSData).write(toFile: path, atomically: true)
    }
    
}
