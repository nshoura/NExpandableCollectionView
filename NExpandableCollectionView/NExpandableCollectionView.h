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

#import <UIKit/UIKit.h>
#import "NExpandableCollectionViewDelegate.h"

@interface NExpandableCollectionView : UICollectionView <UICollectionViewDataSource>

/**
 *  Collapse section if expanded, otherwise, expand it.
 */
- (void) toggleSection:(NSInteger)section;

/** 
 *  The collection view’s delegate object.
 */
@property (nonatomic, assign) id <NExpandableCollectionViewDelegate> delegate;

/** 
 *  A Boolean value that determines whether users can expand more than one section, default is NO
 */
@property (nonatomic, assign) BOOL allowsMultipleExpandedSections;

/** 
 *  Returns YES if the specified section is expanded.
 */
- (BOOL)isExpandedSection:(NSInteger)section;

@end
