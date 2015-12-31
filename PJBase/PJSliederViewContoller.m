//
//  PJSliederViewContoller.m
//  PJRichText
//
//  Created by yangjuanping on 15/12/1.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJSliederViewContoller.h"
#import "PJBaseViewController.h"

#define MAXYOFFSET  (SCREENHEIGHT/6)
#define ENDLEFTX    (SCREENWIDTH/3)
#define ENDRIGHTX   (2*SCREENWIDTH/3)

/*一.开始启动的时候，新建3个不同颜色的View的*/
@interface PJSliederViewContoller()

//1.设置3个成员属性，记录三种颜色的View
@property (nonatomic,weak) PJBaseViewController* leftView;
@property (nonatomic,weak) PJBaseViewController* mainView;
@property (nonatomic,weak) PJBaseViewController* rightView;
@property (nonatomic,assign)PJSlider_Modal       slideModal;
@end

@implementation PJSliederViewContoller

-(id)initWithLeft:(PJBaseViewController*)leftView Main:(PJBaseViewController*)mainView Right:(PJBaseViewController*)rightView{
    if (!mainView) {
        return nil;
    }
    
    if (self == [super init]) {
        _leftView = leftView;
        _mainView = mainView;
        _rightView = rightView;
    }
    return self;
}

-(void)setSlideModal:(PJSlider_Modal)slideModal Scal:(CGFloat)scal{
    if (_leftView && _rightView) {
        _slideModal = slideModal;
        _fScal = scal;
    }
    
    if (!_leftView && !_rightView) {
        _slideModal = PJSlider_Modal_No;
        _fScal = 0;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
//2.初始化3个View
- (void)setUpthreeViews{
}

二.实现滑动的效果

//1.通过-(void)touchesMoved:(NSSet)touches withEvent:(UIEvent)event方法来获得当前点和初始点，从而计算出偏移量,然后计算redView的frame的值：
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];//获得当前点
    CGPoint currentPoint = [touch locationInView:_redView];    //获得起点
    CGPoint prePoint = [touch previousLocationInView:_redView];    //计算在x轴方向上的偏移量
    CGFloat moveX = currentPoint.x - prePoint.x;    //然后通过在x轴上的偏移量，计算redView的frame.
    _redView.frame = [self framWithOffsetX:moveX];
}

//假设x移到320时，y移动到60，算出每移动一点x，移动多少y
//    ffsetY = offsetX * 600 / 320 手指每移动一点，x轴偏移量多少，y偏移多少
//    为了好看，x移动到320，距离上下的高度需要保持一致，而且有一定的比例去缩放他的尺寸。 touchMove只能拿到之前的frame.当前的高度 = 之前的高度 * 这个比例
//    缩放比例：当前的高度/之前的高度 (screenH - 2 * offsetY) / screenH。
//    当前的宽度保持不变就行。 y值，计算比较特殊，不能直接用之前的y,加上offsetY,往左滑动，主视图应该往下走，但是offsetX是负数，导致主视图会往上走。所以需要判断是左滑还是右滑
- (CGRect)framWithOffsetX:(CGFloat)offsetX{    //计算在y轴方向上的偏移量
    CGFloat offsetY = offsetX/SCREENWIDTH * MAXYOFFSET;    //根据y方向的偏移量计算缩放比例
    CGFloat scale = (SCREENHEIGHT - 2*offsetY)/SCREENHEIGHT;    //如果x < 0表示左滑
    if (_redView.frame.origin.x < 0) {
        scale = (SCREENHEIGHT + 2*offsetY)/SCREENHEIGHT;
    }    CGRect frame = _redView.frame;    //计算滑动之后的frame.
    CGFloat height = frame.size.height*scale;
    CGFloat width  = frame.size.width;
    CGFloat x = frame.origin.x + offsetX;
    CGFloat y = (SCREENHEIGHT- height)* 0.5;
    return CGRectMake(x, y, width, height);
}
//        2.通过KVO来监听redView的frame的变化，从而判断redView是左滑还是右滑。往左移动，显示右边，隐藏左边 往右移动，显示左边，隐藏右边
- (void)viewDidLoad {
    [super viewDidLoad];    [self setUpthreeViews];
    // 利用KVO时刻监听_redView.frame改变
    // Observer:谁需要观察
    // KeyPath：监听的属性名称
    // options: NSKeyValueObservingOptionNew监听这个属性新值
    //[_redView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    if (<#condition#>) {
        <#statements#>
    }
}

// 只要监听的属性有新值的时候，只要redView.frame一改变就会调用
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    if (self.redView.frame.origin.x > 0) {
//        _greenView.hidden = NO;
//    }
//    else if(self.redView.frame.origin.x < 0){
//        _greenView.hidden = YES;
//    }
//}
// 当对象销毁的时候，一定要移除观察者
- (void)dealloc{
    [_redView removeObserver:self forKeyPath:@"frame"];
}
//            3.设置触摸结束的时候，redView的frame。如果redView侧滑没有到屏幕的一半，则自动返回到初始位置。如果超过屏幕的一半，则停留在一个新的位置
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGFloat xPos = _redView.frame.origin.x;    //大于屏幕的一半进入新的位置
    if (xPos > SCREENWIDTH*0.5) {
        [UIView animateWithDuration:0.5 animations:^{
            self.redView.frame = [self framWithBigThanX:ENDRIGHTX];
        }];
        return ;
    }    //小于屏幕的一半，大于屏幕负一半的时候，则恢复到初始状态
    if (xPos < SCREENWIDTH*0.5 && xPos > -SCREENWIDTH*0.5) {
        [UIView animateWithDuration:0.5 animations:^{
            self.redView.frame = [UIScreen mainScreen].bounds;
        }];
        return ;
    }    //xPos < -SCREENWIDTH*0.5的时候，进入新的位置
    [UIView animateWithDuration:0.5 animations:^{
        self.redView.frame =  [self framWithSmallThanX:ENDLEFTX];
    }];
}

- (CGRect)framWithBigThanX:(CGFloat)offsetX{
    CGFloat offsetY = offsetX/SCREENWIDTH * MAXYOFFSET;
    CGFloat scale = (SCREENHEIGHT - 2*offsetY)/SCREENHEIGHT;
    CGFloat height = SCREENHEIGHT*scale;
    CGFloat width  = SCREENWIDTH;
    CGFloat x = offsetX;
    CGFloat y = (SCREENHEIGHT- height)* 0.5;
    return CGRectMake(x, y, width, height);
}

- (CGRect)framWithSmallThanX:(CGFloat)offsetX{
    CGFloat offsetY = offsetX/SCREENWIDTH * MAXYOFFSET;
    CGFloat scale = (SCREENHEIGHT + 2*offsetY)/SCREENHEIGHT;
    CGFloat height = SCREENHEIGHT*scale;
    CGFloat width  = SCREENWIDTH;
    CGFloat x = offsetX;
    CGFloat y = (SCREENHEIGHT- height)* 0.5;
    return CGRectMake(x, y, width, height);
}*/
@end
