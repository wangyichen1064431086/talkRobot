//
//  CellData.swift
//  talkRobot
//
//  Created by niweiguo on 03/08/2017.
//  Copyright © 2017 Ftc. All rights reserved.
//
import UIKit
import Foundation
enum Member {
    case robot
    case you
    case no
}
struct CellData {
    var headImage: String = ""
    var whoSays: Member = .no
    var saysWhat: String = ""
    
}
