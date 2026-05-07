package com.hotely5d.controller;
import com.baomidou.mybatisplus.plugins.Page;
import com.hotely5d.entity.Operator;
import com.hotely5d.entity.model.Result;
import com.hotely5d.entity.model.StatusCode;
import com.hotely5d.service.OperatorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/operator")
public class OperatorController {

    @Autowired
    private OperatorService operatorService;

    @GetMapping("search/{current}/{size}")
    public Result search(@PathVariable Integer current, @PathVariable Integer size, Operator operator) {
        Page<Operator> page = operatorService.search(new Page<Operator>(current, size), operator);
        return new Result(true, StatusCode.OK, "查询成功", page);
    }

    @PostMapping
    public Result add(@RequestBody Operator operator) {
        operatorService.add(operator);
        return new Result(true, StatusCode.OK, "新增成功");
    }

    @PutMapping
    public Result modify(@RequestBody Operator operator) {
        operatorService.modify(operator);
        return new Result(true, StatusCode.OK, "修改成功");
    }

    @DeleteMapping("{id}")
    public Result removeById(@PathVariable("id") Integer id) {
        operatorService.removeById(id);
        return new Result(true, StatusCode.OK, "删除成功");
    }
}
