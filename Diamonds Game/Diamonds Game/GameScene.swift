//
//  GameScene.swift
//  Diamonds Game
//
//  Created by hiepdz on 9/11/16.
//  Copyright (c) 2016 hiepdz. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    struct locaXY {
        var x : Int
        var y : Int
    }
    let row=6
    let col = 5
    var diamondChoseI : Int = 0
    var diamondChoseJ : Int = 0
    var diamondToI : Int = 0
    var diamondToJ : Int = 0
    
    var Q = Array(count: 300, repeatedValue: locaXY(x: -1, y: -1))
    
    var diamondsArray = Array(count: 7, repeatedValue: Array(count: 6, repeatedValue: SKSpriteNode(imageNamed: "1.png")))
    
    var diamondsArraySTT = Array(count: 7, repeatedValue: Array(count: 6, repeatedValue: -1))
    func radDiamonds() -> Int {
        return Int(arc4random_uniform(5)+1)
        //return 1
    }
    func setDiamonds(i : Int ,j : Int) {
        let x=radDiamonds()
        switch x {
        case 1:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "1")
            //diamondsArray[i][j].texture = SKTexture(imageNamed: "1")
        case 2:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "2")
            //diamondsArray[i][j].texture = SKTexture(imageNamed: "2")
        case 3:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "3")
            //diamondsArray[i][j].texture = SKTexture(imageNamed: "3")
        case 4:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "4")
            //diamondsArray[i][j].texture = SKTexture(imageNamed: "4")
        case 5:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "5")
            //diamondsArray[i][j].texture = SKTexture(imageNamed: "5")
        default: print(0)
            
            
        }
        diamondsArray[i][j].size = CGSize(width: 50, height: 40)
        diamondsArraySTT[i][j] = x
    }
    
    func makeArray(){
        for i in 1..<6
        {
            for j in 1..<5
            {
                
                //diamondsArraySTT[i][j]  =   x
                setDiamonds(i, j: j)
                setPositionForDiamondsArray(i,j: j)
                addChild(diamondsArray[i][j])
            }
        }
        
//        for i in 1..<6
//        {
//            for j in 1..<5
//            {
//                
//                //diamondsArraySTT[i][j]  =   x
//                setDiamonds(i, j: j)
//                setPositionForDiamondsArray(i,j: j)
//                //addChild(diamondsArray[i][j])
//            }
//        }
    }
    
    
    func setPositionForDiamondsArray(i : Int , j : Int) {
        
        let dx = (self.frame.size.width-100)/4 * CGFloat(j)
        let dy = (self.frame.size.height-80)/5 * CGFloat(i)
        //diamondsArray[i][j].position = CGPoint(x: dx, y: dy)
        self.diamondsArray[i][j].runAction(SKAction.moveTo(CGPoint.init(x: dx, y: dy), duration: 0.3))
        //print(dx," ",dy," ","{",i,",",j,"}")
        
    }
    
    func addBackground() {
        //1
        let background = SKSpriteNode(imageNamed: "backgroundemo.jpg")
        
        //2
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPointZero
        background.size = size
        //3
        addChild(background)
    }
    
    override func didMoveToView(view: SKView) {
        print("didtomoveview")
        addBackground()
        makeArray()
        if checkCanEatOrNot() {
            //self.runAction(swap)
            let delete = SKAction.runBlock{
                self.eatDiamonds()
            }
            let drop = SKAction.runBlock{
                self.dropDiamond()
            }
            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.8),delete,SKAction.waitForDuration(0.32),drop]))
        }
    }
    
    
    
    
    
    //-----------------------------------------------------------------------//
    
    
    
    
    
    
    
    
    func checkLetSwapOrNot(i1 : Int , j1 : Int , i2 : Int , j2 : Int) -> Bool{
        let x = abs(i1-i2) + abs(j1-j2)
        //if (diamondsArraySTT[i1][j1] == diamondsArraySTT[i2][j2]) {return true}
        if (x <= 1) {return true} else {return false}
    }
    
    func checkCanEatOrNot() -> Bool {
        
        var count = 0
        //check col
        for i in 1..<row{
            count = 0
            for j in 1..<col{
                if (diamondsArraySTT[i][j] == diamondsArraySTT[i][j-1] && diamondsArraySTT[i][j] != -1){
                    count += 1
                } else { count = 1 }
                
                if (count >= 3) {
                    print(i," ",j)
                    return true
                    
                }
            }
        }
        
        
        // check row 
        for j in 1..<col{
            count = 0
            for i in 1..<row{
                if (diamondsArraySTT[i][j] == diamondsArraySTT[i-1][j] && diamondsArraySTT[i][j] != -1){
                    count += 1
                } else { count = 1 }
                if (count >= 3) {
                    print(i," ",j)
                    return true
                    
                }
            }
        }
        return false
    }
    
    //afrer swaping check eat
    func eatDiamonds() {
        var count = 1
        var dau = 0
        var cuoi = 0
        //check col
        for i in 1..<row{
            count = 1
            for j in 2..<col+1{
                if (diamondsArraySTT[i][j] != diamondsArraySTT[i][j-1]){
                    if (count>=3) {
                        for k in (j-count)..<j{
                            // delete [i][k]
                            diamondsArraySTT[i][k] = -1
                        }
                    }
                    count = 1
                } else { count += 1 }
                
            }
        }
        
        //check row
        for j in 1..<col{
            count = 1
            for i in 2..<row+1{
                if (diamondsArraySTT[i][j] != diamondsArraySTT[i-1][j]){
                    if (count>=3) {
                        for k in (i-count)..<i{
                            // delete [k][j]
                            diamondsArraySTT[k][j] = -1
                        }
                    }
                    count = 1
                } else { count += 1 }
            }
        }
        count = 0
        
        for i in 1..<row {
            for j in 1..<col {
                if diamondsArraySTT[i][j] == -1 {
                    //diamondsArray[i][j].removeFromParent()
                    //diamondsArray[i][j].runAction(SKAction.hide())
                    diamondsArray[i][j].runAction(SKAction.fadeOutWithDuration(0.3))
                }
            }
        }
        
//        for i in 1..<row{
//            var k = col
//            dau = 1
//            cuoi = 0
//            var xx = 0
//            var yy = 0
//            while (k>1)
//            {
//                if (diamondsArraySTT[i][k] == -1) {
//                    //count += 1
//                    cuoi += 1
//                    Q[cuoi] = locaXY(x: i, y: k)
//                } else{
//                    // count -= 1
//                    if (dau<=cuoi){
//                        swap2Diamonds(i, j1: k, i2: Q[dau].x, j2: Q[dau].y)
//                        // oldPos = locaXY(x: Q[dau].x, y: Q[dau].y-1)
//                        xx = Q[dau].x
//                        yy = Q[dau].y - 1
//                        dau += 1
//                        
//                    } else {
//                        //                        swap2Diamonds(i, j1: k, i2: oldPos.x, j2: oldPos.y)
//                        //                        oldPos = locaXY(x: oldPos.x, y: oldPos.y-1)
//                        swap2Diamonds(i, j1: k, i2: xx, j2: yy)
//                        yy -= 1
//                    }
//                    
//                }
//                k -= 1
//            }
//            
//            
//        }
        
        
    }
    
    func swap2Diamonds(i1 : Int, j1 : Int ,i2 :Int ,j2:Int) {
        //print("swap: ","{",i1,",",j1,"} ","{",i2,",",j2,"}")
//        if ( checkLetSwapOrNot(i1, j1: j1, i2: i2, j2: j2) ){ return }
        
        
        //print("1 position: ", diamondsArray[i1][j1].position.x," ", diamondsArray[i1][j1].position.y)
        //print("2 position: ", diamondsArray[i2][j2].position.x," ", diamondsArray[i2][j2].position.y)
        
//        let oldPosition1 : CGPoint
//        oldPosition1 = diamondsArray[i1][j1].position
//        let oldPosition2 : CGPoint
//        oldPosition2 = diamondsArray[i2][j2].position
        //print("old position 1: ", oldPosition1)
        //print("old position 2: ", oldPosition2)
        
        //swap(&diamondsArray[i1][j1], &diamondsArray[i2][j2])
        
        //print("swap")
        let m = diamondsArray[i1][j1]
        diamondsArray[i1][j1] = diamondsArray[i2][j2]
        diamondsArray[i2][j2] = m
        //print("1 position: ", diamondsArray[i1][j1].position.x," ", diamondsArray[i1][j1].position.y)
        //print("2 position: ", diamondsArray[i2][j2].position.x," ", diamondsArray[i2][j2].position.y)
        
        setPositionForDiamondsArray(i1, j: j1)
        setPositionForDiamondsArray(i2, j: j2)
        //print("1 position: ", diamondsArray[i1][j1].position.x," ", diamondsArray[i1][j1].position.y)
        //print("2 position: ", diamondsArray[i2][j2].position.x," ", diamondsArray[i2][j2].position.y)
        //        diamondsArray[i1][j1].removeFromParent()
        //        diamondsArray[i2][j2].removeFromParent()
        //        setDiamonds(i1, j: j1, x: diamondsArraySTT[i1][j1])
        //        setDiamonds(i2, j: j2, x: diamondsArraySTT[i2][j2])
        
        
    }
    
    func dropDiamond() {
        let a = SKAction.runBlock {
            for j in 1..<self.col {
                for i in 1..<self.row {
                    if self.diamondsArraySTT[i][j] == -1 {
                        for k in i+1..<self.row {
                            if self.diamondsArraySTT[k][j] != -1 {
                                swap(&self.diamondsArraySTT[k][j], &self.diamondsArraySTT[i][j])
                                self.swap2Diamonds(k, j1: j, i2: i, j2: j)
                                break
                            }
                        }
                    }
                }
            }
        }
        let b = SKAction.runBlock {
            for i in 1..<self.row {
                for j in 1..<self.col {
                    if self.diamondsArraySTT[i][j] == -1 {
                        self.changeDiamonds(i, j: j)
                        self.diamondsArray[i][j].runAction(SKAction.fadeInWithDuration(0.3))
                    }
                }
            }
        }
        self.runAction(SKAction.sequence([a,SKAction.waitForDuration(0.32),b]))
    }
    
    func changeDiamonds(i : Int ,j : Int) {
        let x=radDiamonds()
        switch x {
        case 1:
            //diamondsArray[i][j] = SKSpriteNode(imageNamed: "1")
            diamondsArray[i][j].texture = SKTexture(imageNamed: "1")
        case 2:
            //diamondsArray[i][j] = SKSpriteNode(imageNamed: "2")
            diamondsArray[i][j].texture = SKTexture(imageNamed: "2")
        case 3:
            //diamondsArray[i][j] = SKSpriteNode(imageNamed: "3")
            diamondsArray[i][j].texture = SKTexture(imageNamed: "3")
        case 4:
            //diamondsArray[i][j] = SKSpriteNode(imageNamed: "4")
            diamondsArray[i][j].texture = SKTexture(imageNamed: "4")
        case 5:
            //diamondsArray[i][j] = SKSpriteNode(imageNamed: "5")
            diamondsArray[i][j].texture = SKTexture(imageNamed: "5")
        default: print(0)
            
            
        }
        diamondsArray[i][j].size = CGSize(width: 50, height: 40)
        diamondsArraySTT[i][j] = x
    }
    
    func playSound(i: Int){
        let play: SKAction
        switch i {
        case 3:
            // ăn 3
            play = SKAction.playSoundFileNamed("", waitForCompletion: false)
        case 4:
            //ăn 4
            play = SKAction.playSoundFileNamed("", waitForCompletion: false)
        case 5:
            //ăn 5
            play = SKAction.playSoundFileNamed("", waitForCompletion: false)
        default:
            return
        }
        self.runAction(play)
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        diamondChoseI=0
        diamondChoseJ=0
        diamondToI=0
        diamondToJ=0
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let dxTouch = location.x
            let dyTouch = location.y
            //print(dxTouch," ",dyTouch)
            for i in 1..<6 {
                for j in 1..<5 {
                    let dx = diamondsArray[i][j].position.x + 50
                    let dy = diamondsArray[i][j].position.y + 40
                    let dxm = diamondsArray[i][j].position.x
                    let dym = diamondsArray[i][j].position.y
                    
                    if ((dxm<=dxTouch) && ( dym <= dyTouch) && (dyTouch<=dy) && (dxTouch<=dx)){
                        print("tocuhesBegan",i," ",j)
                        diamondChoseI=i;
                        diamondChoseJ=j;
                        
                    }
                }
            }
        }
    }
    
    func run() {
        if checkLetSwapOrNot(diamondChoseI, j1: diamondChoseJ, i2: diamondToI, j2: diamondToJ) {
            let m = diamondsArraySTT[diamondChoseI][diamondChoseJ]
            diamondsArraySTT[diamondChoseI][diamondChoseJ] = diamondsArraySTT[diamondToI][diamondToJ]
            diamondsArraySTT[diamondToI][diamondToJ] = m
            
            if checkCanEatOrNot() {
                let swap = SKAction.runBlock{
                    self.swap2Diamonds(self.diamondChoseI, j1: self.diamondChoseJ, i2: self.diamondToI, j2: self.diamondToJ)
                }
                //self.runAction(swap)
                let delete = SKAction.runBlock{
                    self.eatDiamonds()
                }
                let drop = SKAction.runBlock{
                    self.dropDiamond()
                }
                self.runAction(SKAction.sequence([swap,SKAction.waitForDuration(0.32),delete,SKAction.waitForDuration(0.32),drop]))
                
            }
            else {
                let swap = SKAction.runBlock{
                    self.swap2Diamonds(self.diamondChoseI, j1: self.diamondChoseJ, i2: self.diamondToI, j2: self.diamondToJ)
                }
                let swapBack = SKAction.runBlock{
                    self.swap2Diamonds(self.diamondToI, j1: self.diamondToJ, i2: self.diamondChoseI, j2: self.diamondChoseJ)
                }
                self.runAction(SKAction.sequence([swap,SKAction.waitForDuration(0.32),swapBack]))
                let m = diamondsArraySTT[diamondChoseI][diamondChoseJ]
                diamondsArraySTT[diamondChoseI][diamondChoseJ] = diamondsArraySTT[diamondToI][diamondToJ]
                diamondsArraySTT[diamondToI][diamondToJ] = m
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let location = touch!.locationInNode(self)
        let dxTouch = location.x
        let dyTouch = location.y
        //print(dxTouch," ",dyTouch)
        for i in 1..<6 {
            for j in 1..<5 {
                let dx = diamondsArray[i][j].position.x + 50
                let dy = diamondsArray[i][j].position.y + 40
                let dxm = diamondsArray[i][j].position.x
                let dym = diamondsArray[i][j].position.y
                
                if ((dxm<=dxTouch) && ( dym <= dyTouch) && (dyTouch<=dy) && (dxTouch<=dx)){
                    print("touchesEnded",i," ",j)
                    diamondToI=i;
                    diamondToJ=j;
                    
                    run()
                    return
                }
            }
        }
        
    }
    
//    override func update(currentTime: CFTimeInterval) {
//        /* Called before each frame is rendered */
//        
//    }
}
