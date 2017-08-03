//
//  CellData.swift
//  talkRobot
//
//  Created by niweiguo on 03/08/2017.
//  Copyright © 2017 Ftc. All rights reserved.
//

import Foundation
enum Member {
    case robot
    case you
}
struct CellData {
    var headImage: String
    var whoSays: Member
    var saysWhat: String
    
    
}
