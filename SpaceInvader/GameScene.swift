//
//  GameScene.swift
//  SpaceInvader
//
//  Created by student5 on 5/23/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    var plane = SKSpriteNode()
   
    var fire = SKSpriteNode()
    
    
    var alien: SKSpriteNode!
    var frontAlien: [SKSpriteNode?] = []
    var backAlien: [SKSpriteNode?] = []
    var alienCounter = 0
    
    
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var bullet = SKSpriteNode()
    var touchPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var touchingScreen = false
    
    var bulletYPoistion = 0
    var lastBullet: SKSpriteNode!
    
    override func didMove(to view: SKView) {

        physicsWorld.contactDelegate = self

        plane = childNode(withName: "spaceShip") as! SKSpriteNode
        fire = SKSpriteNode(imageNamed: "shoot")
        leftButton = SKSpriteNode(imageNamed: "leftArrow")
        rightButton = SKSpriteNode(imageNamed: "rightArrow")
        alien = SKSpriteNode(imageNamed: "invader")
        
        fire.size = CGSize(width: 70, height: 70)
        leftButton.size = CGSize(width: 60, height: 60)
        rightButton.size = CGSize(width: 60, height: 60)
        alien.size = CGSize(width: 100, height: 100)
      
        physicsWorld.gravity.dy = 0
        
        physicsWorld.contactDelegate = self
        
        
        
        fire.position = CGPoint(x: 100, y:85)
        addChild(fire)
        leftButton.position = CGPoint(x: frame.size.width - 175, y: 85)
        addChild(leftButton)
        rightButton.position = CGPoint(x: frame.size.width - 100, y: 85)
        addChild(rightButton)
        
        
        let moveDown = SKAction.moveBy(x: 0.0, y: -50.0, duration: 1.0)
        let wait = SKAction.wait(forDuration: 3.0)
        let alienAction = SKAction.sequence([moveDown,wait])
        let alienMovement = SKAction.repeatForever(alienAction)

        let alienWidth = alien.size.width
        let totalAlienWidth = alienWidth * CGFloat(5)
        let xOffset = (frame.width - totalAlienWidth)/2
        for i in 0..<5 {
            alien = SKSpriteNode(imageNamed: "invader")
            alien.size = CGSize(width: 100, height: 100)
            alien.position = CGPoint(x: xOffset + CGFloat(CGFloat(i) + 0.5) * alienWidth, y: frame.height * 0.9)
            alien.physicsBody = SKPhysicsBody(rectangleOf: alien.frame.size)
            alien.physicsBody?.affectedByGravity = false
            alien.physicsBody?.allowsRotation = false
            alien.physicsBody?.isDynamic = true
            alien.zPosition = 2
            alien.name = "invader front"

            addChild(alien)
            frontAlien.append(alien)
            alienCounter += 1
            alien.run(alienMovement)
            
        }
        
        for i in 0..<5 {
            alien = SKSpriteNode(imageNamed: "invader")
            alien.size = CGSize(width: 100, height: 100)
            alien.position = CGPoint(x: xOffset + CGFloat(CGFloat(i) + 0.5) * alienWidth, y: frame.height * 0.8)
            alien.physicsBody = SKPhysicsBody(rectangleOf: alien.frame.size)
            alien.physicsBody?.affectedByGravity = false
            alien.physicsBody?.allowsRotation = false
            alien.physicsBody?.isDynamic = true
            alien.zPosition = 2
            alien.name = "invader back"
            
            addChild(alien)
            backAlien.append(alien)
            alienCounter += 1
            alien.run(alienMovement)
        }
        let loseLine = SKSpriteNode(color: UIColor.red, size: CGSize(width: frame.size.width, height: 10.0))
        loseLine.position = CGPoint(x: frame.size.width / 2.0, y: 200)
        addChild(loseLine)
        
        print(alienCounter)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first!
        let point = touch.location(in: self)
        
        touchPoint = point
        touchingScreen = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchingScreen = false
    }
    
    func collisionBetween(bullet: SKNode, alien: SKNode) {
        destroy(bullet: bullet, alien: alien)
        if alienCounter == 0{
            win()
        }
       
    }
    
    func destroy(bullet: SKNode, alien: SKNode) {
        let fire = SKEmitterNode(fileNamed: "fire")
        fire?.position = alien.position
        fire?.zPosition = 2
        addChild(fire!)
        fire?.run(SKAction.sequence([SKAction.wait(forDuration:0.8), SKAction.fadeOut(withDuration: 1) ,SKAction.removeFromParent()]))
        bullet.removeFromParent()
        alien.removeFromParent()
        alienCounter -= 1
        if alien.name == "invader front" {
            //frontAlien.remove(at: <#T##Int#>)
        }else if alien.name == "invader back" {
            
        }
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "bullet" {
            collisionBetween(bullet: contact.bodyA.node!, alien: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "bullet" {
            collisionBetween(bullet: contact.bodyB.node!, alien: contact.bodyA.node!)
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        if alien.position.y <= 205.0 + (alien.size.height / 2){
            lose()
        }
        let count = self["bullet"].count
        
        if count != 0{
            bulletYPoistion = Int(lastBullet.position.y)

        }
        if touchingScreen {
            let objects = nodes(at: touchPoint)
            if objects.contains(rightButton) && plane.position.x <= (frame.width - (plane.size.width / 2)) {
                // move character to the right.
                rightButton.color = UIColor.green
                let moveTOLeft = SKAction.moveBy(x: 10, y: 0, duration: 0.001)
                
                plane.run(moveTOLeft)
            }
            else if objects.contains(leftButton) && plane.position.x >= (plane.size.width / 2) {
                // move character to the left.
                leftButton.color = UIColor.green
                let moveTOLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.001)
                plane.run(moveTOLeft)
            }else if objects.contains(fire){
                
                if count == 0 || lastBullet.position.y >= plane.position.y + 100{
                    lastBullet = shoot(node: plane, shoot: true)
                }
                
            }
        }
        else { // if no touches.
            // move character back to middle of screen. Or just do nothing.
           
        }
    }
    
    func shoot(node: SKSpriteNode, shoot: Bool) -> SKSpriteNode{

        let bullet = SKSpriteNode(color: UIColor.orange, size: CGSize(width: 15.0, height: 50.0))
        plane.physicsBody?.isDynamic = false
        bullet.position = plane.position
        bullet.zPosition = 2
        if(shoot){
            addChild(bullet)
        }
        
    
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.contactTestBitMask = bullet.physicsBody!.collisionBitMask
        bullet.physicsBody!.isDynamic = false
        bullet.physicsBody?.affectedByGravity = false
        
        bullet.name = "bullet"
        let remove = SKAction.removeFromParent()
        
        let moveUp = SKAction.moveTo(y: frame.size.height, duration: 3)
        let action = SKAction.sequence([moveUp, remove])
        bullet.run(action)

        return bullet
        
    }
    
    func win(){
        let winLabel = SKLabelNode(text: "You Win")
        winLabel.color = UIColor.white
        winLabel.fontSize = 40
        winLabel.position = CGPoint(x: 375.0, y: 665.0)
        addChild(winLabel)
    }
    
    func lose(){
        let loseLabel = SKLabelNode(text: "You Lose")
        loseLabel.color = UIColor.white
        loseLabel.fontSize = 40
        loseLabel.position = CGPoint(x: 375.0, y: 665.0)
        addChild(loseLabel)
    }
}
