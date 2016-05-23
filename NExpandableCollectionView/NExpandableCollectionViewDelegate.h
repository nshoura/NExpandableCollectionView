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

@class NExpandableCollectionView;

@protocol NExpandableCollectionViewDelegate <UICollectionViewDelegateFlowLayout>

@optional

/**
 *  Tells the delegate what indexPaths will expand/collapss. This method will be executed before a performBatchUpdates block.
 */
- (void)collectionView:(NExpandableCollectionView *)collectionView willExpandIndexPaths:(NSArray *)indexPathsExpanded collapssIndexPaths:(NSArray *)indexPathsCollapssed;

/**
 *  Tells the delegate what indexPaths began expanding/collapssing. This method will be executed as part of a performBatchUpdates block.
 */
- (void)collectionView:(NExpandableCollectionView *)collectionView beganExpandingIndexPaths:(NSArray *)indexPathsExpanding collapssingIndexPaths:(NSArray *)indexPathsCollapssing;

/**
 *  Tells the delegate what indexPaths ended expanding/collapssing. This method will be executed as part of a performBatchUpdates block.
 */
- (void)collectionView:(NExpandableCollectionView *)collectionView endedExpandingIndexPaths:(NSArray *)indexPathsExpanding collapssingIndexPaths:(NSArray *)indexPathsCollapssing;

/**
 *  Tells the delegate what indexPaths did expand/collapss. This method will be executed after a performBatchUpdates block.
 */
- (void)collectionView:(NExpandableCollectionView *)collectionView didExpandIndexPaths:(NSArray *)indexPathsExpanded collapssIndexPaths:(NSArray *)indexPathsCollapssed;

@end
