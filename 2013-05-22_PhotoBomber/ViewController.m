//
//  ViewController.m
//  2013-05-22_PhotoBomber
//
//  Created by Erin Hochstatter on 5/22/13.
//  Copyright (c) 2013 Erin Hochstatter. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSDictionary *searchDictionary;
    NSArray *dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self searchMediaByLocation];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchMediaByLocation{
    
    NSURL *mediaURL = [NSURL URLWithString:@"https://api.instagram.com/v1/media/search?min_timestamp%201369223940&max_timestamp%201369227600&lat=41.894032&lng=-87.634589&distance250&access_token=206061280.7e2a5b8.3d642ac0b5d14005894b672a3392f1f5"];
    NSURLRequest *mediaRequest = [NSURLRequest requestWithURL: mediaURL];
    
    //[activityViewer startAnimating];
    
    [NSURLConnection sendAsynchronousRequest:mediaRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
                               
                               searchDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                              
                               //[activityViewer stopAnimating];
                               
                               [self.galleryView reloadData];
                           }];
    
    
}

#pragma mark -- CollectionView Setup

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"mediaCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc] init];
        
    }
    
    dataArray = [searchDictionary objectForKey:@"data"];
    NSDictionary *metaDict = [searchDictionary objectForKey:@"meta"];
    NSLog (@"error %@",[metaDict objectForKey:@"error_message"]);
    
    NSDictionary *dataDictionary =[dataArray objectAtIndex:indexPath.item];
    NSDictionary *imageDictionary = [dataDictionary objectForKey: @"images"];
    
    NSDictionary *imgStdResDictionary = [imageDictionary objectForKey:@"standard_resolution"];
    NSLog(@"image link:%@",[imgStdResDictionary objectForKey:@"url"]);
    NSDictionary *imgThumbDictionary = [imageDictionary objectForKey:@"thumbnail"];
    
    
    NSDictionary *captionDictionary =[dataDictionary objectForKey:@"caption"];
    NSLog(@"caption %@",[captionDictionary objectForKey:@"caption"]);
    
    
    /*NSURL *imageURL = [NSURL URLWithString:[imgStdResDictionary objectForKey:@"url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *selectedImage = [UIImage imageWithData:imageData];*/
    
    NSURL *thumbURL = [NSURL URLWithString:[imgThumbDictionary objectForKey:@"url"]];
    NSData *thumbData = [NSData dataWithContentsOfURL:thumbURL];
    UIImage *selectedThumbnail = [UIImage imageWithData:thumbData];
    
    self.galleryItemImageView = (UIImageView *)[cell viewWithTag:95];
    self.galleryItemImageView.image= selectedThumbnail;
    
    return cell;
}




@end
