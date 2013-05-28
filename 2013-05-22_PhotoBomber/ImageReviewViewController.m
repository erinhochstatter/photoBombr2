//
//  ImageReviewViewController.m
//  2013-05-22_PhotoBomber
//
//  Created by Erin Hochstatter on 5/25/13.
//  Copyright (c) 2013 Erin Hochstatter. All rights reserved.
//

#import "ImageReviewViewController.h"

@interface ImageReviewViewController ()
{
    UIImage *selectedImage;
}


@end

@implementation ImageReviewViewController

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
    //[self getImageInformation];
    selectedImage = [UIImage imageWithData:self.reviewImageData];
    self.reviewImageView.image = selectedImage;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getImageInformation{
    
    NSDictionary *imageDictionary = [self.selectedImageDict objectForKey: @"images"];
    NSDictionary *imgStdResDictionary = [imageDictionary objectForKey:@"standard_resolution"];
    NSURL *imageURL = [NSURL URLWithString:[imgStdResDictionary objectForKey:@"url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    selectedImage = [UIImage imageWithData:imageData];
}

- (IBAction)doneWithButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
