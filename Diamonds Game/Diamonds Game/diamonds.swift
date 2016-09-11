//
//  diamonds.swift
//  Diamonds Game
//
//  Created by hiepdz on 9/11/16.
//  Copyright © 2016 hiepdz. All rights reserved.
//

import Foundation

import SpriteKit

enum DiamondsType: Int {
    case Unknown = 0, di1 , di2, di3, di4, di5
}

class diamonds {
    var column: Int
    var row: Int
    let diamondsType: DiamondsType
    var sprite: SKSpriteNode?
    
    init(column: Int, row: Int, diamondsType: DiamondsType) {
        self.column = column
        self.row = row
        self.diamondsType = diamondsType
    }
}


