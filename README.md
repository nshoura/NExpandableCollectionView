# NExpandableCollectionView

A `UICollectionView` subclass that enables you to easily expand and collapse sections.

## Installation

1. Manually clone this repository to your machine or add it as a Git submodule to your project.
2. Drag the folder `NExpandableCollectionView` into your Xcode project to add all the files in it to your project.

## Usage

1. `#import "NExpandableCollectionView.h"`
2. Create an `NExpandableCollectionView` instead of a regular `UICollectionView`.
3. Set `allowsMultipleExpandedSections` Boolean to enable/disable expanding more than one section at a time, default is `NO`.
4. Call `(void) toggleSection:(NSInteger)section;` on the collection view. This will collapse the section if expanded (And collapse any other sections if `allowsMultipleExpandedSections = NO`), otherwise, expand it.
5. You check if a section is expanded or not using `(BOOL) isExpandedSection:(NSInteger)section;`

# NExpandableCollectionViewDelegate

`NExpandableCollectionView` conforms to `NExpandableCollectionViewDelegate` that notifies you about the various states the expanding/collapsing items go through. You can use this delegate to apply other animations alongside the expand/collapse animations.
Please check the documentation for more informations about this.

## Example

In the example, toggling the sections is done by clicking on the section header.


![alt tag](https://github.com/nazeehshoura/NExpandableCollectionView/blob/master/Demo.gif?raw=true)
