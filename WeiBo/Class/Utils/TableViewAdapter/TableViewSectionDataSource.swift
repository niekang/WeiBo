//
//  TableViewSectionDataSource.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/11.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

public protocol SectionModelType {
    
    associatedtype Section
    associatedtype Item
    
    var section: Section {get}
    var items: [Item] {get}
    
    init(section: Section, items: [Item])
}

public struct SectionModel<SectionType, ItemType>: SectionModelType {
    
    public typealias Section = SectionType
    public typealias Item = ItemType
    
    public var section: SectionType
    public var items: [ItemType]
    
    public init(section: SectionType, items: [ItemType]) {
        self.section = section
        self.items = items
    }
}


open class TableViewSectionDataSource<Section: SectionModelType>: NSObject
    , UITableViewDelegate
, UITableViewDataSource{
    
    public var dataSource: [Section] = []
    
    public typealias Item = Section.Item

    public typealias ConfigCell = (IndexPath, Item, UITableView, TableViewSectionDataSource<Section>) -> UITableViewCell
    public typealias HeightForRow = (IndexPath, Item, UITableView, TableViewSectionDataSource<Section>) -> CGFloat
    public typealias ViewForHeader = (Int, TableViewSectionDataSource<Section>) -> UIView
    public typealias ViewForFooter = (Int, TableViewSectionDataSource<Section>) -> UIView
    public typealias HeightForHeader = (Int, TableViewSectionDataSource<Section>) -> CGFloat
    public typealias HeightForFooter = (Int, TableViewSectionDataSource<Section>) -> CGFloat

    
    open var configCell: ConfigCell?
    open var heightForRow: HeightForRow?
    open var viewForHeader: ViewForHeader?
    open var viewForFooter: ViewForFooter?
    open var heightForHeader: HeightForHeader?
    open var heightForFooter: HeightForFooter?

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
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let heightForRow = self.heightForRow else {
            return tableView.rowHeight
        }
        return heightForRow(indexPath, self.dataSource[indexPath.section].items[indexPath.row], tableView, self)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configCell = self.configCell else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "AdapterUITableViewCell")
            if(cell == nil) {
                cell = UITableViewCell(style: .default, reuseIdentifier: "AdapterUITableViewCell")
            }
            return cell!
        }
        return configCell(indexPath, self.dataSource[indexPath.section].items[indexPath.row], tableView, self)
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
}
