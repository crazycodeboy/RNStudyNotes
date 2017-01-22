package com.rn_native_module_demo.crop;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

/**
 * React Native Android原生模块开发
 * Author: CrazyCodeBoy
 * 技术博文：http://www.devio.org
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */

public class ImageCropModule extends ReactContextBaseJavaModule implements Crop{
    private CropImpl cropImpl;
    public ImageCropModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "ImageCrop";
    }

    @Override @ReactMethod
    public void selectWithCrop(int aspectX, int aspectY, Promise promise) {
        getCrop().selectWithCrop(aspectX,aspectY,promise);
    }
    private CropImpl getCrop(){
        if(cropImpl==null){
            cropImpl=CropImpl.of(getCurrentActivity());
            getReactApplicationContext().addActivityEventListener(cropImpl);
        }else {
            cropImpl.updateActivity(getCurrentActivity());
        }
        return cropImpl;
    }
}
