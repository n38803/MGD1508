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
    
    // background image
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    bgImage.xScale = 2;
    bgImage.yScale = 2;
    [self addChild:bgImage];
    
    // title on screen (this was a test, will be removed in alpha version)
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = @"It's Sticks!";
    myLabel.fontSize = 45;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   (CGRectGetMidY(self.frame)+100));
    [self addChild:myLabel];
    
    // hero sprite node assignment
    SKSpriteNode *hero = [SKSpriteNode spriteNodeWithImageNamed:@"Hero"];
    hero.xScale = 1;
    hero.yScale = 1;
    hero.name = @"hero";
    hero.position = CGPointMake(CGRectGetMidX(self.frame),
                                CGRectGetMidY(self.frame));
    
    [self addChild:hero];
    
    // fish sprite node assignment
    SKSpriteNode *fish = [SKSpriteNode spriteNodeWithImageNamed:@"Fish"];
    fish.xScale = 0.5;
    fish.yScale = 0.5;
    fish.name = @"fish";
    
    fish.position = CGPointMake((CGRectGetMidX(self.frame)-100),
                                CGRectGetMidY(self.frame));
    [self addChild:fish];
    
    // bee sprite node assignment
    SKSpriteNode *bee = [SKSpriteNode spriteNodeWithImageNamed:@"Bee"];
    bee.xScale = 0.5;
    bee.xScale = 0.5;
    bee.name = @"bee";
    bee.position = CGPointMake((CGRectGetMidX(self.frame)+100),
                               CGRectGetMidY(self.frame));
    [self addChild:bee];
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        
        // define location of user touch
        CGPoint location = [touch locationInNode:self];

        // determine if user touch is equivelant to node location
        SKNode *node = [self nodeAtPoint:location];
        
        // play sound corresponding with appropriate node
        if ([node.name isEqualToString:@"hero"]) {
            [node runAction:[SKAction playSoundFileNamed:@"grunt.mp3" waitForCompletion:NO]];
        }
        else if ([node.name isEqualToString:@"fish"]){
            [node runAction:[SKAction playSoundFileNamed:@"glub.mp3" waitForCompletion:NO]];
        }
        else if ([node.name isEqualToString:@"bee"]){
            [node runAction:[SKAction playSoundFileNamed:@"insect.mp3" waitForCompletion:NO]];
        }

    }  
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}






@end
