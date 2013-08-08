//
//  ViewController.m
//  AttriLabel
//
//  Created by Chandu on 8/5/13.
//  Copyright (c) 2013 Fab. All rights reserved.
//

#import "ViewController.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+HTML.h"
#import "NSAttributedString+Attributes.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

#define k_LinkColor [UIColor colorWithRed:.35 green:.61 blue:.88 alpha:1.0]


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    OHAttributedLabel *mLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectInset(self.view.bounds, 10, 10)];
    mLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:mLabel];
    
    NSString *htmlStr = nil;
    htmlStr = @"<h2>OHAttributed Label</h2> <h3>Hello, this is a new Paragraph and <a href=\"http://google.com/\">ClickMe!</a></h3> <p style=\"font-size:14px; color:#538b01; font-weight:bold; font-style:italic;\"> Enter the competition by <span style=\"color: #ff0000\">January 30, 2011</span> http://google.com and you could win up to $$$$ — including amazing <span style=\"color: #0000a0\">summer</span>trips!</p>";
    NSData *htmlData = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"html"];
//    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
    
    
    
    NSMutableAttributedString *mAttributedContent = nil;
        
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:2];
        if (![htmlData isKindOfClass:[NSNull class]])
        {
            [options setObject:@"Helvetica" forKey:DTDefaultFontFamily];
            [options setObject:[NSNumber numberWithFloat:14.0f] forKey:DTDefaultFontSize];
            mAttributedContent = [[NSMutableAttributedString alloc] initWithHTML:htmlData options:nil documentAttributes:NULL];
        }
        else
        {
            mAttributedContent = [[NSMutableAttributedString alloc] initWithString:@""];
        }
    
    
    [self detectLinksInAttributedString:mAttributedContent];
    
    [mLabel setAttributedText:mAttributedContent];
}


- (BOOL)detectLinksInAttributedString:(NSMutableAttributedString *)attributedString
{
    BOOL detected = NO;
    NSString *plainText = [attributedString string];
    NSMutableString *str = [NSMutableString string];
    
    if(plainText)
    {
        //AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        //NSDataDetector* linkDetector = appDelegate.dataDetector;
        NSError *error = nil;
        NSDataDetector* linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink + NSTextCheckingTypePhoneNumber error:&error];
        if (error) {
            NSLog(@"Aha nope, error");
        }
        
        [linkDetector enumerateMatchesInString:plainText options:0 range:NSMakeRange(0,[plainText length])
                                    usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
         {
             [attributedString setTextColor:k_LinkColor range:[result range]];
             [attributedString setTextIsUnderlined:NO range:[result range]];
             
             [str setString:@"1"];
         }];
    }
    
    if (str.length >0)
        detected = YES;
    
    return detected;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
