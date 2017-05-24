//
//  GameScene.swift
//  SpaceInvader
//
//  Created by student5 on 5/23/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var plane = SKSpriteNode()
   
    var fire = SKSpriteNode()
    
    var alien: SKSpriteNode!
    
    var fireLabel: SKLabelNode!
    
    
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    
    var touchPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var touchingScreen = false
    
    override func didMove(to view: SKView) {
        fireLabel = SKLabelNode(text: "Fire")
        fireLabel.color = UIColor.red
        fireLabel.position = CGPoint(x: 575 - (fireLabel.frame.width / 2), y: 75.0)
        addChild(fireLabel)
        
        
        plane = childNode(withName: "spaceShip") as! SKSpriteNode
        fire = SKSpriteNode(imageNamed: "shoot")
        leftButton = SKSpriteNode(imageNamed: "leftArrow")
        rightButton = SKSpriteNode(imageNamed: "rightArrow")
        alien = SKSpriteNode(imageNamed: "invader")
        
        fire.size = CGSize(width: 60, height: 60)
        leftButton.size = CGSize(width: 60, height: 60)
        rightButton.size = CGSize(width: 60, height: 60)
        alien.size = CGSize(width: 100, height: 100)
        
        fire.position = CGPoint(x: 100, y:85)
        addChild(fire)
        leftButton.position = CGPoint(x: 575, y: 85)
        addChild(leftButton)
        rightButton.position = CGPoint(x: 650, y: 85)
        addChild(rightButton)
        alien.position = CGPoint(x: 375, y: 1200)
        addChild(alien)
        
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
            }else if objects.contains(fireLabel){
                
            }
        }
        else { // if no touches.
            // move character back to middle of screen. Or just do nothing.
            rightButton.color = UIColor.red
            leftButton.color = UIColor.red
        }
    }
    
    func shoot(node: SKSpriteNode){
        
    }
}
