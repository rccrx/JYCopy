//
//  RCColorMacro.h
//  Pods
//
//  Created by crx on 2021/10/16.
//

#ifndef RCColorMacro_h
#define RCColorMacro_h

#define RGBA_DEC(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGB_DEC(r, g, b) RGBA_DEC(r, g, b, 1)
#define RGBA(c, a) RGBA_DEC((((int32_t)(c)) >> 16), ((((int32_t)(c)) >> 8) & 0xff), (((int32_t)(c)) & 0xff), (a))
#define ARGB(v) RGBA((((int64_t)(v)) & 0xffffff), (((int64_t)(v) >> 24)*1.0/(0xff))
#define RGB(c) RGBA(c, 1)

#endif /* RCColorMacro_h */
