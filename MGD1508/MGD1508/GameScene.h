//
//  GameScene.h
//  MGD1508
//

//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>


@property SKSpriteNode *hero;
@property SKSpriteNode *bee;

@property CGPoint touchLocation;

@end
