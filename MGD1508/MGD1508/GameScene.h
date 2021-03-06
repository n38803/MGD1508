//
//  IAD1509
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>


@property SKSpriteNode *hero;
@property SKSpriteNode *bee;
@property NSMutableArray *cTextures;
@property SKLabelNode *pause;
@property SKLabelNode *play;
@property (nonatomic, readwrite) int score;

@property CGPoint touchLocation;

@end
