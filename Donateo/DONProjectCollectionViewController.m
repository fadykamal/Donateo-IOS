//
//  DONProjectCollectionViewController.m
//  Donateo
//
//  Created by Fady Kamal on 5/10/13.
//  Copyright (c) 2013 Orange. All rights reserved.
//

#import "DONProjectCollectionViewController.h"
#import "DONProjectCell.h"
#import "Project.h"
#import "DONProjectViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DONProjectCollectionViewController () {
    //NSArray *recipePhotos;
    NSArray *projects;
}
@end

@implementation DONProjectCollectionViewController

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
    [self.navigationController setNavigationBarHidden:YES]; //remove this animated:animated to appear better
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    
//    recipePhotos = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];
    
    projects = [NSArray arrayWithObjects:
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"angry_birds_cake.jpg"] title:@"Project 1" collectedAmount:@"5000" totalAmount:@"10000" followersNO:@"300" deadlineDateString:@"12-10-2013"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"creme_brelee.jpg"] title:@"Project 2" collectedAmount:@"200" totalAmount:@"3000" followersNO:@"200" deadlineDateString:@"10-8-2013"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"egg_benedict.jpg"] title:@"Project 3"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"full_breakfast.jpg"] title:@"Project 4"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"green_tea.jpg"] title:@"Project 5"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"ham_and_cheese_panini.jpg"] title:@"Project 6"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"ham_and_egg_sandwich.jpg"] title:@"Project 7"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"hamburger.jpg"] title:@"Project 8"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"instant_noodle_with_egg.jpg"] title:@"Project 9"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"japanese_noodle_with_pork.jpg"] title:@"Project 10"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"mushroom_risotto.jpg"] title:@"Project 11"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"noodle_with_bbq_pork.jpg"] title:@"Project 12"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"starbucks_coffee.jpg"] title:@"Project 13"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"thai_shrimp_cake.jpg"] title:@"Project 14"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"vegetable_curry.jpg"] title:@"Project 15"],
//             [[Project alloc] initWithInfo:[UIImage imageNamed:@"white_chocolate_donut.jpg"] title:@"Project 16"],
             nil];
	// Do any additional setup after loading the view.
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
//One Alternative

//    static NSString *identifier = @"ProjectCell";
//    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RoundedBG.png"]];
//    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
//    recipeImageView.layer.cornerRadius = 7;
//    recipeImageView.clipsToBounds = YES;
//    recipeImageView.image = [UIImage imageNamed:[recipePhotos objectAtIndex:indexPath.row]];
//    return cell;
    DONProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectCell" forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RoundedBG.png"]];
    Project *project = [projects objectAtIndex:indexPath.row];
    cell.projectTitle.text = project.title;
    cell.projectImage.image = project.image;
    cell.daysLeft.text = project.daysLeft;
    cell.followersNo.text = project.followersNO;
    cell.collectedAmount.text = project.collectedAmount;
    cell.totalAmount.text = project.totalAmount;
    cell.progressBar.progress = project.percentageCompleted;
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
        NSString *percentage = [[NSString alloc] initWithFormat:@"%g%@",tmpproject.percentageCompleted*100,@"%"];
        destViewController.detailPercentage.text = percentage;
        destViewController.detailDaysToGo.text = tmpproject.daysLeft;
        //[self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

@end
