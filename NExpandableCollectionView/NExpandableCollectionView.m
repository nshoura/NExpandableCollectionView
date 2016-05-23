/*
 * Copyright (c) 2016 Nazih Shoura
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "NExpandableCollectionView.h"

@interface NExpandableCollectionView ()

@property (nonatomic, weak) id<UICollectionViewDataSource> collectionViewDataSource;
@property (nonatomic, strong) NSMutableArray* expandedSections;

@end


@implementation NExpandableCollectionView

@dynamic delegate;

-(void)awakeFromNib{
    [super awakeFromNib];
    [self commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.allowsMultipleExpandedSections = NO;
}

- (void)toggleSection:(NSInteger)section {    
    BOOL willOpen = ![self.expandedSections[section] boolValue];
    
    NSArray *indexPathsToExpand = willOpen ? [self indexPathsForSection:section] : @[];
    NSArray *indexPathsToCollapss = willOpen ? [self collapseIndexPathsForSectionIndexPaths:[self expandedSectionIndexPaths]] : [self indexPathsForSection:section];
    
    NSArray* expandedSectionIndexPaths = willOpen ? [self expandedSectionIndexPaths] : @[];
    [self updateExpandedSectionsForSectionIndexPaths:expandedSectionIndexPaths];
    self.expandedSections[section] = @(willOpen);

    if ([self.delegate respondsToSelector:@selector(collectionView:willExpandIndexPaths:collapssIndexPaths:)]) {
        [self.delegate collectionView:self willExpandIndexPaths:indexPathsToExpand collapssIndexPaths:indexPathsToCollapss];
    }

    [self performBatchUpdates:^{
        if (willOpen) {
            if ([self.delegate respondsToSelector:@selector(collectionView:willExpandIndexPaths:collapssIndexPaths:)]) {
                [self.delegate collectionView:self beganExpandingIndexPaths:indexPathsToExpand collapssingIndexPaths:indexPathsToCollapss];
            }
            [self deleteItemsAtIndexPaths:indexPathsToCollapss];
            [self insertItemsAtIndexPaths:indexPathsToExpand];
            if ([self.delegate respondsToSelector:@selector(collectionView:didExpandIndexPaths:collapssIndexPaths:)]) {
                [self.delegate collectionView:self endedExpandingIndexPaths:indexPathsToExpand collapssingIndexPaths:indexPathsToCollapss];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(collectionView:willExpandIndexPaths:collapssIndexPaths:)]) {
                [self.delegate collectionView:self beganExpandingIndexPaths:@[] collapssingIndexPaths:indexPathsToCollapss];
            }
            [self deleteItemsAtIndexPaths:indexPathsToCollapss];
            if ([self.delegate respondsToSelector:@selector(collectionView:didExpandIndexPaths:collapssIndexPaths:)]) {
                [self.delegate collectionView:self endedExpandingIndexPaths:@[] collapssingIndexPaths:indexPathsToCollapss];
            }
        }
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(collectionView:didExpandIndexPaths:collapssIndexPaths:)]) {
            [self.delegate collectionView:self didExpandIndexPaths:indexPathsToExpand collapssIndexPaths:indexPathsToCollapss];
        }
    }];
}

- (id<UICollectionViewDataSource>)dataSource {
    return [super dataSource];
}

- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource {
    _collectionViewDataSource = dataSource;
    [super setDataSource:self];
}

- (NSMutableArray *)expandedSections {
    if (!_expandedSections) {
        _expandedSections = [NSMutableArray array];
        NSInteger maxI = [self.collectionViewDataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)] ? [self.collectionViewDataSource numberOfSectionsInCollectionView:self] : 0;
        for (NSInteger i = 0; i < maxI; i++) {
            [_expandedSections addObject:@NO];
        }
    }
    return _expandedSections;
}

- (BOOL)isExpandedSection:(NSInteger)section {
    NSNumber *isExpandedSection = self.expandedSections[section];
    return isExpandedSection.boolValue;
}

- (NSArray*)indexPathsForSection:(NSInteger)section {
    NSMutableArray* indexPaths = [NSMutableArray array];
    NSInteger maxI = [self.collectionViewDataSource collectionView:self numberOfItemsInSection:section];
    for (NSInteger i = 0; i < maxI; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
    }
    return [indexPaths copy];
}

- (NSArray*)expandedSectionIndexPaths {
    NSMutableArray* sectionIndexPaths = [NSMutableArray array];
    if (!self.allowsMultipleExpandedSections) {
        NSInteger maxI = [self.collectionViewDataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)] ? [self.collectionViewDataSource numberOfSectionsInCollectionView:self] : 0;
        for (NSInteger i = 0; i < maxI; i++) {
            if ([self isExpandedSection:i]) {
                [sectionIndexPaths addObject:[NSIndexPath indexPathForItem:0 inSection:i]];
            }
        }
    }
    return [sectionIndexPaths copy];
}

- (NSArray*)collapseIndexPathsForSectionIndexPaths:(NSArray*)sectionIndexPaths {
    NSArray* indexPaths = @[];
    for (NSIndexPath* sectionIndexPath in sectionIndexPaths) {
        indexPaths = [indexPaths arrayByAddingObjectsFromArray:[self indexPathsForSection:sectionIndexPath.section]];
    }
    return indexPaths;
}

- (void)updateExpandedSectionsForSectionIndexPaths:(NSArray*)sectionIndexPaths {
    for (NSIndexPath* sectionIndexPath in sectionIndexPaths) {
        self.expandedSections[sectionIndexPath.section] = @(NO);
    }
}

// MARK: UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.collectionViewDataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        return [self.collectionViewDataSource numberOfSectionsInCollectionView:self];
    }
    @throw([NSException exceptionWithName:@"UICollectionViewDataSource implementation exception" reason:@"numberOfSectionsInCollectionView: is not implemented" userInfo:nil]);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.collectionViewDataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        NSInteger numberOfItemsInSection = [self.collectionViewDataSource collectionView:self numberOfItemsInSection:section];
        return [self isExpandedSection:section] ? numberOfItemsInSection : 0;
    }
    @throw([NSException exceptionWithName:@"UICollectionViewDataSource implementation exception" reason:@"collectionView:numberOfItemsInSection: is not implemented" userInfo:nil]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.collectionViewDataSource respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]) {
        return [self.collectionViewDataSource collectionView:self cellForItemAtIndexPath:indexPath];
    }
    @throw([NSException exceptionWithName:@"UICollectionViewDataSource implementation exception" reason:@"collectionView:cellForItemAtIndexPath: is not implemented" userInfo:nil]);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([self.collectionViewDataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        return [self.collectionViewDataSource collectionView:self viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }
    return nil;
}

@end
