//
//  GameScene.swift
//  Diamonds Game
//
//  Created by hiepdz on 9/11/16.
//  Copyright (c) 2016 hiepdz. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var diamondChoseI : Int = 0
    var diamondChoseJ : Int = 0
    var diamondToI : Int = 0
    var diamondToJ : Int = 0
    
    var diamondsArray = Array(count: 7, repeatedValue: Array(count: 6, repeatedValue: SKSpriteNode(imageNamed: "1.png")))
    var diamondsArraySTT = Array(count: 7, repeatedValue: Array(count: 6, repeatedValue: -1))
    func radDiamonds() -> Int {
        return Int(arc4random_uniform(5)+1)
        //return 1
    }
    func setDiamonds(i : Int ,j : Int , x:Int) {
        
        switch x {
        case 1:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "1.png")
        // print(1)
        case 2:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "2.png")
        //  print(2)
        case 3:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "3.png")
        // print(3)
        case 4:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "4.png")
        case 5:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "5.png")
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
                                //
                
            }
        }
    }

    
    func setPositionForDiamondsArray(i : Int , j : Int) {
    
        let dx = (self.frame.size.width-100)/4 * CGFloat(j)
        let dy = (self.frame.size.height-80)/5 * CGFloat(i)
        diamondsArray[i][j].position = CGPoint(x: dx, y: dy)
       // print(dx," ",dy)
        
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder) is not used in this app")
//    }
//    override init(size: CGSize) {
//        super.init(size: size)
//        
//        anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        
//        let background = SKSpriteNode(imageNamed: "Backgroundemo.jpg")
//        background.size = size
//        addChild(background)
//    }
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
        if (x <= 1) {return false} else {return true}
    }
    
    func swap2Diamonds(i1 : Int, j1 : Int ,i2 :Int ,j2:Int) {
        if ( checkLetSwapOrNot(i1, j1: j1, i2: i2, j2: j2) ){ return }
        let oldPosition1 : CGPoint
        oldPosition1 = diamondsArray[i1][j1].position
        let oldPosition2 : CGPoint
        oldPosition2 = diamondsArray[i2][j2].position
        
        //swap(&diamondsArray[i1][j1], &diamondsArray[i2][j2])
        
        let animationSwap1 = SKAction.runBlock{
            let diamondMove = SKAction.moveTo(oldPosition1, duration: 0.3)
            self.diamondsArray[i1][j1].runAction(SKAction.repeatActionForever(diamondMove))
        }
        let animationSwap2 = SKAction.runBlock{
            let diamondMove = SKAction.moveTo(oldPosition2, duration: 0.3)
            self.diamondsArray[i2][j2].runAction(SKAction.repeatActionForever(diamondMove))
        }
 
        let m = diamondsArray[i2][j2]
        diamondsArray[i2][j2] = diamondsArray[i1][j1]
        diamondsArray[i1][j1] = m
        
        let n = diamondsArraySTT[i1][j1]
        diamondsArraySTT[i1][j1] = diamondsArraySTT[i2][j2]
        diamondsArraySTT[i2][j2] = n
        
        
        let moveDiamond1 = SKAction.sequence([animationSwap1, SKAction.waitForDuration(0.1)])
        let moveDiamond2 = SKAction.sequence([animationSwap2, SKAction.waitForDuration(0.1)])
        
        self.runAction(moveDiamond1)
        self.runAction(moveDiamond2)
//        diamondsArray[i1][j1].removeFromParent()
//        diamondsArray[i2][j2].removeFromParent()
//        setDiamonds(i1, j: j1, x: diamondsArraySTT[i1][j1])
//        setDiamonds(i2, j: j2, x: diamondsArraySTT[i2][j2])
        
        
    }
    override func didMoveToView(view: SKView) {
        print("didtomoveview")
        addBackground()
        makeArray()
        //swap2Diamonds(1, j1: 1, i2: 3, j2: 3)
       // addBackground()
        
    }
    //override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
            for touch in touches {
                let location = touch.locationInNode(self)
               
                let dxTouch = location.x
                let dyTouch = location.y
                print(dxTouch," ",dyTouch)
                for i in 1..<6 {
                    for j in 1..<5 {
                        let dx = diamondsArray[i][j].position.x + 50
                        let dy = diamondsArray[i][j].position.y + 40
                        let dxm = diamondsArray[i][j].position.x
                        let dym = diamondsArray[i][j].position.y
                        
                        if ((dxm<=dxTouch) && ( dym <= dyTouch) && (dyTouch<=dy) && (dxTouch<=dx)){
                            print(i," ",j)
                            diamondChoseI=i;
                            diamondChoseJ=j;
                            //swap2Diamonds(i, j1: j, i2: 1, j2: 1)
                            //swap(&diamondsArray[i][j], &diamondsArray[1][1])
//                            let t=diamondsArray[i][j]
//                            diamondsArray[i][j]=diamondsArray[1][1]
//                            diamondsArray[1][1]=t
                        }
                    }
                }
            }
        //        for touch in touches {
        //            let location = touch.locationInNode(self)
        //
        //            let sprite = SKSpriteNode(imageNamed:"Spaceship")
        //
        //            sprite.xScale = 0.5
        //            sprite.yScale = 0.5
        //            sprite.position = location
        //
        //            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        //
        //            sprite.runAction(SKAction.repeatActionForever(action))
        //
        //            self.addChild(sprite)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let location = touch!.locationInNode(self)
        let dxTouch = location.x
        let dyTouch = location.y
        print(dxTouch," ",dyTouch)
        for i in 1..<6 {
            for j in 1..<5 {
                let dx = diamondsArray[i][j].position.x + 50
                let dy = diamondsArray[i][j].position.y + 40
                let dxm = diamondsArray[i][j].position.x
                let dym = diamondsArray[i][j].position.y
                
                if ((dxm<=dxTouch) && ( dym <= dyTouch) && (dyTouch<=dy) && (dxTouch<=dx)){
                    print(i," ",j)
                    diamondToI=i;
                    diamondToJ=j;
                    swap2Diamonds(diamondChoseI, j1: diamondChoseJ, i2: diamondToI, j2: diamondToJ)
                    //swap(&diamondsArray[i][j], &diamondsArray[1][1])
                    //                            let t=diamondsArray[i][j]
                    //                            diamondsArray[i][j]=diamondsArray[1][1]
                    //                            diamondsArray[1][1]=t
                }
            }
        }
        diamondChoseI=0
        diamondChoseJ=0
        diamondToI=0
        diamondToJ=0
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
