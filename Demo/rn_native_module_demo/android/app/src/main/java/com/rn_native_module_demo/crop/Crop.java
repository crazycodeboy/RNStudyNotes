package com.rn_native_module_demo.crop;

import com.facebook.react.bridge.Promise;

/**
 * React Native Android原生模块开发
 * Author: CrazyCodeBoy
 * 技术博文：http://www.devio.org
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */

public interface Crop {
    /**
     * 选择并裁切照片
     * @param outputX
     * @param outputY
     * @param promise
     */
    void selectWithCrop(int outputX,int outputY,Promise promise);
}
