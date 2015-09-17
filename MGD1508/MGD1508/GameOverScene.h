//
//  IAD1509
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Parse/Parse.h>

@interface GameOverScene : SKScene

@property UILabel *scoreLabel;

@property UILabel *nameLabel;
@property UILabel *pwLabel;

@property UITextField *nameInput;
@property UITextField *pwInput;

@property UIButton *rButton;
@property UIButton *sButton;
@property UIButton *cButton;

@property NSString *username;
@property NSString *password;

@property int finalScore;

@end
