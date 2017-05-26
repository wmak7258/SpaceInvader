//
//  GameScene.swift
//  SpaceInvader
//
//  Created by student5 on 5/23/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var plane = SKSpriteNode()
   
    var fire = SKSpriteNode()
    
    var alien: SKSpriteNode!
    var nodeCounter = 0
    
    
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    
    var touchPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var touchingScreen = false
    
    override func didMove(to view: SKView) {
    
        plane = childNode(withName: "spaceShip") as! SKSpriteNode
        fire = SKSpriteNode(imageNamed: "shoot")
        leftButton = SKSpriteNode(imageNamed: "leftArrow")
        rightButton = SKSpriteNode(imageNamed: "rightArrow")
        alien = SKSpriteNode(imageNamed: "invader")
        
        fire.size = CGSize(width: 70, height: 70)
        leftButton.size = CGSize(width: 60, height: 60)
        rightButton.size = CGSize(width: 60, height: 60)
        alien.size = CGSize(width: 100, height: 100)
        fire.position = CGPoint(x: 100, y:85)
        addChild(fire)
        leftButton.position = CGPoint(x: 575, y: 85)
        addChild(leftButton)
        rightButton.position = CGPoint(x: 650, y: 85)
        addChild(rightButton)
        
        
    
        

        let alienWidth = alien.size.width
        let totalAlienWidth = alienWidth * CGFloat(5)
        let xOffset = (frame.width - totalAlienWidth)/2
        for i in 0..<5 {
            let alien = SKSpriteNode(imageNamed: "invader")
            alien.size = CGSize(width: 100, height: 100)
            alien.position = CGPoint(x: xOffset + CGFloat(CGFloat(i) + 0.5) * alienWidth, y: frame.height * 0.9)
            alien.physicsBody = SKPhysicsBody(rectangleOf: alien.frame.size)
            alien.physicsBody?.affectedByGravity = false
            alien.physicsBody?.allowsRotation = false
            alien.physicsBody?.isDynamic = false
            alien.zPosition = 2
            alien.name = "invader"
            alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
            alien.physicsBody?.affectedByGravity = false
            addChild(alien)
        }
        
        for i in 0..<5 {
            let alien = SKSpriteNode(imageNamed: "invader")
            alien.size = CGSize(width: 100, height: 100)
            alien.position = CGPoint(x: xOffset + CGFloat(CGFloat(i) + 0.5) * alienWidth, y: frame.height * 0.8)
            alien.physicsBody = SKPhysicsBody(rectangleOf: alien.frame.size)
            alien.physicsBody?.affectedByGravity = false
            alien.physicsBody?.allowsRotation = false
            alien.physicsBody?.isDynamic = false
            alien.zPosition = 2
            alien.name = "invader"
            alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
            alien.physicsBody?.affectedByGravity = false

            addChild(alien)
        }
        
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
    
    override func update(_ currentTime: CFTimeInterval) {
        if touchingScreen {
            let objects = nodes(at: touchPoint)
            if objects.contains(rightButton){
                // move character to the right.
                rightButton.color = UIColor.green
                let moveTOLeft = SKAction.moveBy(x: 10, y: 0, duration: 0.001)
                plane.run(moveTOLeft)
            }
            else if objects.contains(leftButton) {
                // move character to the left.
                leftButton.color = UIColor.green
                let moveTOLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.001)
                plane.run(moveTOLeft)
            }else if objects.contains(fire){
                shoot(node: plane)
            }
        }
        else { // if no touches.
            // move character back to middle of screen. Or just do nothing.
           
        }
    }
    
    func shoot(node: SKSpriteNode){
        let bullet = SKSpriteNode(color: UIColor.orange, size: CGSize(width: 15.0, height: 50.0))
        plane.physicsBody?.isDynamic = false
        bullet.position = plane.position
        bullet.zPosition = 2
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.isDynamic = false
        bullet.physicsBody?.affectedByGravity = false
        addChild(bullet)
        bullet.name = "bullet"
        let moveUp = SKAction.moveBy(x: 0, y: 1330, duration: 3)
        let fade = SKAction.fadeOut(withDuration: 3)
        let remove = SKAction.removeFromParent()
        let wait = SKAction.wait(forDuration: 1)
        let action = SKAction.sequence([moveUp,fade,remove,wait])
        bullet.run(action)
        
    }
}
