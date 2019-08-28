//
//  HttpClient.swift
//  WeiBo
//
//  Created by MC on 2019/8/27.
//  Copyright © 2019 com.nk. All rights reserved.
//

import RxAlamofire
import HandyJSON
import Alamofire

public class HttpClient {
    
    public var baseURL: String = ""
    public var headers: HTTPHeaders = [:]

    public init(_ baseURL: String = "", headers: HTTPHeaders = [:]) {
        self.baseURL = baseURL
        for (key, value) in headers{
            self.headers[key] = value
        }
    }
    
    @discardableResult
    public func get<T: HandyJSON>(urlString: String,
                                      params: [String: Any] = [:],
                                      success: @escaping (T) -> Void,
                                      failure: @escaping (Error, String) -> Void) -> DataRequest{
        return request(urlString: urlString, params: params, method: HTTPMethod.get, success: success, failure: failure)
    }
    
    @discardableResult
    public func get<T: HandyJSON>(urlString: String,
                                  params: [String: Any] = [:],
                                  success: @escaping ([T?]) -> Void,
                                  failure: @escaping (Error, String) -> Void) -> DataRequest{
        return request(urlString: urlString, params: params, method: HTTPMethod.get, success: success, failure: failure)
    }
    
    @discardableResult
    public func post<T: HandyJSON>(urlString: String,
                                  params: [String: Any] = [:],
                                  success: @escaping (T) -> Void,
                                  failure: @escaping (Error, String) -> Void) -> DataRequest{
        return request(urlString: urlString, params: params, method: HTTPMethod.post, success: success, failure: failure)
    }
    
    @discardableResult
    public func post<T: HandyJSON>(urlString: String,
                                   params: [String: Any] = [:],
                                   success: @escaping ([T?]) -> Void,
                                   failure: @escaping (Error, String) -> Void) -> DataRequest{
        return request(urlString: urlString, params: params, method: HTTPMethod.post, success: success, failure: failure)
    }


    @discardableResult
    public func request<T: HandyJSON>(urlString: String,
                                      params: [String: Any] = [:],
                                      method: HTTPMethod,
                                      encoding: ParameterEncoding = URLEncoding.default,
                                      success: @escaping (T) -> Void,
                                      failure: @escaping (Error, String) -> Void) -> DataRequest{
        
        var parameters = params
        if let access_token = WBUserAccont.shared.access_token{
            parameters["access_token"] = access_token
        }
        
        WBLog(["urlString": urlString, "parameters": parameters, "method": method.rawValue])

        
        return Alamofire.request(baseURL + urlString,
                                 method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: self.headers)
            .responseString { (response) in
                switch response.result {
                    case let .success(value):
                        let parseData: T? = self.parseJSON(value)
                        guard let data = parseData else {
                            let error = JSONError()
                            failure(error, error.localizedDescription)
                            return
                        }
                        success(data)
                        WBLog(["response": data.toJSON()])
                        break;
                    case let .failure(error):
                        failure(error, error.localizedDescription)
                        WBLog(["error": error.localizedDescription])
                        break;
                }
                

        }
    }
    
    @discardableResult
    public func request<T: HandyJSON>(urlString: String,
                                      params: [String: Any] = [:],
                                      method: HTTPMethod,
                                      encoding: ParameterEncoding = URLEncoding.default,
                                      success: @escaping ([T?]) -> Void,
                                      failure: @escaping (Error, String) -> Void) -> DataRequest{
        
        var parameters = params
        if let access_token = WBUserAccont.shared.access_token{
            parameters["access_token"] = access_token
        }
        
        WBLog(["urlString": urlString, "parameters": parameters, "method": method.rawValue])

        return Alamofire.request(baseURL + urlString,
                                 method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: self.headers)
            .responseString { (response) in
                
                switch response.result {
                    case let .success(value):
                        WBLog(response.result.value)
                        let parseData: [T?]? = self.parseJSONArray(value)
                        guard let data = parseData else {
                            let error = JSONError()
                            failure(error, error.localizedDescription)
                            WBLog(["error": error.localizedDescription])
                            return
                        }
                        success(data)
                        WBLog(["response": data])
                        break;
                    case let .failure(error):
                        failure(error, error.localizedDescription)
                        WBLog(["error": error.localizedDescription])

                        break;
                }
        }
    }
}

extension HttpClient {
    
    func parseJSON<T: HandyJSON>(_ jsonString: String?) -> T? {
        return T.deserialize(from: jsonString)
    }
    
    func parseJSONArray<T: HandyJSON>(_ jsonString: String?) -> [T?]? {
        return [T].deserialize(from: jsonString)
    }
}


public class JSONError: NSError {
    override public var localizedDescription: String {
        get {
            return "JSON转换失败"
        }
    }
    public convenience init() {
        self.init(domain: "JSONError", code: 10000, userInfo: nil)
    }
}
