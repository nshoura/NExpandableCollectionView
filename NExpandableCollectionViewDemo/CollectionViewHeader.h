//
//  CollectionViewHeader.h
//  NExpandableCollectionView
//
//  Created by Nazih Shoura on 09/01/2016.
//  Copyright © 2016 NazihShoura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewHeaderDelegate.h"

@interface CollectionViewHeader : UICollectionReusableView
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) id<CollectionViewHeaderDelegate> delegate;
@end