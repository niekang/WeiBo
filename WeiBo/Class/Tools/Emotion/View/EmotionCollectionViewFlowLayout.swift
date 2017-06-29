//
//  EmotionCollectionViewFlowLayout.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/29.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class EmotionCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        
        itemSize = collectionView.bounds.size
        
        scrollDirection = .horizontal
    }

}
