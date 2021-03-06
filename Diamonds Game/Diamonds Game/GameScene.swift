//
//  GameScene.swift
//  Diamonds Game
//
//  Created by hiepdz on 9/11/16.
//  Copyright (c) 2016 hiepdz. All rights reserved.
//

import SpriteKit
import AVFoundation
import UIKit

class GameScene: SKScene  {
    struct locaXY {
        var x : Int
        var y : Int
    }
    let row = 7
    let col = 6
    var diamondChoseI : Int = 0
    var diamondChoseJ : Int = 0
    var diamondToI : Int = 0
    var diamondToJ : Int = 0
    
  //  var score = 0;
    
    var Q = Array(count: 300, repeatedValue: locaXY(x: -1, y: -1))
    
    var diamondsArray = Array(count: 8, repeatedValue: Array(count: 7, repeatedValue: SKSpriteNode(imageNamed: "1.png")))
    
    var diamondsArraySTT = Array(count: 8, repeatedValue: Array(count: 7, repeatedValue: -1))
    var ddDiamonds = Array(count: 8, repeatedValue: Array(count: 7, repeatedValue: false))
    func radDiamonds() -> Int {
        return Int(arc4random_uniform(6))
        //return 1
    }
    
    func setImageOfDiamonds(numberOfImage : Int , i : Int , j : Int, i0 : String ,  i1 : String , i2 : String , i3 : String , i4 : String , i5 :String)  {
        let x = numberOfImage
        print(x)
        switch x {
        case 0:
            diamondsArray[i][j].texture = SKTexture(imageNamed: i0)
            
        case 1:
            diamondsArray[i][j].texture = SKTexture(imageNamed: i1)
            
        case 2:
            diamondsArray[i][j].texture = SKTexture(imageNamed: i2)
            
        case 3:
            diamondsArray[i][j].texture = SKTexture(imageNamed: i3)
            
        case 4:
            diamondsArray[i][j].texture = SKTexture(imageNamed: i4)
            
        case 5:
            diamondsArray[i][j].texture = SKTexture(imageNamed: i5)
            
        default: print(0)
            
            
        }
        
    }
    func setDiamonds(i : Int ,j : Int) {
        let x=radDiamonds()
        // setImageOfDiamonds(x, i: i, j: j, i1: "1", i2: "2", i3: "3", i4: "4", i5: "5")
        
        switch x {
        case 0:
            diamondsArray[i][j] = SKSpriteNode(imageNamed: "bomb")
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
        for i in 1..<row
        {
            for j in 1..<col
            {
                
                //diamondsArraySTT[i][j]  =   x
                setDiamonds(i, j: j)
                setPositionForDiamondsArray(i,j: j)
                addChild(diamondsArray[i][j])
            }
        }
     
    }
    
    
    func setPositionForDiamondsArray(i : Int , j : Int) {
        
        let dx = (self.frame.size.width-55)/5 * CGFloat(j)
        let dy = (self.frame.size.height-70)/6 * CGFloat(i)
        //diamondsArray[i][j].position = CGPoint(x: dx, y: dy)
        self.diamondsArray[i][j].runAction(SKAction.moveTo(CGPoint.init(x: dx, y: dy), duration: 0.3))
        //print(dx," ",dy," ","{",i,",",j,"}")
        
    }
    
    func addBackground() {
        //1
        let background = SKSpriteNode(imageNamed: "Background")
        
        //2
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPointZero
        background.size = size
        //3
        addChild(background)
    }
    
    var scoreLabel: SKLabelNode!
    
    func addLabelScore()  {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .Left
        scoreLabel.position = CGPoint(x:10 , y:self.size.height-30)
        scoreLabel.fontColor = UIColor.blackColor()
        scoreLabel.fontSize = 23
        addChild(scoreLabel)
        
        
    }
    //timer
    
    var timer = NSTimer()
    var counter:Int = -1
    var timeLabel : SKLabelNode!
    var previousScore : Int = -1
    
    func startTimer()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0
            , target: self, selector: #selector(GameScene.updateTimer(_:)), userInfo: nil, repeats: true)
    }
    
    func updateTimer(dt:NSTimer)
    {
        counter -= 1
        if (counter == -1) {
            previousScore = score
            counter = 10
        }
        if (score > previousScore){
            previousScore = score
            counter = 10
        }
        
        if counter==0{
//            
//            timer.invalidate()
//            removeCountDownTimerView()

            
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = GameOverScene(size: self.size)
           // let scene = GameOverScene(size :
            self.view?.presentScene(scene, transition: reveal)
            
        } else{
            
            timeLabel.text = "Time : " + "\(counter)"
        }
    }
    
    func removeCountDownTimerView()
    {
        scene!.view!.paused = true
    }
    
    
    
    
    
    func addLabelTimer()  {
        timeLabel = SKLabelNode(fontNamed: "Chalkduster")
        timeLabel.text = "Time : 10"
        timeLabel.horizontalAlignmentMode = .Right
        timeLabel.position = CGPoint(x:self.size.width-10, y:self.size.height-30)
        timeLabel.fontColor = UIColor.blackColor()
        timeLabel.fontSize = 23
        addChild(timeLabel)
    }
    
    func playBackGroundMusic() {
        let backGroundMusic = SKAudioNode(fileNamed: "Mining by Moonlight.mp3")
        backGroundMusic.autoplayLooped = true
        addChild(backGroundMusic)
    }
    
    override func didMoveToView(view: SKView) {
        print("didtomoveview")
        addBackground()
        makeArray()
        addLabelScore()
        addLabelTimer()
        playBackGroundMusic()
        startTimer()
        
//        if !self.checkLetorNot() {
//            let skView = self.view! as SKView
//            let gameScene = GameScene(size: skView.frame.size)
//            skView.presentScene(gameScene)
//        }
    }
    
    
    
    
    
    //-----------------------------------------------------------------------//
    
    
    
    
    
    
    func checkLetSwapOrNot(i1 : Int , j1 : Int , i2 : Int , j2 : Int) -> Bool{
        let x = abs(i1-i2) + abs(j1-j2)
        //if (diamondsArraySTT[i1][j1] == diamondsArraySTT[i2][j2]) {return true}
        if (x <= 1) {return true} else {return false}
    }
    
    
    // if can eat return true else false
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
                    //   print(i," ",j)
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
                    // print(i," ",j)
                    return true
                    
                }
            }
        }
        return false
    }
    
    func eatDiamondSTT() {
        var count = 1
        //check col
        for i in 1..<row{
            count = 1
            for j in 2..<col+1{
                if (diamondsArraySTT[i][j] != diamondsArraySTT[i][j-1]){
                    if (count>=3) {
                        for k in (j-count)..<j{
                            // delete [i][k]
                            diamondsArraySTT[i][k] = -1
                            
                            //print("score : " , score)
                            //                            print("okWhenTouchBegan : ", okWhenTouchBegan)
                            //                            print(i, " " ,j)
                            //                            print(1)
                        }
                        okWhenTouchBegan += 1
                        score += (count-2) * okWhenTouchBegan
                        //                        print("score : ", score)
                        //                        print("okWhenTouchBegan : " , okWhenTouchBegan)
                        //                        //  print(i, " " ,j)
                        //                        print("count: ",count )
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
                            //print("score : ", score)
                            //                            print("okWhenTouchBegan : " , okWhenTouchBegan)
                            //                            print(i, " " ,j)
                            //                            print(2)
                        }
                        okWhenTouchBegan += 1
                        score += (count-2) * okWhenTouchBegan
                        //                        print("score : ", score)
                        //                        print("okWhenTouchBegan : " , okWhenTouchBegan)
                        //                        print("count: ",count )
                        
                    }
                    count = 1
                } else { count += 1 }
            }
        }
    }
    
    //afrer swaping check eat
    func eatDiamonds() {
    
        for i in 1..<row {
            for j in 1..<col {
                if diamondsArraySTT[i][j] == -1 {
                    //diamondsArray[i][j].removeFromParent()
                    //diamondsArray[i][j].runAction(SKAction.hide())
                    diamondsArray[i][j].runAction(SKAction.fadeOutWithDuration(0.3))
                }
            }
        }
   }
    
    func swap2Diamonds(i1 : Int, j1 : Int ,i2 :Int ,j2:Int) {
        
        let m = diamondsArray[i1][j1]
        diamondsArray[i1][j1] = diamondsArray[i2][j2]
        diamondsArray[i2][j2] = m
                setPositionForDiamondsArray(i1, j: j1)
        setPositionForDiamondsArray(i2, j: j2)
     
        
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
        var x=radDiamonds()

        setImageOfDiamonds(x, i: i, j: j,i0 : "bomb" , i1: "1", i2: "2", i3: "3", i4: "4", i5: "5")
        
        diamondsArray[i][j].size = CGSize(width: 50, height: 40)
        diamondsArraySTT[i][j] = x
    }
    
    func playSound(){
        let play = SKAction.playSoundFileNamed("Chomp.wav", waitForCompletion: false)
        
        self.runAction(play)
    }
    
    func playBombSound(x: CGPoint) {
        let play = SKAction.playSoundFileNamed("Explosion.wav", waitForCompletion: false)
        self.runAction(play)
        let explosionEmitterNode = SKEmitterNode(fileNamed:"explosion.sks")
        explosionEmitterNode!.position = x
        addChild(explosionEmitterNode!)
        
    }
    
    func playNewArraySound() {
        let play = SKAction.playSoundFileNamed("newArray.wav", waitForCompletion: false)
        
        self.runAction(play)
    }
    
    func changeDiamondsFromNormalToHighlighted(i : Int , j : Int)  {
        let x = diamondsArraySTT[i][j]
        setImageOfDiamonds(x, i: i, j: j, i0 : "bomb" , i1: "1hl", i2: "2hl", i3: "3hl", i4: "4hl", i5: "5hl")
        
    }
    
    func changeDiamondsFormHighlightedToNormal(i : Int , j :Int)  {
        let x = diamondsArraySTT[i][j]
        setImageOfDiamonds(x, i: i, j: j, i0 : "bomb" , i1: "1", i2: "2", i3: "3", i4: "4", i5: "5")
        
    }
    
    var okWhenTouchBegan = 0 ;
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        time = 0.3
        diamondChoseI=0
        diamondChoseJ=0
        diamondToI=0
        diamondToJ=0
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
                       for i in 1..<row {
                for j in 1..<col {
                    if touchedNode == diamondsArray[i][j] {
                        print("tocuhesBegan",i," ",j)
                        print("diamondsArraySTT[i][j] = ",diamondsArraySTT[i][j])
                        changeDiamondsFromNormalToHighlighted(i, j: j)
                        okWhenTouchBegan = 0
                        diamondChoseI=i;
                        diamondChoseJ=j;
                        
                    }
                }
            }
        }
    }
    
    func swapArray2Diamonds(i1 : Int,j1 : Int,i2 : Int,j2 : Int ) {
        let m = diamondsArraySTT[i1][j1]
        diamondsArraySTT[i1][j1] = diamondsArraySTT[i2][j2]
        diamondsArraySTT[i2][j2] = m
    }
    
    func checkLetorNotSwapArray2Diamonds(i1 : Int,j1 : Int,i2 : Int,j2 : Int) ->Bool {
        swapArray2Diamonds(i1, j1: j1, i2: i2, j2: j2)
        if (checkCanEatOrNot()) {
            swapArray2Diamonds(i1, j1: j1, i2: i2, j2: j2)
            return true
        } else {
            swapArray2Diamonds(i1, j1: j1, i2: i2, j2: j2)
            return false
        }
    }
    
    // kiem tra xem co nuoc di hay khong
    func checkLetorNot() -> Bool {
        for i in 1..<row {
            for j in 1..<col{
                if checkLetorNotSwapArray2Diamonds(i, j1: j, i2: i+1, j2: j){
                    return true
                }
                if checkLetorNotSwapArray2Diamonds(i, j1: j, i2: i, j2: j+1){
                    return true
                }
                
                
            }
        }
        return false
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
                
                eatDiamondSTT()
                
                //self.runAction(swap)
                let delete = SKAction.runBlock{
                    self.eatDiamonds()
                }
                let playSound = SKAction.runBlock{
                    self.playSound()
                }
                let drop = SKAction.runBlock{
                    self.dropDiamond()
                }
                let checkIsThereValidMove = SKAction.runBlock{
                    if !self.checkLetorNot() {
                        self.playNewArraySound()
                        let skView = self.view! as SKView
                        let gameScene = GameScene(size: skView.frame.size)
                        skView.presentScene(gameScene)
                    }
                }
                self.runAction(SKAction.sequence([swap,SKAction.waitForDuration(0.32),delete,playSound,SKAction.waitForDuration(0.32),drop,SKAction.waitForDuration(1),checkIsThereValidMove]))
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
    
    var time: Double = 0.3
    
    
    func explode(i: Int, j: Int) {
        time -= 0.1
        ddDiamonds[i][j] = false
        score += 1
        for i2 in (i-1)...(i+1) {
            for j2 in (j-1)...(j+1) {
                
                if (( diamondsArraySTT[i2][j2] == 0) && (ddDiamonds[i2][j2]))  {
                    explode(i2, j: j2)
                }
                diamondsArraySTT[i2][j2] = -1;
                
            }
        }
        time += 0.1
        let delete = SKAction.runBlock{
            self.eatDiamonds()
        }
        let playSound = SKAction.runBlock{
            self.playBombSound(self.diamondsArray[i][j].position)
        }
        let drop = SKAction.runBlock{
            self.dropDiamond()
        }
        let checkIsThereValidMove = SKAction.runBlock{
            if !self.checkLetorNot() {
                self.playNewArraySound()
                let skView = self.view! as SKView
                let gameScene = GameScene(size: skView.frame.size)
                skView.presentScene(gameScene)
            }
        }
        self.runAction(SKAction.sequence([SKAction.waitForDuration(0.3-time),delete,playSound,SKAction.waitForDuration(0.3),drop,SKAction.waitForDuration(1),checkIsThereValidMove]))
    }
 
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
   
        //print(dxTouch," ",dyTouch)
        for i in 1..<row {
            for j in 1..<col {
                if touchedNode == diamondsArray[i][j] {
                    print("touchesEnded",i," ",j)
                    print("diamondsArraySTT[i][j] = ",diamondsArraySTT[i][j])
                    diamondToI=i
                    diamondToJ=j
                    
                    
                    if diamondChoseI == diamondToI && diamondChoseJ == diamondToJ && diamondsArraySTT[diamondToI][diamondToJ] == 0 {
                        for i1 in 1..<row {
                            for j1 in 1..<col {
                                ddDiamonds[i1][j1]=true
                            }
                        }
                       
                        explode(diamondToI,j: diamondToJ)
                        return
                    }
                    
                    changeDiamondsFormHighlightedToNormal(diamondChoseI, j: diamondChoseJ)
                    run()
                    scoreLabel.text = "Score :" + String(score)
                    return
                }
            }
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if checkCanEatOrNot() {
            
            eatDiamondSTT()
            //self.runAction(swap)
            let delete = SKAction.runBlock{
                self.eatDiamonds()
            }
            let playSound = SKAction.runBlock{
                self.playSound()
            }
            let drop = SKAction.runBlock{
                self.dropDiamond()
            }
            let label = SKAction.runBlock{
                self.scoreLabel.text = "Score :" + String(score)
            }
            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.5),delete,playSound,SKAction.waitForDuration(0.32),drop,SKAction.waitForDuration(0.1),label]))
            
        }
        if score >= 20 {
            let reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = ChangeToLevel2Scene(size: self.view!.bounds.size)
            scene.scaleMode = .AspectFill
            self.view?.presentScene(scene, transition: reveal)
        }
    }
}
