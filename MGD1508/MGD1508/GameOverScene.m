//
//  GameOverScene.m
//  MGD1508
//
//  Created by Shaun Thompson on 8/22/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"

@implementation GameOverScene

CGRect screenRect;
CGFloat screenHeight;
CGFloat screenWidth;


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */

    
    // Grab screen parameters
    screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    screenWidth = screenRect.size.width;
    
    // Background image
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"paperbackground"];
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    bgImage.zPosition = -50;
    bgImage.xScale = 1;
    bgImage.yScale = 1;
    [self addChild:bgImage];
    
    // Game Over Label
    SKLabelNode *gameOver = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    gameOver.text = @"GAME OVER";
    gameOver.zPosition = 100;
    gameOver.name = @"Game Over";
    gameOver.fontColor = [UIColor blackColor];
    gameOver.fontSize = 45;
    gameOver.position = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame)+200);
    [self addChild:gameOver];
    
    
    // Game Over Face
    SKSpriteNode *deadHero = [SKSpriteNode spriteNodeWithImageNamed:@"gameover"];
    deadHero.xScale = 1;
    deadHero.yScale = 1;
    deadHero.name = @"hero";
    deadHero.position = CGPointMake(CGRectGetMidX(self.frame),
                                 CGRectGetMidY(self.frame));
    [self addChild:deadHero];
    
    // Play Again Label
    SKLabelNode *play = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    play.text = @"[ Play Again ]";
    play.zPosition = 100;
    play.name = @"Play Again";
    play.fontColor = [UIColor blackColor];
    play.fontSize = 25;
    play.position = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame)-200);
    [self addChild:play];
    
    
    
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    // if next button touched, start transition to next scene
    if ([node.name isEqualToString:@"Play Again"]) {
        NSLog(@"Player opted to play again");
        
        SKScene *myScene = [[GameScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:myScene transition:transition];
    }
}


@end
