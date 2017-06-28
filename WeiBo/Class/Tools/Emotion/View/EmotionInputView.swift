
//
//  EmotionInputView.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/28.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class EmotionInputView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolView: UIView!
    
    /// 加载并且返回输入视图
    class func inputView() -> EmotionInputView {
        
        let nib = UINib(nibName: "EmotionInputView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! EmotionInputView
        
        return v
    }
    
    override func awakeFromNib() {
//        let nib = UINib(nibName: "", bundle: nil)
//        collectionView.register(<#T##nib: UINib?##UINib?#>, forCellWithReuseIdentifier: <#T##String#>)
        frame = CGRect(x: 0, y: 0, width: kWidth, height: 253)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "sss")
    }
}

extension EmotionInputView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return EmotionManager.shared.packages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sss", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
}
