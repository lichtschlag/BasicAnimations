//
//  BAViewController.h
//  BasicAnimations
//
//  Created by Leonhard Lichtschlag on 29/Nov/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *doItButton;
@property (retain) CALayer * carLayer;
@property (retain) CALayer * carLayer2;

- (IBAction)doIt:(id)sender;

@end
