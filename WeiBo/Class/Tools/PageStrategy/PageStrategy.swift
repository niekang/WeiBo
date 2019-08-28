//
//  PageStrategy.swift
//  WeiBo
//
//  Created by MC on 2019/8/27.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

protocol PageStrategy {
    
    associatedtype Item
    
    func addPage(_ items: [Item])
    
    func resetPage()
    
    func checkNoMoreData() -> Bool
    
}


class PageDataManager<T: BaseModel>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    typealias ConfigCellClousure = (Int, T) -> UITableViewCell
    typealias ConfigCellHeightClousure = (Int, T) -> CGFloat

    private(set) var dataSource = [T]() {
        didSet {
           
        }
    }
    
    private var configsCellClousures = [ConfigCellClousure]()
    private var configsCellHeightClousures = [ConfigCellHeightClousure]()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init() {
        super.init()
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.configsCellHeightClousures[indexPath.row](indexPath.row, self.dataSource[indexPath.row])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.configsCellClousures[indexPath.row](indexPath.row, self.dataSource[indexPath.row])
    }
    
}

extension PageDataManager {
    
    
    func addPage(_ items: [T]) {
        
    }
    
    func resetPage() {
        
    }
    
    func checkNoMoreData() -> Bool {
        return false
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func configCell(_ config: @escaping ConfigCellClousure) {
        self.configsCellClousures.append(config)
    }
    
    func heightForRow(_ config: @escaping ConfigCellHeightClousure) {
        self.configsCellHeightClousures.append(config)
    }
}
