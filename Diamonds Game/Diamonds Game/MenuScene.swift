//
//  MenuScene.swift
//  Diamonds Game
//
//  Created by hiepdz on 10/2/16.
//  Copyright © 2016 hiepdz. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        addMenuScene()
        addButtons()
    }
    let background = SKSpriteNode(imageNamed: "menuGame")
    private func addMenuScene(){
        
        //1
        
        
        //2
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPointZero
        background.size = size
        //3
        addChild(background)
        
    }
     let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    private func addButtons() {
       
        button.backgroundColor = .greenColor()
        button.setTitle("Test Button", forState: .Normal)
        button.addTarget(self, action: #selector(startGame), forControlEvents: .TouchUpInside)
        
        self.view!.addSubview(button)
        
    }
    
    @objc private func startGame() {
        button.removeFromSuperview()
        background.removeFromParent()
        let gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
        
    }
}
