//
//  ViewController.h
//  single101
//
//  Created by Manav Kataria on 12/3/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)buttonPressed:(UIButton *)sender;

@property (weak, nonatomic) UIButton *colorChangerButton;
@property (weak, nonatomic) UIButton *alphaRandomButton;

@end
