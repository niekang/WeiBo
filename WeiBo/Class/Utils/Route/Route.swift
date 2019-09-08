//
//  Route.swift
//  WeiBo
//
//  Created by MC on 2019/9/8.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

enum WBURLRoute {
    
    case home
    case message
    case discover
    case mine
    
    var viewController: UIViewController {
        switch self {
        case .home:
            let vc = WBHomeViewController()
            return vc
            
        case .message:
            let vc = WBMessageViewController()
            return vc
            
        case .discover:
            let vc = WBDiscoverViewController()
            return vc
            
        case .mine:
            let vc = WBMineViewController()
            return vc
        }
    }
}




