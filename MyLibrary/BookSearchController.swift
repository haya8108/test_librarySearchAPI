//
//  BookSearchController.swift
//  MyLibrary
//
//  Created by haya on 2018/10/28.
//  Copyright © 2018年 haya. All rights reserved.
//

import UIKit

class BookSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter book name"
        sb.barTintColor = .gray
        sb.delegate = self
        return sb
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .yellow
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        let navBar = navigationController?.navigationBar
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: (navBar?.topAnchor)!).isActive = true
        searchBar.leftAnchor.constraint(equalTo: (navBar?.leftAnchor)!).isActive = true
        searchBar.rightAnchor.constraint(equalTo: (navBar?.rightAnchor)!).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: (navBar?.bottomAnchor)!).isActive = true
        
        
    }
    
    
    
}
