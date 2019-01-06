//
//  GoogleBook.swift
//  MyLibrary
//
//  Created by haya on 2018/11/24.
//  Copyright © 2018年 haya. All rights reserved.
//

import Foundation

struct  GoogleBook: Codable {
    let items: [Items]
}

struct Items: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let industryIdentifiers: [[String : String]]
}

