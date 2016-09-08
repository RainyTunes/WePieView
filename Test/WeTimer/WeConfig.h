//
//  Header.h
//  Test
//
//  Created by RainyTunes on 16/9/6.
//  Copyright © 2016年 We.Can. All rights reserved.
//

#ifndef Header_h
#define Header_h

const static CGFloat color[10][3]     = {{185/255.0,230/255.0,254/255.0},
    {207/255.0,205/255.0,252/255.0},
    {158/255.0,252/255.0,238/255.0},
    {254/255.0,199/255.0,227/255.0}};
const static CGFloat colorLine[10][3] = {{125/255.0,201/255.0,241/255.0},
    {170/255.0,165/255.0,253/255.0},
    {96/255.0,226/255.0,207/255.0},
    {238/255.0,135/255.0,187/255.0}};

const static int INITIAL_ANGLE = 75;
const static CGFloat gapAngle = 3;//饼之间的间隙角度
const static CGFloat borderAngle = 3;//饼的圆角所占用的角度

#define WE_TIMER_DEBUG 0

#ifndef WeLog
#define WeLog(FORMAT, ...) if(WE_TIMER_DEBUG)NSLog(FORMAT,##__VA_ARGS__)
#endif

#ifndef NUM_RECT
#define NUM_RECT CGRectMake(0, 0, 100, 14)
#define WeLog(FORMAT, ...) if(WE_TIMER_DEBUG)NSLog(FORMAT,##__VA_ARGS__)
#endif

//#ifndef PI
//#define PI 3.14159265358979323846
//#endif
//
//#ifndef RAD_0
//#define RAD_0 180 / PI
//#endif

#ifndef radiansToRad
#define radiansToRad(x) x * 3.14 / 180.0
#endif


//static inline float radians(CGFloat degrees) {
//    return degrees * PI / 180;
//}

#endif /* Header_h */
