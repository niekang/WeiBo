//
//  TableViewDataSource.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/11.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

class TableViewDataSource<Model>: NSObject
    , UITableViewDelegate
, UITableViewDataSource{

    public var dataSource: [Model] = []
    
    public typealias ConfigCell = (IndexPath, Model, UITableView, TableViewDataSource<Model>) -> UITableViewCell
    public typealias HeightForRow = (IndexPath, Model, UITableView, TableViewDataSource<Model>) -> CGFloat
    public typealias willDisplayCell = (IndexPath, Model, UITableView, TableViewDataSource<Model>) -> Void
    public typealias ViewForHeader = (Int, TableViewDataSource<Model>) -> UIView
    public typealias ViewForFooter = (Int, TableViewDataSource<Model>) -> UIView
    public typealias HeightForHeader = (Int, TableViewDataSource<Model>) -> CGFloat
    public typealias HeightForFooter = (Int, TableViewDataSource<Model>) -> CGFloat

    
    open var configCell: ConfigCell?
    open var heightForRow: HeightForRow?
    open var viewForHeader: ViewForHeader?
    open var viewForFooter: ViewForFooter?
    open var heightForHeader: HeightForHeader?
    open var heightForFooter: HeightForFooter?
    open var willDisplayCell: willDisplayCell?

    public init(configCell: ConfigCell? = nil,
                heightForRow: HeightForRow? = nil,
                viewForHeader: ViewForHeader? = nil,
                viewForFooter: ViewForFooter? = nil,
                heightForHeader: HeightForHeader? = nil,
                heightForFooter: HeightForFooter? = nil
        ) {
        self.configCell = configCell
        self.heightForRow = heightForRow
        self.viewForHeader = viewForHeader
        self.viewForFooter = viewForHeader
        self.heightForHeader = heightForHeader
        self.heightForFooter = heightForFooter
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let heightForRow = self.heightForRow else {
            return tableView.rowHeight
        }
        return heightForRow(indexPath, self.dataSource[indexPath.row], tableView, self)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configCell = self.configCell else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "AdapterUITableViewCell")
            if(cell == nil) {
                cell = UITableViewCell(style: .default, reuseIdentifier: "AdapterUITableViewCell")
            }
            return cell!
        }
        return configCell(indexPath, self.dataSource[indexPath.row], tableView, self)
    }
    
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewForHeader?(section, self)
        
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.viewForFooter?(section, self)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.heightForHeader?(section, self) ?? 0
        
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.heightForFooter?(section, self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.willDisplayCell?(indexPath, self.dataSource[indexPath.row], tableView, self)
    }
}
