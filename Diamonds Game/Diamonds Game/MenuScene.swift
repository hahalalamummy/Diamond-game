//
//  MenuScene.swift
//  Diamonds Game
//
//  Created by hiepdz on 10/2/16.
//  Copyright © 2016 hiepdz. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    let level1Button = SKSpriteNode(imageNamed: "StartButton")
    override init(size: CGSize ) {
        super.init(size: size )
        
        let background = SKSpriteNode(imageNamed: "menuGame")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPointZero
        background.size = size
        addChild(background)
        
        
        level1Button.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addChild(level1Button)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
//        for touch: AnyObject in touches {
//            //            let location = touch.locationInNode(self)
//            //            let node = self.nodeAtPoint(location) //1
//            //            if node.name == "replay" { //2
//            let reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
//            let scene = GameScene(size: self.view!.bounds.size)
//            scene.scaleMode = .AspectFill
//            self.view?.presentScene(scene, transition: reveal)
//            //           }
//        }
        let touch = touches.first
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if touchedNode == level1Button {
            let reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = GameScene(size: self.view!.bounds.size)
            scene.scaleMode = .AspectFill
            self.view?.presentScene(scene, transition: reveal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
