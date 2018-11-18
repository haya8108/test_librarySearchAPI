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

struct Library {
    let libid: String
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json: [String : Any]) throws {
        guard let libid = json["libid"] as? String else { throw SerializationError.missing("libid is missing")}
    
        self.libid = libid
    }
    
}

class LibSearchController: UIViewController, UISearchBarDelegate {
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.barTintColor = .gray
        sb.delegate = self
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("searchLibController")
        
        setupView()
        
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
                      
                        self.geocodeToLib(location: targetCoordinate, longitude: targetCoordinate.longitude, latitude: targetCoordinate.latitude)
                        
                    }
                }
            }
        })
    }
    
    func geocodeToLib(location: CLLocationCoordinate2D,longitude: CLLocationDegrees, latitude: CLLocationDegrees) {
        
        let jsonUrlString = "https://api.calil.jp/library?appkey=91f355530e31cadbd7fdc2f165269fdf&geocode=\(longitude),\(latitude)&format=json&callback="
        
        guard let url = URL(string: jsonUrlString) else { return }
        

        URLSession.shared.dataTask(with: url, completionHandler: { (data, rsp, err) in

            do {
                if let data = data {

                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]]
                        else { return }
                    
                    for object in json {
                        if let libid = object["libid"] as? String,
                        let formal = object["formal"] as? String,
                            let post = object["post"] as? String,
                        let adress = object["address"] as? String,
                        let geocode = object["geocode"] as? String {
                            print(formal,post,adress,geocode,libid)
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
    
    
}
