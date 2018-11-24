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
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.barTintColor = .gray
        sb.delegate = self
        return sb
    }()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("searchLibController")
        
        setupView()
        tableView.register(LibSearchCell.self, forCellReuseIdentifier: cellId)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let searchKey = searchBar.text else { return }
        
        let geocoder = CLGeocoder()
        
        // 入力された文字から位置情報を取得(6)
        geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
            
            // 位置情報が存在する場合はunwarpPlacemarksに取り出す(7)
            if let unwarpPlacemarks = placemarks {
                
                // 1件目の情報を取り出す(8)
                if let firstPlacemark = unwarpPlacemarks.first {
                    
                    // 位置情報を取り出す(9)
                    if let location = firstPlacemark.location {
                        
                        // 位置情報から緯度経度をtargetCoordinateに取り出す(10)
                        let targetCoordinate = location.coordinate
                      
                        self.geocodeToLib(longitude: targetCoordinate.longitude, latitude: targetCoordinate.latitude)
                        
                    }
                }
            }
        })
    }
    
    func geocodeToLib(longitude: CLLocationDegrees, latitude: CLLocationDegrees) {
        
        var libraries: [Library] = []
        
        guard let url = URL(string: "") else { return }
        

        URLSession.shared.dataTask(with: url, completionHandler: { (data, rsp, err) in

            do {
                if let data = data {

                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]]
                        else { return }
                    
                    for object in json {
                        if let library = try? Library(json: object) {
                            libraries.append(library)
                        }
                    }
                
                
                }
                
            } catch {
                print( SerializationError.someError("something wrong"))
            }
            
        }).resume()
        
        
    }
    
    func setupView() {
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
