package com.hotely5d.controller;

import com.hotely5d.entity.model.Result;
import com.hotely5d.entity.model.StatusCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.time.LocalDate;
import java.util.Random;
@RestController
@RequestMapping("/file")
public class FileController {   //公用文件上传服务
    @Value("${upload.urlPrefix}")
    private String urlPrefix;//图片url前缀

    /**
     * 统一上传接口
     */
    @RequestMapping(value="/uploadPhoto",method= RequestMethod.POST)
    @ResponseBody
    public Result upload(@RequestParam(name="photo",required=true) MultipartFile file){
        return  uploadMultipartFile(file);
    }

    public Result uploadMultipartFile(MultipartFile file){
        String originalFilename = file.getOriginalFilename();
        //获取文件后缀
        String suffix = originalFilename.substring(originalFilename.lastIndexOf("."),originalFilename.length());

//if(!uploadSufix.contains(suffix.toLowerCase())){
// return new Result(StatusCode.ERROR,false,"图片格式不合法");
//}
//if(file.getSize()/1024 > uploadMaxSize){
//   return new Result(StatusCode.ERROR,false,"图片大小不合法");
//}

        // 获取目录层级（随机或按年月日打散文件）
        String dir1 = getRandomChar();
        String dir2 = getRandomChar();
        String dir3 = getRandomChar();

//        LocalDate currentDate = LocalDate.now();// 获取当前日期
//        String dir1 = String.valueOf(currentDate.getYear());
//        String dir2 = String.valueOf(currentDate.getMonthValue());
//        String dir3 = String.valueOf(currentDate.getDayOfMonth());

        //准备保存文件
        String savePath = null;
        try {
            savePath = new File(".").getCanonicalPath();//当前项目目录
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("获取文件上传的路径失败！！！");
        }
        savePath = savePath +File.separator+ "upload" + File.separator+dir1+File.separator+dir2+File.separator+dir3; //文件保存路径
        File filePath = new File(savePath);
        if(!filePath.exists()){
            //若不存在文件夹，则创建一个文件夹
            filePath.mkdir();
        }
        String filename = generateUniqueNumber() + suffix;
        try {
            new File(savePath+File.separator+filename).getParentFile().mkdirs();
            file.transferTo(new File(savePath+File.separator+filename));
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map map = new HashMap();
        map.put("filename",dir1+"/"+dir2+"/"+dir3+"/"+filename);
        map.put("url",urlPrefix+dir1+"/"+dir2+"/"+dir3+"/"+filename);
        return new Result(true, StatusCode.OK,"上传成功",map);
    }

    //获取一个随机字符
    public static String getRandomChar() {
        String str = "0123456789abcdefghijklmnopqrstuvwxyz";
        Random random = new Random();
        int index = random.nextInt(str.length());
        return String.valueOf(str.charAt(index));
    }

    //获取唯一的数字字符串
    public static String generateUniqueNumber() {
        // 获取当前时间戳
        long timestamp = System.currentTimeMillis();

        // 生成一个随机数
        Random random = new Random();
        int randomNumber = random.nextInt(900000) + 100000; // 生成六位随机数

        // 拼接时间戳和随机数，生成唯一数字字符串
        return String.valueOf(timestamp) + randomNumber;
    }
}