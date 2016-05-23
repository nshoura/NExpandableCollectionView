//
//  CollectionViewController.h
//  NExpandableCollectionViewDemo
//
//  Created by Nazih Shoura on 09/01/2016.
//  Copyright © 2016 NazihShoura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NExpandableCollectionViewDelegate.h"
#import "CollectionViewHeaderDelegate.h"

@interface CollectionViewController : UICollectionViewController <NExpandableCollectionViewDelegate, CollectionViewHeaderDelegate>

@end
