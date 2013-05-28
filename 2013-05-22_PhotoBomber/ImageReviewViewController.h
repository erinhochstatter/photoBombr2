//
//  ImageReviewViewController.h
//  2013-05-22_PhotoBomber
//
//  Created by Erin Hochstatter on 5/25/13.
//  Copyright (c) 2013 Erin Hochstatter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaCell.h"

@interface ImageReviewViewController : UIViewController

@property (strong, nonatomic) NSDictionary *selectedImageDict;
@property (strong, nonatomic) IBOutlet UIImageView *reviewImageView;
@property (strong, nonatomic) NSData *reviewImageData;


@end
