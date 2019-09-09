//
//  File.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/10.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

protocol NibLoadable {}

extension NibLoadable where Self: UIView {
    
    static func loadNib(_ nibName: String? = nil) -> Self {
        let name = nibName == nil ? "\(self)" : nibName!
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as! Self
    }
}

extension NibLoadable where Self : UIViewController {
    static func loadFromStoryboard(_ name: String? = nil, with identifier: String? = nil) -> Self {
        
        let loadName = name == nil ? "\(self)" : name!
        guard let id = identifier else {
            return UIStoryboard(name: loadName, bundle: nil).instantiateInitialViewController() as! Self
        }
        
        return UIStoryboard(name: loadName, bundle: nil).instantiateViewController(withIdentifier: id) as! Self
    }
}

extension UIViewController: NibLoadable {}

extension UIView: NibLoadable {}

