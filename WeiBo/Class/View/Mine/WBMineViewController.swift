//
//  WBMineViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/19.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBMineViewController: BaseSectionTableViewController<SectionModel<Any, Any>>, VisitorViewProtocol {
    
    var visitorView = VisitorView(frame: CGRect(x: 0, y: kNavHeight, width: kWidth, height: kHeight - kNavHeight - kTabBarHeight))
    
    let headerView = WBMineHeaderView.loadNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView.target = self
        setUI()
        configTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension WBMineViewController {
    
    func configTable() {
        self.dataSource = [
            SectionModel(section: 0, items: []),
        ]
        
        self.viewForHeader = { section, _, _ in
            return self.headerView
        }
        
        self.heightForHeader = { section, _, _ in
            return self.headerView.height
        }
    }
    
    func setUI() {
        self.tableView.backgroundColor = GrayBGColor
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 10))
        self.tableView.tableFooterView = UIView()
        
        self.headerView.frame = CGRect(x: 0, y: 100, width: kWidth, height: 140)
        self.view.addSubview(self.headerView)
        
        self.headerView.iconView.layer.cornerRadius = self.headerView.iconView.width * 0.5
        self.headerView.iconView.layer.masksToBounds = true
        if let avatar = WBUserAccont.shared.profile_image_url,
            let url = URL(string: avatar) {
            /// 设置用户头像
            self.headerView.iconView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "avatar_default_big"))
        }
        self.headerView.nameLabel.text = WBUserAccont.shared.screen_name
        
        let titles = ["微博", "关注", "粉丝"]
        let btnWidth = kWidth/CGFloat(titles.count)
        let rect = CGRect(x: 0, y: 80, width: btnWidth, height: 60)
        for (index, value) in titles.enumerated() {
            let btn = WBMineHeaderButton.loadNib()
            btn.frame = rect.offsetBy(dx: CGFloat(index) * btnWidth, dy: 0)
            btn.titleLabel.text = "0"
            btn.detailLabel.text = value
            self.headerView.addSubview(btn)
        }
        
    }
}
