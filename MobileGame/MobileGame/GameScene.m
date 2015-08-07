//
//  GameScene.m
//  MobileGame
//
//  Created by Shaun Thompson on 8/6/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    
    
    myLabel.text = @"It's Sticks!";
    myLabel.fontSize = 45;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   (CGRectGetMidY(self.frame)+100));
    [self addChild:myLabel];
    
    SKSpriteNode *hero = [SKSpriteNode spriteNodeWithImageNamed:@"Hero"];
    hero.xScale = 1;
    hero.yScale = 1;
    hero.position = CGPointMake(CGRectGetMidX(self.frame),
                                CGRectGetMidY(self.frame));
    [self addChild:hero];
    
    SKSpriteNode *fish = [SKSpriteNode spriteNodeWithImageNamed:@"Fish"];
    fish.xScale = 0.5;
    fish.yScale = 0.5;
    fish.position = CGPointMake((CGRectGetMidX(self.frame)-100),
                                CGRectGetMidY(self.frame));
    [self addChild:fish];
    
    SKSpriteNode *bee = [SKSpriteNode spriteNodeWithImageNamed:@"Bee"];
    bee.xScale = 0.5;
    bee.xScale = 0.5;
    bee.position = CGPointMake((CGRectGetMidX(self.frame)+100),
                               CGRectGetMidY(self.frame));
    [self addChild:bee];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    /*
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
     */
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
