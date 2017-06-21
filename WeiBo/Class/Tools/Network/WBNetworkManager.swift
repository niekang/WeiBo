//
//  NetworkTool.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/21.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import Foundation
import AFNetworking

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
        
        parameters!["access_token"] = WBUserAccont.shared.access_token as AnyObject
        
        var dataTask:URLSessionDataTask?
        
        let success = { (dataTask:URLSessionDataTask, json:Any?) ->() in
            completion(true, json)
        }
            
        let failure = { (dataTask:URLSessionDataTask?, error:Error) -> () in
            completion(false, error)
        }
        
        if method == .POST {
            dataTask = post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
        if method == .GET {
            dataTask = get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        return dataTask
    }
    
}
