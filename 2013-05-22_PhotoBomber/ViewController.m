//
//  ViewController.m
//  2013-05-22_PhotoBomber
//
//  Created by Erin Hochstatter on 5/22/13.
//  Copyright (c) 2013 Erin Hochstatter. All rights reserved.
//

#import "ViewController.h"
#import "MediaCell.h"
#import "ImageReviewViewController.h"

@interface ViewController ()
{
    NSDictionary *searchDictionary;
    NSArray *dataArray;
    NSDictionary *dataDictionary;
    MediaCell *mediaCell;
    BOOL shareEnabled;
    NSMutableArray *selectedRecipes;
    //NSDictionary *mainSegueDictionary;

}
@end

@implementation ViewController


NSString *kCellID= @"mediaCellID";
// UICollectionViewCell storyboard identifier, i used this instead of the string that normally goes in the cell creation part of things.


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
                               dataArray = [searchDictionary objectForKey:@"data"];
                               NSDictionary *metaDict = [searchDictionary objectForKey:@"meta"];
                               NSLog (@"error %@",[metaDict objectForKey:@"error_message"]);
                               //[activityViewer stopAnimating];
                               
                               [self.galleryView reloadData];
                           }];
    
    
}

#pragma mark -- CollectionView Setup

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    NSLog(@"this logs the sections in view");
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"this logs the items in section:%d", dataArray.count);
    return dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    mediaCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    //the documentation says that if you dequeue, the cell will never be nil, so i removed the if cell = nil part. 
    
    dataDictionary =[dataArray objectAtIndex:indexPath.item];
    NSDictionary *imageDictionary = [dataDictionary objectForKey: @"images"];
    
    NSDictionary *imgStdResDictionary = [imageDictionary objectForKey:@"standard_resolution"];
    NSLog(@"image link:%@",[imgStdResDictionary objectForKey:@"url"]);
    NSDictionary *imgThumbDictionary = [imageDictionary objectForKey:@"thumbnail"];
    
    
    //NSDictionary *captionDictionary =[dataDictionary objectForKey:@"caption"];
    //NSLog(@"caption %@",[captionDictionary objectForKey:@"caption"]);
    
    NSURL *thumbURL = [NSURL URLWithString:[imgThumbDictionary objectForKey:@"url"]];
    NSData *thumbData = [NSData dataWithContentsOfURL:thumbURL];
    UIImage *selectedThumbnail = [UIImage imageWithData:thumbData];
    
    mediaCell.thumbnailImageView.image= selectedThumbnail;
    
    return mediaCell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToImageReview"])
    {
        NSIndexPath *selectedIndexPath = [[self.galleryView indexPathsForSelectedItems] objectAtIndex:0];
        
        // load the image, to prevent it from being cached we use 'initWithContentsOfFile'
        NSDictionary *selectedIndexDict = [dataArray objectAtIndex:selectedIndexPath.row];
        NSDictionary *imageDictionary = [selectedIndexDict objectForKey: @"images"];
        NSDictionary *imgStdResDictionary = [imageDictionary objectForKey:@"standard_resolution"];
        NSURL *imageURL = [NSURL URLWithString:[imgStdResDictionary objectForKey:@"url"]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            
        ImageReviewViewController *imageReviewViewController = [segue destinationViewController];
        imageReviewViewController.reviewImageData = imageData;
        //imageReviewViewController.reviewImageView.image= selectedImage;
        NSLog(@" selected image path: %@", imageURL);
    }
    //[self.galleryView deselectItemAtIndexPath:indexPath animated:YES];
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        NSArray *indexPathsSelected = [self.galleryView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPathsSelected objectAtIndex:0];

    
    //I think what happened is that it's making an array of the object in the selected array, which is maybe a cell or an image.  the dictionary may need to be a property of that cell to go over.
    
    ((ImageReviewViewController*)(segue.destinationViewController)).selectedImageDict=mainSegueDictionary;
    
    [self.galleryView deselectItemAtIndexPath:indexPath animated:YES];
    
}*/


- (IBAction)refreshWithButton:(id)sender {
    [self searchMediaByLocation];
    [self.galleryView reloadData];
}
@end
