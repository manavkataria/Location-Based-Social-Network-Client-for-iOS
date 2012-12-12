//
//  LoginViewController.h
//  talklocaldev
//
//  Created by Manav Kataria on 12/12/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) UIButton *authButton;
- (void)authButtonAction:(UIButton *)sender;

@property (strong, nonatomic) NSDictionary *me;

@end
