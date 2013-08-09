//
//  ViewController.h
//  AttriLabel
//
//  Created by Chandu on 8/5/13.
//  Copyright (c) 2013 Fab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"

@interface ViewController : UIViewController<OHAttributedLabelDelegate>
@property (weak, nonatomic) IBOutlet UILabel *mAttriLabel;

@end
