//
//  BookDisplayController.swift
//  MyLibrary
//
//  Created by haya on 2018/10/28.
//  Copyright © 2018年 haya. All rights reserved.
//

import UIKit

class BookDisplayController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    private let cellid = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .yellow
        
        collectionView?.register(BookDisplayCell.self, forCellWithReuseIdentifier: cellid)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! BookDisplayCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
}



