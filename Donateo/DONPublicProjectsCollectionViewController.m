//
//  DONPublicProjectsCollectionViewController.m
//  Donateo
//
//  Created by Fady Kamal on 5/12/13.
//  Copyright (c) 2013 Orange. All rights reserved.
//

#import "DONPublicProjectsCollectionViewController.h"
#import "DONProjectCell.h"
#import "Project.h"
#import "DONProjectViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RXMLElement.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"
@interface DONPublicProjectsCollectionViewController () {
    NSMutableArray *projects;
    int counter;
    NSString *message;
}
@end
@implementation DONPublicProjectsCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//the following to methods to hide navigation bar in the view
- (void)viewWillAppear:(BOOL)animated
{
//    [self.navigationController setNavigationBarHidden:YES]; //remove this animated:animated to appear better
//    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isLoggedIn = [defaults objectForKey:@"loggedIn"];
    if ([isLoggedIn isEqualToString:@"YES"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UICollectionViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DONTabViewController"];
        [self presentViewController:vc animated:NO completion:NULL];
    }
    else {
        [SVProgressHUD show];
        NSString *XMLRequest = [NSString stringWithFormat: @"counter=1"];
        NSString *post = [XMLRequest stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        NSURL *url=[NSURL URLWithString:@"http://localhost:8080/springmvc/getUrgentCrowdfundings"];
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
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSString *decodedResponse = [responseData
                                         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //XML Response
            RXMLElement *listOfProjects = [RXMLElement elementFromXMLString:decodedResponse encoding:NSUTF8StringEncoding];
            if ([listOfProjects.tag isEqualToString:@"error"]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = listOfProjects.text;
                hud.margin = 10.f;
                hud.yOffset = 150.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:3];
            }
            else {
                RXMLElement *rootXML = [listOfProjects child:@"projects"];
                
                projects = [[NSMutableArray alloc] init];
                
                [rootXML iterateWithRootXPath:@"//crowdfunding" usingBlock: ^(RXMLElement *player) {
                    
                    Project *project = [[Project alloc] initWithInfo:[UIImage imageNamed:@"angry_birds_cake.jpg"] title:[player child:@"project__name"].text collectedAmount:[player child:@"collected__amount"].text totalAmount:[player child:@"amount"].text followersNO:[player child:@"number__of__followers"].text deadlineDateString:[player child:@"deadline"].text startDateString:[player child:@"start__date"].text description:[player child:@"description"].text];
                    
                    [projects addObject:project];
                }];

            }
        }
        else {
            
        }
        [SVProgressHUD dismiss];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return projects.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    DONProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectCell" forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RoundedBG.png"]];
    Project *project = [projects objectAtIndex:indexPath.row];
    cell.projectTitle.text = project.title;
    cell.projectImage.image = project.image;
    cell.daysLeft.text = project.daysLeft;
    cell.followersNo.text = project.followersNO;
    cell.collectedAmount.text = project.collectedAmount;
    cell.totalAmount.text = project.totalAmount;
    cell.progressBar.progress = project.percentageCompleted/100;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"projectDetail"]) {
        [segue.destinationViewController view];
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        DONProjectViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        //destViewController.detailImageName = [projects[indexPath.section] objectAtIndex:indexPath.row];
        Project *tmpproject = [projects objectAtIndex:indexPath.row];
        destViewController.detailImage.image = tmpproject.image;
        destViewController.detailFollowersNo.text = tmpproject.followersNO;
        NSString *percentage = [[NSString alloc] initWithFormat:@"%g%@",tmpproject.percentageCompleted,@"%"];
        destViewController.detailPercentage.text = percentage;
        destViewController.detailDaysToGo.text = tmpproject.daysLeft;
        destViewController.detailDescription.text = tmpproject.description;
        //[self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
        [SVProgressHUD show];
        if (counter == 0) {
            counter++;
        }
        
        counter++;
        
        NSString *XMLRequest = [NSString stringWithFormat: @"counter=%i",counter];
        NSString *post = [XMLRequest stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        NSURL *url=[NSURL URLWithString:@"http://localhost:8080/springmvc/getUrgentCrowdfundings"];
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
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSString *decodedResponse = [responseData
                                         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //XML Response
            RXMLElement *listOfProjects = [RXMLElement elementFromXMLString:decodedResponse encoding:NSUTF8StringEncoding];
            if ([listOfProjects.tag isEqualToString:@"error"]) {
                message = listOfProjects.text;
                //NSLog(@"%@",message);
            }
            else {
                RXMLElement *rootXML = [listOfProjects child:@"projects"];
                
                projects = [[NSMutableArray alloc] init];
                
                [rootXML iterateWithRootXPath:@"//crowdfunding" usingBlock: ^(RXMLElement *player) {
                    
                    Project *project = [[Project alloc] initWithInfo:[UIImage imageNamed:@"angry_birds_cake.jpg"] title:[player child:@"project__name"].text collectedAmount:[player child:@"collected__amount"].text totalAmount:[player child:@"amount"].text followersNO:[player child:@"number__of__followers"].text deadlineDateString:[player child:@"deadline"].text startDateString:[player child:@"start__date"].text description:[player child:@"description"].text];
                    
                    [projects addObject:project];
                }];
                
            }
        }
        else {
            
        }

    [SVProgressHUD dismiss];
    if ([message length] != 0) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1.5];
    }
}

@end
