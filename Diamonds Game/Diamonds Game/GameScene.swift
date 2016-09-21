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
    func setDiamonds(i : Int ,j : Int , x:Int) {
        
        switch x {
        case 1:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "1")
        case 2:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "2")
        case 3:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "3")
        case 4:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "4")
        case 5:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "5")
        default: print(0)
            
            
        }
        diamondsArray[i][j].size = CGSize(width: 50, height: 40)
        diamondsArraySTT[i][j] = x
        setPositionForDiamondsArray(i,j: j)
        addChild(diamondsArray[i][j])
    }
    
    func makeArray(){
        for i in 1..<6
        {
            for j in 1..<5
            {
                let x=radDiamonds()
                //diamondsArraySTT[i][j]  =   x
                setDiamonds(i, j: j, x: x)
            }
        }
    }
    
    
    func setPositionForDiamondsArray(i : Int , j : Int) {
        
        let dx = (self.frame.size.width-100)/4 * CGFloat(j)
        let dy = (self.frame.size.height-80)/5 * CGFloat(i)
        diamondsArray[i][j].position = CGPoint(x: dx, y: dy)
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
    
    func checkLetSwapOrNot(i1 : Int , j1 : Int , i2 : Int , j2 : Int) -> Bool{
        let x = abs(i1-i2) + abs(j1-j2)
        //if (diamondsArraySTT[i1][j1] == diamondsArraySTT[i2][j2]) {return true}
        if (x <= 1) {return false} else {return true}
    }
    
    func checkCanEatOrNot() -> Bool {
        
        var count = 0
        //check col
        for i in 1..<row{
            for j in 1..<col{
                if (diamondsArraySTT[i][j] != diamondsArraySTT[i][j-1]){
                    count = 1
                } else { count+=1 }
                if (count == 3) {
                    print(i," ",j)
                    return true
                    
                }
            }
        }
        
        count = 0
        
        // check row 
        for j in 1..<col{
            for i in 1..<row{
                if (diamondsArraySTT[i][j] != diamondsArraySTT[i-1][j]){
                    count = 1
                } else {count += 1}
                if (count == 3) {
                    print(i," ",j)
                    return true
                    
                }
            }
        }
        return false
    }
    
    func swap2Diamonds(i1 : Int, j1 : Int ,i2 :Int ,j2:Int) {
        //print("swap: ","{",i1,",",j1,"} ","{",i2,",",j2,"}")
        if ( checkLetSwapOrNot(i1, j1: j1, i2: i2, j2: j2) ){ return }
        
        
        //print("1 position: ", diamondsArray[i1][j1].position.x," ", diamondsArray[i1][j1].position.y)
        //print("2 position: ", diamondsArray[i2][j2].position.x," ", diamondsArray[i2][j2].position.y)
        
        let oldPosition1 : CGPoint
        oldPosition1 = diamondsArray[i1][j1].position
        let oldPosition2 : CGPoint
        oldPosition2 = diamondsArray[i2][j2].position
        //print("old position 1: ", oldPosition1)
        //print("old position 2: ", oldPosition2)
        
        //swap(&diamondsArray[i1][j1], &diamondsArray[i2][j2])
        
        //print("swap")
        let m = diamondsArray[i1][j1]
        diamondsArray[i1][j1] = diamondsArray[i2][j2]
        diamondsArray[i2][j2] = m
        //print("1 position: ", diamondsArray[i1][j1].position.x," ", diamondsArray[i1][j1].position.y)
        //print("2 position: ", diamondsArray[i2][j2].position.x," ", diamondsArray[i2][j2].position.y)
        
        //print("diamond1 move")
        let animationSwap1 = SKAction.runBlock{
            let diamondMove = SKAction.moveTo(oldPosition1, duration: 0.3)
            self.diamondsArray[i1][j1].runAction(SKAction.repeatActionForever(diamondMove))
        }
        
        //print("diamond2 move")
        let animationSwap2 = SKAction.runBlock{
            let diamondMove = SKAction.moveTo(oldPosition2, duration: 0.3)
            self.diamondsArray[i2][j2].runAction(SKAction.repeatActionForever(diamondMove))
        }
        
        let n = diamondsArraySTT[i1][j1]
        diamondsArraySTT[i1][j1] = diamondsArraySTT[i2][j2]
        diamondsArraySTT[i2][j2] = n
        
        
        let moveDiamond1 = SKAction.sequence([animationSwap1, SKAction.waitForDuration(0.1)])
        let moveDiamond2 = SKAction.sequence([animationSwap2, SKAction.waitForDuration(0.1)])
        
        self.runAction(moveDiamond1)
        self.runAction(moveDiamond2)
        //print("1 position: ", diamondsArray[i1][j1].position.x," ", diamondsArray[i1][j1].position.y)
        //print("2 position: ", diamondsArray[i2][j2].position.x," ", diamondsArray[i2][j2].position.y)
        //        diamondsArray[i1][j1].removeFromParent()
        //        diamondsArray[i2][j2].removeFromParent()
        //        setDiamonds(i1, j: j1, x: diamondsArraySTT[i1][j1])
        //        setDiamonds(i2, j: j2, x: diamondsArraySTT[i2][j2])
        
        
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
    
    override func didMoveToView(view: SKView) {
        print("didtomoveview")
        addBackground()
        makeArray()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
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
                   
                    self.swap2Diamonds(self.diamondChoseI, j1: self.diamondChoseJ, i2: self.diamondToI, j2: self.diamondToJ)
    
//                    print(checkCanEatOrNot())
//                    if (checkCanEatOrNot() == false){
//                        
//                        self.swap2Diamonds(self.diamondChoseI, j1: self.diamondChoseJ, i2: self.diamondToI, j2: self.diamondToJ)
//                    }
                    diamondChoseI=0
                    diamondChoseJ=0
                    diamondToI=0
                    diamondToJ=0
                    return
                }
            }
        }
        
    }
    
    //    override func update(currentTime: CFTimeInterval) {
    //        /* Called before each frame is rendered */
    //    }
}
