//
//  DONAppDelegate.m
//  Donateo
//
//  Created by Fady Kamal on 4/10/13.
//  Copyright (c) 2013 Orange. All rights reserved.
//

#import "DONAppDelegate.h"

#import "DONViewController.h"

@implementation DONAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
//    self.viewController = [[DONViewController alloc] bundle:nil];
//    self.window.rootViewController = self.viewController;
//    [self.window makeKeyAndVisible];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"email"]);
    NSLog(@"%@",[defaults objectForKey:@"password"]);
    NSString *isLoggedIn = [defaults objectForKey:@"loggedIn"];
    if ([isLoggedIn isEqualToString:@"YES"]) {
        
        NSString *XMLRequest = [NSString stringWithFormat: @"user=<login><email>%@</email><password>%@</password></login>", [defaults objectForKey:@"email"],[defaults objectForKey:@"password"]];

        NSString *post = [XMLRequest stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        NSURL *url=[NSURL URLWithString:@"http://localhost:8080/springmvc/xLogin"];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
