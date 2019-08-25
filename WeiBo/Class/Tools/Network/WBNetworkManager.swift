//
//  NetworkTool.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import Foundation
import AFNetworking
import SVProgressHUD

enum HTTPMethod {
    case GET
    case POST
}

class WBNetworkManager: AFHTTPSessionManager {
    
    static let shared:WBNetworkManager = {
        let sessionManager = WBNetworkManager()
        sessionManager.requestSerializer.timeoutInterval = 20
        sessionManager.responseSerializer.acceptableContentTypes = Set(arrayLiteral: "application/json", "text/json", "text/javascript","text/plain","text/html")
        return sessionManager
    }()
    
    @discardableResult
    func request(method:HTTPMethod = .GET, URLString: String, parameters: Any?, completion:@escaping ((Bool, Any?) -> Void)) -> URLSessionDataTask? {
        
        var parameters = parameters as? [String:AnyObject]
        
        if parameters == nil {
            parameters = [String:AnyObject]()
        }
        
        if let access_token = WBUserAccont.shared.access_token{
            parameters!["access_token"] = access_token as AnyObject
        }
        
        var dataTask:URLSessionDataTask?
        
        let success = { (dataTask:URLSessionDataTask, json:Any?) ->() in
            completion(true, json)
        }
            
        let failure = { (dataTask:URLSessionDataTask?, error:Error) -> () in
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: error.localizedDescription)
            completion(false, nil)
        }
        
        if method == .POST {
            dataTask = post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
        if method == .GET {
            dataTask = get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        return dataTask
    }
    
    /// 上传文件
    ///
    /// - Parameters:
    ///   - URLString: 请求URL
    ///   - parameters: 请求参数
    ///   - name: 上传文件使用的字段名
    ///   - data: 上传文件的二进制数据
    ///   - progress: 上传进度
    ///   - completion: 上传完成回调
    /// - Returns: 上传任务
    @discardableResult
    func upload(URLString:String, parameters:Any?, name: String, data: Data, progress:((Progress) -> Void)?, completion:@escaping ((Bool, Any?) -> Void)) -> URLSessionDataTask?{
        
        let success = {(task:URLSessionDataTask?, json:Any?) in
            completion(true, json)
        }
        
        let failure = {(task:URLSessionDataTask?, error:Error) in
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: error.localizedDescription)
            completion(false, nil)
        }
        
        let dataTask = post(URLString, parameters: parameters, constructingBodyWith: { (formatData) in
            formatData.appendPart(withFileData: data, name: name, fileName: "xxx", mimeType: "application/octet-stream")
        }, progress: progress, success: success, failure: failure)
        
        return dataTask
    }
    
    
    /// 发布微博
    ///
    /// - Parameters:
    ///   - text: 微博文字
    ///   - image: 微博图片
    ///   - completion: 发布完成回调
    /// - Returns: 发布任务
    @discardableResult
    func uploadWB(text:String, image:UIImage?, completion:@escaping((Bool, Any?) -> ())) -> URLSessionDataTask?{
        
        let urlString: String

        // 根据是否有图像，选择不同的接口地址
        if image == nil {
            urlString = "https://api.weibo.com/2/statuses/update.json"
        } else {
            urlString = "https://upload.api.weibo.com/2/statuses/upload.json"
        }


        var name: String?
        var data: Data?
        
        if image != nil {
            name = "image"
            data = image!.pngData()
        }

        var parameters = ["status": text] as [String:AnyObject]
        
        if let name = name ,
            let data = data {
            
            if let access_token = WBUserAccont.shared.access_token{
                parameters["access_token"] = access_token as AnyObject
            }
            
            return upload(URLString: urlString, parameters: parameters, name: name, data: data, progress: nil, completion: completion)
        }else {
            return request(method:.POST, URLString: urlString, parameters: parameters, completion: completion)
        }
    }
    
}
