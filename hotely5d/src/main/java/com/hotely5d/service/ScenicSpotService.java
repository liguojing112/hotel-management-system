package com.hotely5d.service;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hotely5d.dao.ScenicSpotMapper;
import com.hotely5d.entity.ScenicSpot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
@Transactional
public class ScenicSpotService {

    @Autowired
    private ScenicSpotMapper scenicSpotMapper;

    public List<ScenicSpot> findAll() {
        return scenicSpotMapper.selectList(null);
    }

    public Page<ScenicSpot> search(Page<ScenicSpot> page, ScenicSpot scenicSpot) {
        return page.setRecords(scenicSpotMapper.selectPage(page, getEntityWrapper(scenicSpot)));
    }

    public List<ScenicSpot> search(ScenicSpot scenicSpot) {
        return scenicSpotMapper.selectList(getEntityWrapper(scenicSpot));
    }

    private EntityWrapper getEntityWrapper(ScenicSpot scenicSpot) {
        EntityWrapper entityWrapper = new EntityWrapper();
        if (null != scenicSpot) {
            if (!StringUtils.isEmpty(scenicSpot.getCityName())) {
                entityWrapper.like("city_name", String.valueOf(scenicSpot.getCityName()));
            }
        }
        return entityWrapper;
    }

    public void modify(ScenicSpot scenicSpot) {
        scenicSpotMapper.updateById(scenicSpot);
    }

    public void add(ScenicSpot scenicSpot) {
        scenicSpotMapper.insert(scenicSpot);
    }

    public ScenicSpot findById(Integer id) {
        return scenicSpotMapper.selectById(id);
    }

    public void removeById(Integer id) {
        scenicSpotMapper.deleteById(id);
    }
}
