//
//  CollectionViewHeader.m
//  NExpandableCollectionView
//
//  Created by Nazih Shoura on 09/01/2016.
//  Copyright © 2016 NazihShoura. All rights reserved.
//

#import "CollectionViewHeader.h"

@interface CollectionViewHeader()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation CollectionViewHeader
- (IBAction)buttonDidTap:(id)sender {
    [self.delegate collectionViewHeaderDidTap:self];
}

-(void)setText:(NSString *)text{
    self.label.text = text;
}
@end
