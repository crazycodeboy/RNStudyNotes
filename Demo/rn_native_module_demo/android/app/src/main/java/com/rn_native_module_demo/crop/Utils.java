package com.rn_native_module_demo.crop;

import android.os.Environment;
import java.io.File;

/**
 * React Native Android原生模块开发
 * Author: CrazyCodeBoy
 * 技术博文：http://www.devio.org
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */

public class Utils {
    /**
     * 获取一个临时文件
     * @param fileName
     * @return
     */
    public static File getPhotoCacheDir(String fileName) {
        return new File(Environment.getExternalStorageDirectory().getAbsoluteFile(),fileName);
    }
}
