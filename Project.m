//
//  Project.m
//  Donateo
//
//  Created by Fady Kamal on 5/10/13.
//  Copyright (c) 2013 Orange. All rights reserved.
//

#import "Project.h"

@implementation Project
@synthesize imageURL,image,title,description,finished,totalAmount,collectedAmount,percentageCompleted,location,followersNO,startDate,deadlineDate,deadlineDateString,daysLeft,id,volunteer,donateMoney,donateObject;
#pragma mark - Properties

//- (UIImage *)image
//{
//    if (!self.image && self.imageURL) {
//        NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
//        UIImage *image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
//        
//        _image = image;
//    }
//    
//    return _image;
//}

#pragma mark - Lifecycle

//+ (Project *)photoWithImageURL:(NSURL *)imageURL
//{
//    return [[self alloc] initWithImageURL:imageURL];
//}
//
//- (id)initWithImageURL:(NSURL *)imageURLV
//{
//    self = [super init];
//    if (self) {
//        self.imageURL = imageURLV;
//    }
//    return self;
//}

- (id)initWithInfo:(UIImage *)imageV title:(NSString *)titleV collectedAmount:(NSString *)collectedAmountV totalAmount:(NSString *)totalAmountV followersNO:(NSString *)followersNOV deadlineDateString:(NSString *)deadlineDateStringV;
{
    self = [super init];
    if (self) {
        self.image = imageV;
        self.title = titleV;
        self.collectedAmount = collectedAmountV;
        self.totalAmount = totalAmountV;
        self.followersNO = followersNOV;
        self.deadlineDateString = deadlineDateStringV;
        
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
