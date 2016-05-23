//
//  CollectionViewItem.m
//  NExpandableCollectionView
//
//  Created by Nazih Shoura on 09/01/2016.
//  Copyright © 2016 NazihShoura. All rights reserved.
//

#import "CollectionViewItem.h"

@interface CollectionViewItem ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation CollectionViewItem

-(void)setText:(NSString *)text{
    self.label.text = text;
}

@end
