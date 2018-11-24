//
//  BookDetailController.swift
//  MyLibrary
//
//  Created by haya on 2018/11/24.
//  Copyright © 2018年 haya. All rights reserved.
//

import Foundation
import UIKit

class BookDetailController: UITableViewController {
    
    var book: VolumeInfo?
    let header = "header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let isbns = book?.industryIdentifiers {
//
//            for isbn in isbns {
//                if isbn["type"] == "ISBN_10" {
//                    print(isbn["identifier"])
//                } else if isbn["type"] == "ISBN_13" {
//
//                } else { }
//
//            }
//            [["type": "ISBN_10", "identifier": "4873113911"], ["type": "ISBN_13", "identifier": "9784873113913"]]

     //   } else { print("isbn erro") }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: header)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: header, for: indexPath)
        cell.backgroundColor = .gray
        return cell
    }
    
}
