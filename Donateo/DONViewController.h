//
//  DONViewController.h
//  Donateo
//
//  Created by Fady Kamal on 4/10/13.
//  Copyright (c) 2013 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DONViewController : UIViewController
- (IBAction)backroundClick:(id)sender;
- (IBAction)loginClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end
