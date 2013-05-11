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
        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateFormat = @"dd-MMM-yyyy"; // or whatever you want; per the unicode standards
//        
//        self.deadlineDate= [dateFormatter dateFromString:deadlineDateString];
        //Calculate remaining days
        NSDateFormatter *df= [[NSDateFormatter alloc] init];
        df.dateFormat = @"dd-MM-yyy";
        NSDate *today = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        NSDate *date = [[NSDate alloc] init];
//        
        date = [df dateFromString:deadlineDateString];
        
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        
        
        NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
        
        NSDateComponents *components = [gregorian components:unitFlags
                                                    fromDate:today
                                                      toDate:date options:0];
        NSInteger days = [components day];
        NSInteger months = [components month];
        NSInteger totalDaysLeft = months*30 + days;
        self.daysLeft = [NSString stringWithFormat:@"%d", totalDaysLeft];
        NSNumberFormatter * nformatter = [[NSNumberFormatter alloc] init];
        [nformatter setNumberStyle:NSNumberFormatterDecimalStyle];
        float val1 = [[collectedAmount stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] intValue];
        float val2 = [[totalAmount stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] intValue];
//        NSNumber * number1 = [nformatter numberFromString:collectedAmount];
//        NSNumber * number2 = [nformatter numberFromString:totalAmount];
        self.percentageCompleted = val1/val2;
//        NSString *result = [[NSString alloc] initWithFormat:@"About %d months and %d days left", months, days];
    }
    return self;
}

@end
