//
//  diamonds.swift
//  Diamonds Game
//
//  Created by hiepdz on 9/11/16.
//  Copyright © 2016 hiepdz. All rights reserved.
//

import Foundation

import SpriteKit

enum DiamondsType: Int ,CustomStringConvertible {
    case Unknown = 0 , di1 , di2 , di3 , di4 , di5
    var spriteName: String {
        let spriteNames = [
            "di1",
            "di2",
            "di3",
            "di4",
            "di5"]
        
        return spriteNames[rawValue - 1]
    }
    
//    var highlightedSpriteName: String {
//        return spriteName + "-Highlighted"
//    }
    var description: String{
        return spriteName
    }
    static func radom() -> DiamondsType{
        return DiamondsType(rawValue : Int(arc4random_uniform(5)+1))!
    }

}

//class Diamonds : CustomStringConvertible , Hashable {
//    var column: Int
//    var row: Int
//    let diamondsType: DiamondsType
//    var sprite: SKSpriteNode?
//    
//    init(column: Int, row: Int, diamondsType: DiamondsType) {
//        self.column = column
//        self.row = row
//        self.diamondsType = diamondsType
//    }
//    var description: String {
//        return "type:\(diamondsType) square:(\(column),\(row)"
//    }
//    var hasValue :Int{
//        return row*10+column
//    }
//    
//}

