package com.hotely5d.controller;
import com.baomidou.mybatisplus.plugins.Page;
import com.hotely5d.entity.ScenicSpot;
import com.hotely5d.entity.model.Result;
import com.hotely5d.entity.model.StatusCode;
import com.hotely5d.service.ScenicSpotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/scenic-spot")
public class ScenicSpotController {

    @Autowired
    private ScenicSpotService scenicSpotService;

    @GetMapping
    public Result findAll() {
        List<ScenicSpot> list = scenicSpotService.findAll();
        return new Result(true, StatusCode.OK, "查询成功", list);
    }

    @GetMapping("search/{current}/{size}")
    public Result search(@PathVariable Integer current, @PathVariable Integer size, ScenicSpot scenicSpot) {
        Page<ScenicSpot> page = scenicSpotService.search(new Page<ScenicSpot>(current, size), scenicSpot);
        return new Result(true, StatusCode.OK, "查询成功", page);
    }

    @GetMapping("{id}")
    public Result findById(@PathVariable("id") Integer id) {
        ScenicSpot scenicSpot = scenicSpotService.findById(id);
        return new Result(true, StatusCode.OK, "查询成功", scenicSpot);
    }

    @PostMapping
    public Result add(@RequestBody ScenicSpot scenicSpot) {
        scenicSpotService.add(scenicSpot);
        return new Result(true, StatusCode.OK, "新增成功");
    }

    @PutMapping
    public Result modify(@RequestBody ScenicSpot scenicSpot) {
        scenicSpotService.modify(scenicSpot);
        return new Result(true, StatusCode.OK, "修改成功");
    }

    @DeleteMapping("{id}")
    public Result removeById(@PathVariable("id") Integer id) {
        scenicSpotService.removeById(id);
        return new Result(true, StatusCode.OK, "删除成功");
    }
}
