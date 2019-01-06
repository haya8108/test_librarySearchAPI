//
//  BookSearchTableVC.swift
//  MyLibrary
//
//  Created by haya on 2018/11/24.
//  Copyright © 2018年 haya. All rights reserved.
//

import Foundation
import UIKit

class BookSearchTableVC: UITableViewController, UISearchBarDelegate {
    
    var resultBooks = [Items]()
    
    let dmmyArray = ["book1","book2","book3","book4"]
    let cellId = "cellId"
    
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter book name"
        sb.barTintColor = .gray
        sb.delegate = self
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load BookSearchVC")
        NameToIsbn(searchKey: "Swift") { (result) in
            self.resultBooks = result
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }

        navigationItem.title = "Book Search"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        if let navBar = navigationController?.navigationBar {
        
            navBar.isTranslucent = false
            navBar.barTintColor = .orange
        
            navBar.addSubview(searchBar)
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.topAnchor.constraint(equalTo: navBar.topAnchor).isActive = true
            searchBar.leftAnchor.constraint(equalTo: navBar.leftAnchor, constant: 8).isActive = true
            searchBar.rightAnchor.constraint(equalTo: navBar.rightAnchor, constant: -8).isActive = true
            searchBar.bottomAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultBooks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = resultBooks[indexPath.row].volumeInfo.title
        cell.detailTextLabel?.text = resultBooks[indexPath.row].volumeInfo.authors[0]
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
      //  NameToIsbn(searchKey: searchBar.text!,completion: nil)
    }
    
    
    func NameToIsbn(searchKey: String, completion: @escaping([Items]) -> Void) {
        
        let url = URLRequest(url: URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(searchKey)&maxResults=2")!)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        
            var googleBook: [Items] = []
            
            let decoder = JSONDecoder()
            
            
            do {
                let decoded = try decoder.decode(GoogleBook.self, from: data!)
                    let items = decoded.items
                for item in items {
                    googleBook.append(item)
                }
            
                DispatchQueue.main.async(execute: {
                    () -> Void in completion(googleBook)
                })
            } catch {
                
            }
        }
        task.resume()
    }
    
    
    
    
    
}
