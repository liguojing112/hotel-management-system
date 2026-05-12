package com.hotely5d.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.List;

@Component
public class DatabaseInitializer {

    private static final Logger log = LoggerFactory.getLogger(DatabaseInitializer.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @PostConstruct
    public void init() {
        initScenicSpotTable();
        initCategoryCoordColumns();
    }

    private void initScenicSpotTable() {
        try {
            List<String> tables = jdbcTemplate.queryForList(
                "SHOW TABLES LIKE 'scenic_spot'", String.class);
            if (!tables.isEmpty()) {
                log.info("scenic_spot 表已存在，跳过创建");
                return;
            }
            jdbcTemplate.execute(
                "CREATE TABLE scenic_spot (" +
                "  id INT NOT NULL AUTO_INCREMENT COMMENT 'ID'," +
                "  city_name VARCHAR(100) NOT NULL COMMENT '景区名称'," +
                "  lat DOUBLE DEFAULT NULL COMMENT '纬度'," +
                "  lng DOUBLE DEFAULT NULL COMMENT '经度'," +
                "  PRIMARY KEY (id)" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='景区坐标配置'");
            jdbcTemplate.execute(
                "INSERT INTO scenic_spot (city_name) VALUES " +
                "('漓江'),('象鼻山'),('阳朔西街'),('龙脊梯田'),('两江四湖')," +
                "('银子岩'),('兴坪古镇'),('遇龙河'),('十里画廊'),('世外桃源'),('靖江王府')");
            log.info("scenic_spot 表创建成功，已预填 11 个景区");
        } catch (Exception e) {
            log.warn("scenic_spot 表初始化失败（可忽略，服务器启动后手动执行 SQL 即可）: {}", e.getMessage());
        }
    }

    private void initCategoryCoordColumns() {
        try {
            List<String> columns = jdbcTemplate.queryForList(
                "SHOW COLUMNS FROM category LIKE 'lat'", String.class);
            if (!columns.isEmpty()) {
                return;
            }
            jdbcTemplate.execute("ALTER TABLE category ADD COLUMN lat DOUBLE DEFAULT NULL COMMENT '纬度'");
            jdbcTemplate.execute("ALTER TABLE category ADD COLUMN lng DOUBLE DEFAULT NULL COMMENT '经度'");
            log.info("category 表已添加 lat/lng 坐标字段");
        } catch (Exception e) {
            log.warn("category 表坐标字段添加失败（可忽略）: {}", e.getMessage());
        }
    }
}
