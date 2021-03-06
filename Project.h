//
//  Project.h
//  Donateo
//
//  Created by Fady Kamal on 5/10/13.
//  Copyright (c) 2013 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject {
    NSURL *imageURL;
    UIImage *image;
    NSString *title;
    NSString *description;
    NSString *finished;
    NSString *totalAmount;
    NSString *collectedAmount;
    float percentageCompleted;
    NSString *location;
    NSString *followersNO;
    NSDate *startDate;
    NSString *startDateString;
    NSDate *deadlineDate;
    NSString *deadlineDateString;
    NSString *daysLeft;
    NSNumber *id;
    BOOL *volunteer;
    BOOL *donateMoney;
    BOOL *donateObject;
}

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *finished;
@property (nonatomic, strong) NSString *totalAmount;
@property (nonatomic, strong) NSString *collectedAmount;
@property (nonatomic, assign) float percentageCompleted;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *followersNO;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSString *startDateString;
@property (nonatomic, strong) NSDate *deadlineDate;
@property (nonatomic, strong) NSString *deadlineDateString;
@property (nonatomic, strong) NSString *daysLeft;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, assign) BOOL *volunteer;
@property (nonatomic, assign) BOOL *donateMoney;
@property (nonatomic, assign) BOOL *donateObject;

- (id)initWithInfo:(UIImage *)image title:(NSString *)title collectedAmount:(NSString *)collectedAmount totalAmount:(NSString *)totalAmount followersNO:(NSString *) followersNO deadlineDateString:(NSString *)deadlineDate startDateString:(NSString *)startDate description:(NSString *)description;
@end
