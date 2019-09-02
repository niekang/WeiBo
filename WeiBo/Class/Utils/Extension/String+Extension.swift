//
//  String+Extension.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/23.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import Foundation

extension String {
    
    
    /// 从微博返回的html中提取链接
    func wb_htmlHref() -> (link:String, text:String)?{
        
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        
        guard let regular = try? NSRegularExpression(pattern: pattern, options:  []) ,
            let result = regular.firstMatch(in: self, options: [], range: NSMakeRange(0, count)) else {
            return ("","")
        }

        let link = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))

        return (link,text)
    }

}
