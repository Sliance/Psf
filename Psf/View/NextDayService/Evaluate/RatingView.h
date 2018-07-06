//
//  RatingViewController.h
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FloatRatingViewDelegate;

/**
 A simple rating view that can set whole, half or floating point ratings.
 */

@interface RatingView : UIView
@property (weak, nonatomic) id <FloatRatingViewDelegate> delegate;

/**
 Sets the empty image (e.g. a star outline)
 */
@property (strong, nonatomic) UIImage *emptySelectedImage;

/**
 Sets the full image that is overlayed on top of the empty image.
 Should be same size and shape as the empty image.
 */
@property (strong, nonatomic) UIImage *fullSelectedImage;

/**
 Sets the empty and full image view content mode. Defaults to UIViewContentModeCenter.
 */
@property (nonatomic) UIViewContentMode contentMode;

/**
 Minimum rating. Default is 0.
 */
@property (nonatomic) NSInteger minRating;

/**
 Max rating value. Default is 5.
 */
@property (nonatomic) NSInteger maxRating;

/**
 Minimum image size. Default is CGSize(5,5).
 */
@property (nonatomic) CGSize minImageSize;

/**
 Set the current rating. Default is 0.
 */
@property (nonatomic) CGFloat rating;

/**
 Sets whether or not the rating view is editable. Default is NO.
 */
@property (nonatomic) BOOL editable;

/**
 Ratings change by 0.5. Overrides floatRatings property. Default is NO.
 */
@property (nonatomic) BOOL halfRatings;

/**
 Ratings change by floating point values. Default is NO.
 */
@property (nonatomic) BOOL floatRatings;

@end

@protocol FloatRatingViewDelegate <NSObject>
@optional
/**
 Returns the rating value when touch events end.
 */
- (void)floatRatingView:(RatingView *)ratingView ratingDidChange:(CGFloat)rating;

/**
 Returns the rating value as the user pans.
 */
- (void)floatRatingView:(RatingView *)ratingView continuousRating:(CGFloat)rating;
@end