//
//  ViewController.h
//  2013-05-22_PhotoBomber
//
//  Created by Erin Hochstatter on 5/22/13.
//  Copyright (c) 2013 Erin Hochstatter. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *testImageView;
@property (strong, nonatomic) IBOutlet UICollectionView *galleryView;
@property (strong, nonatomic) IBOutlet UIImageView *galleryItemImageView;

@end
