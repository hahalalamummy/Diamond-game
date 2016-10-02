//
//  GameOverScene.swift
//  Diamonds Game
//
//  Created by hiepdz on 10/2/16.
//  Copyright © 2016 hiepdz. All rights reserved.
//
import UIKit
import SpriteKit

class GameOverScene: SKScene {

    override init(size: CGSize ) {
        super.init(size: size )
        
        
        //1
        self.backgroundColor = SKColor.whiteColor()
        
        //        //2
        //        let message = "Game over"
        //
        //        //3
        var label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "High Score: " + String(score)
        label.fontSize = 35
        label.fontColor = SKColor.blackColor()
        label.position = CGPointMake(self.size.width/2, self.size.height-40)
        self.addChild(label)
        
        //2
        let replayMessage = "Tap to Replay"
        var replayButton = SKLabelNode(fontNamed: "Chalkduster")
        replayButton.text = replayMessage
        replayButton.fontColor = SKColor.blackColor()
        replayButton.position = CGPointMake(self.size.width/2, self.size.height / 2)
        replayButton.name = "replay"
        self.addChild(replayButton)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches {
            //            let location = touch.locationInNode(self)
            //            let node = self.nodeAtPoint(location) //1
            //            if node.name == "replay" { //2
            let reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = GameScene(size: self.view!.bounds.size)
            scene.scaleMode = .AspectFill
            self.view?.presentScene(scene, transition: reveal)
            //           }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
