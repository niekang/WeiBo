//
//  WBUserAccont.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import Foundation
import YYModel

@objcMembers
class WBUserAccont: NSObject {
    
    static let shared : WBUserAccont = WBUserAccont()
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("/user")

    var access_token:String?
    
    var expires_in:Int = 0
    
    var remind_in:String?
    
    /// 过期日期
    var expiresDate: Date?
    
    /// 用户昵称
    var screen_name: String?
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?

    var uid:String?
    
    private override init() {
        super.init()
        //从本地加载用户信息
        guard let json = NSData(contentsOfFile: path),
            let dict = try? JSONSerialization.jsonObject(with: json as Data, options: []) as? [String:AnyObject] else {
            return
        }
        yy_modelSet(with:dict )
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
        
        WBNetworkManager.shared.request(method: .POST, URLString: urlString, parameters: params, completion:{ (isSuccess, json) in
            guard let dict = json as? [String:AnyObject] else {
                return
            }
            //给当前模型赋值
//            self.access_token = dict["access_token"] as? String
//            self.uid = dict["uid"] as? String
//            self.expires_in = dict["expires_in"] as! Int
//            self.remind_in = dict["remind_in"] as? String
//YYModel方法有问题
            self.yy_modelSet(with: dict)
            //请求用户信息
            self.requestUserInfo(completion: { (isSuccess, json) in
                guard let dict = json as? [String:AnyObject] else {
                    return
                }
                //给当前模型赋值
                self.yy_modelSet(with: dict)
                //将用户信息保存在本地
                self.saveAccout()
                completion(isSuccess)
            })
        })
        
    }
    
    
    /// 请求用户信息
    ///
    /// - Parameter completion: 完成回调
    func requestUserInfo(completion:@escaping ((Bool, Any?) -> Void)) {
        let infoApi = "https://api.weibo.com/2/users/show.json"
        let params = ["uid":uid]
        WBNetworkManager.shared.request(URLString: infoApi, parameters: params, completion:completion)
    }
    
    /// 保存用户信息
    ///
    /// - Parameter json: 用户信息的json数据
    func saveAccout() {
        let json = (self.yy_modelToJSONObject() as? [String:AnyObject]) ?? [:]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
            return
        }
        (jsonData as NSData).write(toFile: path, atomically: true)
    }
    
}
