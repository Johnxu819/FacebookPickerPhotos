// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.1 clang-703.0.29)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import Foundation;
@import Photos;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UILabel;
@class UIButton;
@class NSCoder;

SWIFT_CLASS("_TtC20JFacebookPhotoPicker16AlbumToolbarView")
@interface AlbumToolbarView : UIView
@property (nonatomic, strong) UIView * _Nullable doneNumberAnimationLayer;
@property (nonatomic, strong) UILabel * _Nullable labelTextView;
@property (nonatomic, strong) UIButton * _Nullable buttonDone;
@property (nonatomic, strong) UIView * _Nullable doneNumberContainer;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)eventDoneClicked;
- (void)changeNumber:(NSInteger)number;
@end

@class UIWindow;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC20JFacebookPhotoPicker11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class NSIndexPath;

@interface NSIndexSet (SWIFT_EXTENSION(JFacebookPhotoPicker))
- (NSArray<NSIndexPath *> * _Nonnull)aapl_indexPathsFromIndexesWithSection:(NSInteger)section;
@end

@class PHFetchResult;
@class UIImageView;

SWIFT_CLASS("_TtC20JFacebookPhotoPicker23PhotoAlbumTableViewCell")
@interface PhotoAlbumTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified albumCover;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified albumTitle;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified albumNumber;
@property (nonatomic, readonly) CGFloat imageSize;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)renderData:(PHFetchResult * _Nonnull)result label:(NSString * _Nullable)label;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class PhotoCollectionViewController;
@class UITableView;
@class PHImageManager;
@class PHChange;

SWIFT_CLASS("_TtC20JFacebookPhotoPicker20PhotoAlbumsTableView")
@interface PhotoAlbumsTableView : UIView <UIScrollViewDelegate, UITableViewDataSource, PHPhotoLibraryChangeObserver, UITableViewDelegate>
@property (nonatomic, strong) PhotoCollectionViewController * _Nullable photoCollectionViewController;
@property (nonatomic, strong) UITableView * _Nonnull tableView;
@property (nonatomic, readonly, copy) NSString * _Nonnull albumTableViewCellItentifier;
@property (nonatomic, readonly, strong) PHImageManager * _Nonnull imageManager;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)setupView;
- (void)photoLibraryDidChange:(PHChange * _Nonnull)changeInstance;
- (void)eventViewControllerDismiss;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end

@class PHCachingImageManager;
@class UINavigationBar;
@class UIScrollView;
@class PHAsset;
@class UICollectionViewLayout;
@class UICollectionViewFlowLayout;
@class UICollectionView;
@class UICollectionViewCell;
@class UIImagePickerController;
@class UIImage;
@class UIGestureRecognizer;

SWIFT_CLASS("_TtC20JFacebookPhotoPicker29PhotoCollectionViewController")
@interface PhotoCollectionViewController : UICollectionViewController <PHPhotoLibraryChangeObserver, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
+ (NSInteger)imageMaxSelectedNum;
+ (void)setImageMaxSelectedNum:(NSInteger)value;
+ (NSInteger)alreadySelectedImageNum;
+ (void)setAlreadySelectedImageNum:(NSInteger)value;
@property (nonatomic, readonly, strong) PHCachingImageManager * _Nonnull imageManager;
@property (nonatomic, strong) PHFetchResult * _Nullable fetchResult;
@property (nonatomic, strong) PhotoAlbumsTableView * _Nullable albumsTableView;
@property (nonatomic, strong) UINavigationBar * _Nullable newNavBar;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)configPhotoObserver;
- (void)onFinishedButtonClicked;
- (void)allbumClcik;
- (void)eventCancel;
- (void)doneClick;
- (void)resetCacheAssets;
- (void)updateCacheAssets;
- (void)eventSelectNumberChange:(NSInteger)number;
- (void)scrollViewDidScroll:(UIScrollView * _Nonnull)scrollView;
- (NSArray<PHAsset *> * _Nullable)assetsAtIndexPaths:(NSArray<NSIndexPath *> * _Nonnull)indexPaths;
- (void)computeDifferenceBetweenRect:(CGRect)oldRect newRect:(CGRect)newRect removedHandler:(void (^ _Nonnull)(CGRect))removedHandler addedHandler:(void (^ _Nonnull)(CGRect))addedHandler;
- (void)photoLibraryDidChange:(PHChange * _Nonnull)changeInstance;
- (nonnull instancetype)initWithCollectionViewLayout:(UICollectionViewLayout * _Nonnull)layout OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
+ (UICollectionViewFlowLayout * _Nonnull)configCustomCollectionLayout;
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView * _Nonnull)collectionView;
- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)collectionView:(UICollectionView * _Nonnull)collectionView didSelectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)switchToPreView:(NSInteger)index;
- (void)onPreviewPageBack;
- (void)switchToCamera;
- (void)imagePickerController:(UIImagePickerController * _Nonnull)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> * _Nonnull)info;
- (void)image:(UIImage * _Nonnull)image didFinishSavingWithError:(NSError * _Nullable * _Null_unspecified)error contextInfo:(void const * _Null_unspecified)contextInfo;
- (void)showAlbumsList:(UIGestureRecognizer * _Nonnull)gestureRecognizer;
- (void)switchAlbums;
@end


SWIFT_CLASS("_TtC20JFacebookPhotoPicker17PhotoFetchOptions")
@interface PhotoFetchOptions : PHFetchOptions
+ (PhotoFetchOptions * _Nonnull)shareInstance;
@end

@class PHObject;

SWIFT_CLASS("_TtC20JFacebookPhotoPicker17PhotoImageManager")
@interface PhotoImageManager : PHCachingImageManager
+ (PhotoImageManager * _Nonnull)sharedManager;
- (void)getPhotoByMaxSize:(PHObject * _Nonnull)asset size:(CGFloat)size completion:(void (^ _Nonnull)(UIImage * _Nullable, NSDictionary * _Nullable))completion;
@end


SWIFT_CLASS("_TtC20JFacebookPhotoPicker25PhotoPreviewBottomBarView")
@interface PhotoPreviewBottomBarView : UIView
@property (nonatomic, strong) UIView * _Nullable doneNumberAnimationLayer;
@property (nonatomic, strong) UILabel * _Nullable labelTextView;
@property (nonatomic, strong) UIButton * _Nullable buttonDone;
@property (nonatomic, strong) UIView * _Nullable doneNumberContainer;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)eventDoneClicked;
- (void)changeNumber:(NSInteger)number animation:(BOOL)animation;
@end

@class UITapGestureRecognizer;

SWIFT_CLASS("_TtC20JFacebookPhotoPicker16PhotoPreviewCell")
@interface PhotoPreviewCell : UICollectionViewCell <UIScrollViewDelegate>
@property (nonatomic, strong) PHAsset * _Nullable model;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)configView;
- (void)renderModel:(PHAsset * _Nonnull)asset;
- (void)resizeImageView;
- (void)singleTap:(UITapGestureRecognizer * _Nonnull)tap;
- (void)doubleTap:(UITapGestureRecognizer * _Nonnull)tap;
- (UIView * _Nullable)viewForZoomingInScrollView:(UIScrollView * _Nonnull)scrollView;
- (void)scrollViewDidZoom:(UIScrollView * _Nonnull)scrollView;
@end

@class PhotoPreviewViewController;

SWIFT_CLASS("_TtC20JFacebookPhotoPicker23PhotoPreviewToolbarView")
@interface PhotoPreviewToolbarView : UIView
@property (nonatomic, weak) PhotoPreviewViewController * _Nullable sourceDelegate;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)eventBackArrow;
@end

@class NSBundle;

SWIFT_CLASS("_TtC20JFacebookPhotoPicker26PhotoPreviewViewController")
@interface PhotoPreviewViewController : UIViewController <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) PHFetchResult * _Nullable allSelectImage;
@property (nonatomic, strong) UICollectionView * _Nullable collectionView;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic, readonly, copy) NSString * _Nonnull cellIdentifier;
- (void)viewDidLoad;
- (void)onToolbarBackArrowClicked;
- (void)onSelected:(BOOL)select;
- (void)viewWillAppear:(BOOL)animated;
- (void)configCollectionView;
- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)onImageSingleTap;
- (void)scrollViewDidScroll:(UIScrollView * _Nonnull)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView * _Nonnull)scrollView;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface UICollectionView (SWIFT_EXTENSION(JFacebookPhotoPicker))
- (NSArray<NSIndexPath *> * _Nullable)aapl_indexPathsForElementsInRect:(CGRect)rect;
@end


@interface UIImage (SWIFT_EXTENSION(JFacebookPhotoPicker))

/// resize and crop image
///
/// \param toSize destnation size
///
/// \returns  destination image
- (UIImage * _Nonnull)resizeAndCropImage:(CGSize)toSize;
@end


SWIFT_CLASS("_TtC20JFacebookPhotoPicker14ViewController")
@interface ViewController : UIViewController
+ (NSInteger)imageMaxSelectedNum;
+ (void)setImageMaxSelectedNum:(NSInteger)value;
+ (NSInteger)alreadySelectedImageNum;
+ (void)setAlreadySelectedImageNum:(NSInteger)value;
- (IBAction)photoPickerClick:(id _Nonnull)sender;
- (void)onImageSelectFinished:(NSArray<PHAsset *> * _Nonnull)images;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UILongPressGestureRecognizer;

SWIFT_CLASS("_TtC20JFacebookPhotoPicker23photoCollectionViewCell")
@interface photoCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified add_btn;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified thumbnail;
@property (nonatomic, weak) PhotoCollectionViewController * _Nullable delegate;
@property (nonatomic, copy) NSString * _Nullable representedAssetIdentifier;
@property (nonatomic, strong) PHAsset * _Nullable model;
- (void)awakeFromNib;
- (void)updateSelected:(BOOL)select;
- (void)initLongPressGesture;
- (void)btnLong:(UILongPressGestureRecognizer * _Nonnull)gestureRecognizer;
- (IBAction)eventImageSelect:(UIButton * _Nonnull)sender;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
