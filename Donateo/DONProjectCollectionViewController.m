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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    
//    recipePhotos = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];
    
    projects = [NSArray arrayWithObjects:
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"angry_birds_cake.jpg"] title:@"Project 1"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"creme_brelee.jpg"] title:@"Project 2"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"egg_benedict.jpg"] title:@"Project 3"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"full_breakfast.jpg"] title:@"Project 4"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"green_tea.jpg"] title:@"Project 5"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"ham_and_cheese_panini.jpg"] title:@"Project 6"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"ham_and_egg_sandwich.jpg"] title:@"Project 7"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"hamburger.jpg"] title:@"Project 8"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"instant_noodle_with_egg.jpg"] title:@"Project 9"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"japanese_noodle_with_pork.jpg"] title:@"Project 10"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"mushroom_risotto.jpg"] title:@"Project 11"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"noodle_with_bbq_pork.jpg"] title:@"Project 12"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"starbucks_coffee.jpg"] title:@"Project 13"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"thai_shrimp_cake.jpg"] title:@"Project 14"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"vegetable_curry.jpg"] title:@"Project 15"],
             [[Project alloc] initWithInfo:[UIImage imageNamed:@"white_chocolate_donut.jpg"] title:@"Project 16"],
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
    return cell;
}

@end
