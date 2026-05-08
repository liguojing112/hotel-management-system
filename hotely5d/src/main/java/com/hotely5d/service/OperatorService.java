package com.hotely5d.service;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hotely5d.dao.OperatorMapper;
import com.hotely5d.entity.Operator;
import com.hotely5d.entity.model.Result;
import com.hotely5d.entity.model.StatusCode;
import com.hotely5d.entity.query.LoginQuery;
import com.hotely5d.utils.JWTUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class OperatorService {

    @Autowired
    private OperatorMapper operatorMapper;

    public List<Operator> findAll() {
        return operatorMapper.selectList(null);
    }

    public Page<Operator> search(Page<Operator> page, Operator operator) {
        return page.setRecords(operatorMapper.selectPage(page, getEntityWrapper(operator)));
    }

    private EntityWrapper getEntityWrapper(Operator operator) {
        EntityWrapper entityWrapper = new EntityWrapper();
        if (null != operator) {
            if (!StringUtils.isEmpty(operator.getUsername())) {
                entityWrapper.like("username", String.valueOf(operator.getUsername()));
            }
            if (!StringUtils.isEmpty(operator.getName())) {
                entityWrapper.like("name", String.valueOf(operator.getName()));
            }
            if (!StringUtils.isEmpty(operator.getPhone())) {
                entityWrapper.like("phone", String.valueOf(operator.getPhone()));
            }
        }
        return entityWrapper;
    }

    public void modify(Operator operator) {
        operatorMapper.updateById(operator);
    }

    public void add(Operator operator) {
        operatorMapper.insert(operator);
    }

    public Operator findById(Integer id) {
        return operatorMapper.selectById(id);
    }

    public void removeById(Integer id) {
        operatorMapper.deleteById(id);
    }

    public String resetPassword(Integer id) {
        Operator operator = operatorMapper.selectById(id);
        operator.setPassword("123456");
        operatorMapper.updateById(operator);
        return operator.getPassword();
    }

    public Result login(LoginQuery query) {
        List<Operator> list = operatorMapper.selectList(new EntityWrapper().eq("username", query.getUsername()).eq("password", query.getPassword()));
        if (list.size() == 0) return new Result(false, StatusCode.ERROR, "账号或密码错误");
        Map<String, String> payloadMap = new HashMap();
        payloadMap.put("id", list.get(0).getId().toString());
        payloadMap.put("role", "3");
        String token = JWTUtils.getToken(payloadMap);
        return new Result(true, StatusCode.OK, "登录成功", token);
    }
}
