//
//  LibSearchCell.swift
//  MyLibrary
//
//  Created by haya on 2018/11/19.
//  Copyright © 2018年 haya. All rights reserved.
//

import Foundation
import UIKit



class LibSearchCell: UITableViewCell {

    let infoLaber: UILabel = {
        let label = UILabel()
        label.text = "lib info"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        backgroundColor = .lightBlue
        
        addSubview(infoLaber)
        infoLaber.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
}
