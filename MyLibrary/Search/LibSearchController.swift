//
//  SearchLibController.swift
//  MyLibrary
//
//  Created by haya on 2018/11/17.
//  Copyright © 2018年 haya. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LibSearchController: UITableViewController, UISearchBarDelegate {
    
    var resultLibs = [Library]()
    let cellId = "cellId"
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.barTintColor = .gray
        sb.delegate = self
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        print(resultLibs)
        
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
        
        setupView()
        tableView.register(LibSearchCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    //MARK: main func
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let searchKey = searchBar.text else { return }
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
            
            if let unwarpPlacemarks = placemarks {
                
                if let firstPlacemark = unwarpPlacemarks.first {
                    
                    if let location = firstPlacemark.location {
                        
                        let targetCoordinate = location.coordinate
                 
                        self.geocodeToLib(longitude: targetCoordinate.longitude, latitude: targetCoordinate.latitude, completion: { (libs) in
                            
                            self.resultLibs = libs
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        })
                    }
                }
            }
        })
    }
    
    func geocodeToLib(longitude: CLLocationDegrees, latitude: CLLocationDegrees,  completion: @escaping([Library]) -> Void) {
        
        var libs: [Library] = []

        guard let url = URL(string: "https://api.calil.jp/library?appkey=91f355530e31cadbd7fdc2f165269fdf&geocode=\(longitude),\(latitude)&format=json&callback=") else { return }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, rsp, err) in

            do {
                if let data = data {
                    
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]]
                        else { return }
                    
                    for object in json {
                        if let library = try? Library(json: object) {
                            libs.append(library)
                        } else {
                            print("errow occur")
                        }
                    }
                }
                
                DispatchQueue.main.async(execute: {
                    () -> Void in completion(libs)
                })
                
            } catch {
                print( SerializationError.someError("something wrong"))
            }
            
        }).resume()
    }
    
    
    //MARK: view setup
    
    func setupView() {
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
    }
    
    //MARK: tableview
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultLibs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle , reuseIdentifier: cellId)
        cell.textLabel?.text = resultLibs[indexPath.row].formal
        cell.detailTextLabel?.text = resultLibs[indexPath.row].address
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
