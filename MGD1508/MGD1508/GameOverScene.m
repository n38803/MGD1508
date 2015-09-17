//
//  IAD1509
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "GameOverScene.h"
#import "MenuScene.h"
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
    play.text = @"[ Main Menu ]";
    play.zPosition = 100;
    play.name = @"Main Menu";
    play.fontColor = [UIColor blackColor];
    play.fontSize = 25;
    play.position = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame)-200);
    [self addChild:play];
    
    // Grab score from GameScene Class
    GameScene *lScore;
    int score = lScore.score;
    
    
    // Score Label
    _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, 150, 30)];
    _scoreLabel.font = [UIFont fontWithName:@"Arial" size:25.0];
    _scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
    [self.view addSubview:_scoreLabel];
    
    
    // Name Label
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 160, 50)];
    _nameLabel.text = @"Name: ";
    [self.view addSubview:_nameLabel];
    
    // Name Input
    _nameInput = [[UITextField alloc] initWithFrame:CGRectMake(40, 150, 170, 30)];
    _nameInput.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_nameInput];
    
    // PW Label
    _pwLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 160, 50)];
    _pwLabel.text = @"Password: ";
    [self.view addSubview:_pwLabel];
    
    // PW Input
    _pwInput = [[UITextField alloc] initWithFrame:CGRectMake(40, 250, 170, 30)];
    _pwInput.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_pwInput];
    
    // Submit / Cancel Buttons
    _sButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 300, 80, 30)];
    [_sButton setTitle:@"Submit" forState:UIControlStateNormal];
    [[_sButton layer] setBorderWidth:2.0f];
    [[_sButton layer] setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:_sButton];
    
    _cButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 300, 80, 30)];
    [_cButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [[_cButton layer] setBorderWidth:2.0f];
    [[_cButton layer] setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:_cButton];
    
    // Register button
    _rButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 350, 170, 30)];
    [_rButton setTitle:@"Register" forState:UIControlStateNormal];
    [[_rButton layer] setBorderWidth:2.0f];
    [[_rButton layer] setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:_rButton];
    
    
    // Test Parse Server
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"test";
    [testObject saveInBackground];
    
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    // if next button touched, start transition to next scene
    if ([node.name isEqualToString:@"Main Menu"]) {
        NSLog(@"Player opted to play again");
        
        [_scoreLabel removeFromSuperview];
         
        [_nameInput removeFromSuperview];
        [_pwInput removeFromSuperview];
        
        [_nameLabel removeFromSuperview];
        [_pwLabel removeFromSuperview];
        
        [_rButton removeFromSuperview];
        [_sButton removeFromSuperview];
        [_cButton removeFromSuperview];
        
        SKScene *myScene = [[MenuScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:myScene transition:transition];
    }
    
    
}


@end
