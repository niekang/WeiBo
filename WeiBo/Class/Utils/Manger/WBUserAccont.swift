//
//  WBUserAccont.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import Foundation
import HandyJSON


class WBUserAccont: BaseModel {
    
    static let shared  = WBUserAccont()
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("/user")

    var access_token:String?
    
    var expires_in:Int = 0
    
    var remind_in:String?
    
    /// 用户昵称
    var screen_name: String?
    /// 用户头像地址
    var profile_image_url: String?
    

    var uid:String?
    
    required init() {
        super.init()
        //从本地加载用户信息
        guard let json = NSData(contentsOfFile: path),
            let dict = try? JSONSerialization.jsonObject(with: json as Data, options: []) as? [String:AnyObject] else {
            return
        }
        
        reset(dict, shouldUpdate: true)
    }
    
    //跳转登录界面
    func login(modelVC:UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) {
        guard let modelVC = modelVC else{
            return
        }
        let oauthVC = WBOAuthViewController()
        let nav = WBNavigationController(rootViewController: oauthVC)
        modelVC.present(nav, animated: true, completion: nil)
    }
    
    func reset(_ dict: [String: Any], shouldUpdate: Bool = false) {
        self.access_token = nil
        self.uid = nil
        self.remind_in = nil
        self.screen_name = nil
        self.profile_image_url = nil
        self.expires_in = 0
        
        if(shouldUpdate) {
            update(dict)
        }
    }
    
    func update(_ dict: [String: Any]) {
        if let access_token = dict["access_token"] as? String {
            self.access_token = access_token
        }
        if let uid = dict["uid"] as? String {
            self.uid = uid
        }
        if let remind_in = dict["remind_in"] as? String {
            self.remind_in = remind_in
        }
        if let screen_name = dict["screen_name"] as? String {
            self.screen_name = screen_name
        }
        if let profile_image_url = dict["profile_image_url"] as? String {
            self.profile_image_url = profile_image_url
        }
        if let expires_in = dict["expires_in"] as? Int {
            self.expires_in = expires_in
        }

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
        
        let params = [
            "client_id": WBAPPkey,
            "client_secret": WBAppSecret,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": WBRedirectURL
        ]
        
        HttpClient.shared.post(urlString: WBAPI_Auth, params: params, success: { (userAccount: WBUserAccont) in
            guard let dict = userAccount.toJSON() else {
                return
            }
            self.reset(dict, shouldUpdate: true)
            //请求用户信息
            self.requestUserInfo(completion: { (isSuccess, json) in
                guard let dict = json as? [String:Any] else {
                    return
                }
                //给当前模型赋值
                self.update(dict)
                //将用户信息保存在本地
                self.saveAccout()
                completion(isSuccess)
            })
            
        }) { (_, _) in
            completion(false)
        }
        
    }
    
    
    /// 请求用户信息
    ///
    /// - Parameter completion: 完成回调
    func requestUserInfo(completion:@escaping ((Bool, Any?) -> Void)) {
        let params = ["uid":uid ?? ""]
        HttpClient.shared.get(urlString: WBAPI_UserInfo, params: params, success: { (user: WBUser) in
            completion(true, user.toJSON())
        }) { (error, _) in
            completion(false, error)
        }
    }
    
    /// 保存用户信息
    ///
    /// - Parameter json: 用户信息的json数据
    func saveAccout() {
        let json = (self.toJSON()) ?? [:]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
            return
        }
        (jsonData as NSData).write(toFile: path, atomically: true)
    }
    
}
