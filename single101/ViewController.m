//
//  ViewController.m
//  single101
//
//  Created by Manav Kataria on 12/3/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.alphaRandomButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    self.alphaRandomButton.frame = CGRectMake(120, 100, 80, 44);
    
    self.colorChangerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.colorChangerButton.frame = CGRectMake(120, 200, 80, 44);
    
    [self.alphaRandomButton setTitle:@"Tap me!" forState:UIControlStateNormal];
    [self.alphaRandomButton setTitle:@"Ouch!" forState:UIControlStateHighlighted];

    [self.colorChangerButton setTitle:@"Make Blue!" forState:UIControlStateNormal];
    [self.colorChangerButton setTitle:@"Blued!" forState:UIControlStateHighlighted];

    [self.view addSubview:self.alphaRandomButton];
    [self.view addSubview:self.colorChangerButton];
    
    [self.alphaRandomButton addTarget:self action:@selector(buttonPressed:)
                    forControlEvents:UIControlEventTouchUpInside];
    [self.colorChangerButton addTarget:self action:@selector(buttonPressed:)
                     forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonPressed:(UIButton *)sender
{
    NSLog(@"Button pressed, sender: %@", sender);

    if ([sender isEqual:self.colorChangerButton]) {
        self.view.backgroundColor = [UIColor blueColor];
    } else {
        self.view.alpha = ((double)arc4random() / 0x100000000);
    }
}


- (void)loadView
{
    CGRect viewRect = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:viewRect];
    self.view = view;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches Ended");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
