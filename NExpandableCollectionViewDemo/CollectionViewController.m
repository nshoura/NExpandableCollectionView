//
//  CollectionViewController.m
//  NExpandableCollectionViewDemo
//
//  Created by Nazih Shoura on 09/01/2016.
//  Copyright © 2016 NazihShoura. All rights reserved.
//

#import "CollectionViewController.h"
#import "NExpandableCollectionView.h"
#import "CollectionViewHeader.h"
#import "CollectionViewItem.h"

@implementation CollectionViewController

static const NSInteger NumberOfSections = 5;
static const NSInteger NumberOfItemsInSection = 10;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName: NSStringFromClass([CollectionViewItem class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier: NSStringFromClass([CollectionViewItem class])];
    
    [self.collectionView registerNib:[UINib nibWithNibName: NSStringFromClass([CollectionViewHeader class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CollectionViewHeader class])];
    
}

// MARK: UICollectionView Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return NumberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return NumberOfItemsInSection;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewItem *collectionViewItem = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass([CollectionViewItem class]) forIndexPath:indexPath];
    collectionViewItem.text = [NSString stringWithFormat:@"Item %@", @(indexPath.row)];
    return collectionViewItem;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionViewHeader *headerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier: NSStringFromClass([CollectionViewHeader class]) forIndexPath:indexPath];
        headerview.tag = indexPath.section;
        headerview.delegate = self;
        headerview.text = [NSString stringWithFormat:@"Section %@", @(indexPath.section)];
        
        return headerview;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50, 50);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.collectionView.contentSize.width, 50);
}

// MARK: NExpandableCollectionView Delegate

-(void)collectionView:(NExpandableCollectionView *)collectionView willExpandIndexPaths:(NSArray *)indexPathsExpanded collapssIndexPaths:(NSArray *)indexPathsCollapssed{
    NSLog(@"Index Paths Will Expande: %@",indexPathsExpanded.description);
    NSLog(@"Index Paths Will Collapss: %@",indexPathsCollapssed.description);
}

-(void)collectionView:(NExpandableCollectionView *)collectionView beganExpandingIndexPaths:(NSArray *)indexPathsExpanding collapssingIndexPaths:(NSArray *)indexPathsCollapssing{
    NSLog(@"Index Paths Began Expanding: %@",indexPathsExpanding.description);
    NSLog(@"Index Paths Began Collapssing: %@",indexPathsCollapssing.description);
}

-(void)collectionView:(NExpandableCollectionView *)collectionView endedExpandingIndexPaths:(NSArray *)indexPathsExpanding collapssingIndexPaths:(NSArray *)indexPathsCollapssing{
    NSLog(@"Index Paths Ended Expanding: %@",indexPathsExpanding.description);
    NSLog(@"Index Paths Ended Collapssing: %@",indexPathsCollapssing.description);
}

-(void)collectionView:(NExpandableCollectionView *)collectionView didExpandIndexPaths:(NSArray *)indexPathsExpanded collapssIndexPaths:(NSArray *)indexPathsCollapssed{
    NSLog(@"Index Paths Expanded: %@",indexPathsExpanded.description);
    NSLog(@"Index Paths Collapssed: %@",indexPathsCollapssed.description);
}


// MARK: CollectionViewHeader Delegate

-(void)collectionViewHeaderDidTap:(UICollectionReusableView *)collectionViewHeader{
    [self.collectionView toggleSection:collectionViewHeader.tag];
}
@end
