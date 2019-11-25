package com.jk.minimalism.util;

import com.jk.minimalism.bean.page.PageTableRequest;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.mapping.ResultMap;
import org.apache.ibatis.mapping.ResultMapping;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.jk.minimalism.bean.constant.SysConstants.DEFAULT_MAPPER_RESULT_MAP;

/**
 * @author admin-jk
 * @date 19-8-14
 */
public class MapperColumnUtil {

    /**
     * 获取java类属性和表字段对应关系
     *
     * @param mapper     mapper
     * @param resultMaps mapper 返回值列表
     * @return 对象属性和数据库字段映射关系map
     */
    public static Map<String, String> getColumnPro(Class<?> mapper, String... resultMaps) {
        Map<String, String> map = new HashMap<>(20);
        SqlSessionFactory sessionFactory = SpringUtil.getBean(SqlSessionFactory.class);
        ResultMap resultMap = sessionFactory.getConfiguration()
                .getResultMap(mapper.getName() + "." + (resultMaps.length == 0 ? DEFAULT_MAPPER_RESULT_MAP : resultMaps[0]));
        if (resultMap != null) {
            List<ResultMapping> list = resultMap.getResultMappings();
            list.forEach(rm -> {
                String column = rm.getColumn();
                String pro = rm.getProperty();
                if (StringUtils.isNoneBlank(column) && StringUtils.isNotBlank(pro)) {
                    map.put(pro, column);
                }
            });
        }
        return map;
    }

    /**
     * 将java类属性替换为表字段
     */
    public static String pro2Column(PageTableRequest request, Map<String, String> map) {
        String orderBy = (String) request.getParams().get("orderBy");
        if (StringUtils.isNoneBlank(orderBy) && !CollectionUtils.isEmpty(map)) {
            for (String pro : map.keySet()) {
                String val = map.get(pro);
                if (StringUtils.isNoneBlank(val)) {
                    orderBy = orderBy.replace(pro, val);
                }
            }

            request.getParams().put("orderBy", orderBy);
        }

        return orderBy;
    }
}
