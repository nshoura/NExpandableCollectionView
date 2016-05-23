//
//  CollectionViewHeaderDelegate.h
//  NExpandableCollectionView
//
//  Created by Nazih Shoura on 09/01/2016.
//  Copyright © 2016 NazihShoura. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewHeaderDelegate
-(void) collectionViewHeaderDidTap:(UICollectionReusableView *)collectionViewHeader;
@end