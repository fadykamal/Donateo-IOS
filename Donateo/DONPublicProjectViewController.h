//
//  DONPublicProjectViewController.h
//  Donateo
//
//  Created by Fady Kamal on 5/12/13.
//  Copyright (c) 2013 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DONPublicProjectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *detailPercentage;
@property (weak, nonatomic) IBOutlet UILabel *detailFollowersNo;
@property (weak, nonatomic) IBOutlet UILabel *detailDaysToGo;
@property (weak, nonatomic) IBOutlet UITextView *detailDescription;
@end
