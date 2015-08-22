//
//  MenuScene.m
//  MGD1508
//
//  Created by Shaun Thompson on 8/21/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"

@implementation MenuScene

-(id)initWithSize:(CGSize)size
{

    return self;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    
    SKSpriteNode *button = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
    
    button.position = CGPointMake(CGRectGetMidX(self.frame),
                                  CGRectGetMidY(self.frame));
    button.name = @"brick";
    
    [self addChild:button];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    // if next button touched, start transition to next scene
    if ([node.name isEqualToString:@"brick"]) {
        NSLog(@"brick pressed");
        
        SKScene *myScene = [[GameScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:myScene transition:transition];
    }
}



@end
