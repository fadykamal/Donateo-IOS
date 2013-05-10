//
//  DONProjectCell.h
//  Donateo
//
//  Created by Fady Kamal on 5/10/13.
//  Copyright (c) 2013 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DONProjectCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *projectImage;
@property (weak, nonatomic) IBOutlet UILabel *projectTitle;
@property (weak, nonatomic) IBOutlet UILabel *collectedAmount;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *followersNo;
@property (weak, nonatomic) IBOutlet UILabel *daysLeft;

@end
