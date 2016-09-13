//
//  GameScene.swift
//  Diamonds Game
//
//  Created by hiepdz on 9/11/16.
//  Copyright (c) 2016 hiepdz. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
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
        setPositionForDiamondsArray(i,j: j)
        addChild(diamondsArray[i][j])

    }
    
    func makeArray(){
        
        for i in 1..<6
        {
            for j in 1..<5
            {
                let x=radDiamonds()
                
                
                diamondsArraySTT[i][j]  =   x
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
    func swap2Diamonds(i1 : Int, j1 : Int ,i2 :Int ,j2:Int) {
        let m = diamondsArraySTT[i1][j1]
        diamondsArraySTT[i1][j1] = diamondsArraySTT [i2][j2]
        diamondsArraySTT[i2][j2] = m
        diamondsArray[i1][j1].removeFromParent()
        diamondsArray[i2][j2].removeFromParent()
        setDiamonds(i1, j: j1, x: diamondsArraySTT[i1][j1])
        setDiamonds(i2, j: j2, x: diamondsArraySTT[i2][j2])
        
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
                            swap2Diamonds(i, j1: j, i2: 1, j2: 1)
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
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    }
