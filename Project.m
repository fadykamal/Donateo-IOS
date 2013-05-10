//
//  Project.m
//  Donateo
//
//  Created by Fady Kamal on 5/10/13.
//  Copyright (c) 2013 Orange. All rights reserved.
//

#import "Project.h"

@implementation Project
#pragma mark - Properties

- (UIImage *)image
{
    if (!_image && self.imageURL) {
        NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
        UIImage *image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
        
        _image = image;
    }
    
    return _image;
}

#pragma mark - Lifecycle

+ (Project *)photoWithImageURL:(NSURL *)imageURL
{
    return [[self alloc] initWithImageURL:imageURL];
}

- (id)initWithImageURL:(NSURL *)imageURL
{
    self = [super init];
    if (self) {
        self.imageURL = imageURL;
    }
    return self;
}

- (id)initWithInfo:(UIImage *)image title:(NSString *)title collectedAmount:(NSString *)collectedAmount totalAmount:(NSString *)totalAmount followersNO:(NSString *)followersNO deadlineDateString:(NSString *)deadlineDateString;
{
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        self.collectedAmount = collectedAmount;
        self.totalAmount = totalAmount;
        self.followersNO = followersNO;
        self.deadlineDateString = deadlineDateString;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd-MMM-yyyy"; // or whatever you want; per the unicode standards
        
        self.deadlineDate= [dateFormatter dateFromString:deadlineDateString];
        //Calculate remaining days
        NSDateFormatter *df= [[NSDateFormatter alloc] init];
        df.dateFormat = @"dd-MM-yyy";
        NSDate *today = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
//        NSDate *dec21 = [[NSDate alloc] init];
//        
//        dec21 = [df dateFromString:@"2012-12-21"];
        
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        
        
        NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
        
        NSDateComponents *components = [gregorian components:unitFlags
                                                    fromDate:today
                                                      toDate:deadlineDate options:0];
        NSInteger days = [components day];
        NSInteger months = [components month];
        NSInteger totalDaysLeft = months*30 + days;
        self.daysLeft = [NSString stringWithFormat:@"%d", totalDaysLeft];
//        NSString *result = [[NSString alloc] initWithFormat:@"About %d months and %d days left", months, days];
    }
    return self;
}

@end
