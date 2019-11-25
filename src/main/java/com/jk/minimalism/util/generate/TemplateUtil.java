package com.jk.minimalism.util.generate;

import com.jk.minimalism.bean.dto.GenerateInput;
import com.jk.minimalism.util.FileUtil;
import com.jk.minimalism.util.StrUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @author admin-jk
 */
public class TemplateUtil {

    private static final Logger log = LoggerFactory.getLogger("adminLogger");

    private static String getTemplete(String fileName) {
        return FileUtil.getText(TemplateUtil.class.getClassLoader().getResourceAsStream("generate/" + fileName));
    }

    public static void saveJava(GenerateInput input) {
        String path = input.getPath();
        String beanPackageName = input.getBeanPackageName();
        String beanName = input.getBeanName();
        String tableName = input.getTableName();
        List<String> beanFieldName = input.getBeanFieldName();
        List<String> beanFieldType = input.getBeanFieldType();
        List<String> columnNames = input.getColumnNames();
        List<String> beanComments = input.getBeanComment();

        String text = getTemplete("java.txt");
        text = text.replace("{beanPackageName}", beanPackageName).replace("{beanName}", beanName);

        String imports = "";
        if (beanFieldType.contains(BigDecimal.class.getSimpleName())) {
            imports += "import " + BigDecimal.class.getName() + ";\n";
        }
        if (beanFieldType.contains(Date.class.getSimpleName())) {
            imports += "import " + Date.class.getName() + ";";
        }

        text = text.replace("{import}", imports);
        text = text.replace("{tableName}", tableName);
        String filelds = getFields(beanFieldName, beanFieldType, columnNames, beanComments);
        text = text.replace("{filelds}", filelds);


        FileUtil.saveTextFile(text, path + File.separator + getPackagePath(beanPackageName) + beanName + ".java");
        log.debug("生成java model：{}模板", beanName);
    }

    private static String getFields(List<String> beanFieldName, List<String> beanFieldType, List<String> beanColumnName, List<String> beanComments) {
        StringBuilder buffer = new StringBuilder();
        int size = beanFieldName.size();
        for (int i = 0; i < size; i++) {
            String name = beanFieldName.get(i);
//            if ("id".equals(name) || "createTime".equals(name) || "updateTime".equals(name)) {
//                continue;
//            }
            String type = beanFieldType.get(i);
            String columnName = beanColumnName.get(i);
            String beanComment = beanComments.get(i);
            buffer.append("\t/**\n").append("\t* ").append(beanComment).append("\n\t*/\n");
            if ("id".equals(name)) {
                buffer.append("\t@Id\n");
            }
            buffer.append("\t@Column(name = \"").append(columnName).append("\")\n");
            buffer.append("\tprivate ").append(type).append(" ").append(name);
            buffer.append(";\n\n");
        }

        return buffer.toString();
    }

    private static String getSysFields(List<String> beanFieldName, List<String> beanFieldType, List<String> beanComments) {
        StringBuilder buffer = new StringBuilder();
        int size = beanFieldName.size();
        for (int i = 0; i < size; i++) {
            String name = beanFieldName.get(i);
            if ("createTime".equals(name) || "updateTime".equals(name)) {
                continue;
            }
            String type = beanFieldType.get(i);
            buffer.append("\t@ApiModelProperty(value = \"").append(beanComments.get(i)).append("\")\n");
            buffer.append("\tprivate ").append(type).append(" ").append(name);
            buffer.append(";\n\n");
        }

        return buffer.toString();
    }

    private static String getset(List<String> beanFieldName, List<String> beanFieldType) {
        StringBuilder buffer = new StringBuilder();
        int size = beanFieldName.size();
        for (int i = 0; i < size; i++) {
            String name = beanFieldName.get(i);
            if ("id".equals(name) || "createTime".equals(name) || "updateTime".equals(name)) {
                continue;
            }

            String type = beanFieldType.get(i);
            buffer.append("\tpublic ").append(type).append(" get").append(StringUtils.substring(name, 0, 1).toUpperCase()).append(name.substring(1))
                    .append("() {\n");
            buffer.append("\t\treturn ").append(name).append(";\n");
            buffer.append("\t}\n");
            buffer.append("\tpublic void set").append(StringUtils.substring(name, 0, 1).toUpperCase()).append(name.substring(1))
                    .append("(").append(type).append(" ").append(name).append(") {\n");
            buffer.append("\t\tthis.").append(name).append(" = ").append(name).append(";\n");
            buffer.append("\t}\n");
        }

        return buffer.toString();
    }

    public static void saveJavaDao(GenerateInput input) {
        String path = input.getPath();
        String tableName = input.getTableName();
        String beanPackageName = input.getBeanPackageName();
        String beanName = input.getBeanName();
        String daoPackageName = input.getDaoPackageName();
        String daoName = input.getDaoName();

        String text = getTemplete("dao.txt");
        text = text.replace("{daoPackageName}", daoPackageName);
        text = text.replace("{beanPackageName}", beanPackageName);
        text = text.replace("{daoName}", daoName);
        text = text.replace("{table_name}", tableName);
        text = text.replace("{beanName}", beanName);
        text = text.replace("{beanParamName}", lowerFirstChar(beanName));

        String insertColumns = getInsertColumns(input.getColumnNames());
        text = text.replace("{insert_columns}", insertColumns);
        String insertValues = getInsertValues(input.getColumnNames(), input.getBeanFieldName());
        text = text.replace("{insert_values}", insertValues);
        FileUtil.saveTextFile(text, path + File.separator + getPackagePath(daoPackageName) + daoName + ".java");
        log.debug("生成java dao：{}模板", beanName);

        text = getTemplete("mapper.xml");
        text = text.replace("{daoPackageName}", daoPackageName);
        text = text.replace("{daoName}", daoName);
        text = text.replace("{table_name}", tableName);
        text = text.replace("{beanName}", beanName);
        text = text.replace("{beanPackageName}", beanPackageName);
        String sets = getUpdateSets(input.getColumnNames(), input.getBeanFieldName());
        text = text.replace("{update_sets}", sets);
        String where = getWhere(input.getColumnNames(), input.getBeanFieldName());
        text = text.replace("{where}", where);
        String resultMapper = getResultMapper(input.getColumnNames(), input.getBeanFieldName());
        text = text.replace("{resultMapper}", resultMapper);
        FileUtil.saveTextFile(text, path + File.separator + beanName + "Mapper.xml");
    }

    public static void saveJavaService(GenerateInput input) {
        String path = input.getPath();
        String serviceImplPackageName = input.getServiceImplPkgName();
        String serviceImplName = input.getServiceImplName();
        String servicePackageName = input.getServicePkgName();
        String serviceName = input.getServiceName();
        String beanPackageName = input.getBeanPackageName();
        String beanName = input.getBeanName();
        String daoPackageName = input.getDaoPackageName();
        String daoName = input.getDaoName();

        String text = getTemplete("service.txt");
        text = text.replace("{servicePackageName}", servicePackageName);
        text = text.replace("{serviceName}", serviceName);
        text = text.replace("{beanPackageName}", beanPackageName);
        text = text.replace("{beanName}", beanName);
        text = text.replace("{beanParamName}", lowerFirstChar(beanName));

        FileUtil.saveTextFile(text, path + File.separator + getPackagePath(servicePackageName) + serviceName + ".java");
        log.debug("生成java service：{}模板", serviceName);

        text = getTemplete("serviceImpl.txt");

        text = text.replace("{serviceImplPackageName}", serviceImplPackageName);
        text = text.replace("{serviceImplName}", serviceImplName);
        text = text.replace("{servicePackageName}", servicePackageName);
        text = text.replace("{serviceName}", serviceName);
        text = text.replace("{beanPackageName}", beanPackageName);
        text = text.replace("{beanName}", beanName);
        text = text.replace("{beanParamName}", lowerFirstChar(beanName));
        text = text.replace("{daoPackageName}", daoPackageName);
        text = text.replace("{daoName}", daoName);
        text = text.replace("{daoParamName}", lowerFirstChar(daoName));

        FileUtil.saveTextFile(text, path + File.separator + getPackagePath(serviceImplPackageName) + serviceImplName + ".java");
        log.debug("生成java serviceImpl：{}模板", serviceImplName);


    }

    public static void saveJavaDTO(GenerateInput input) {
        String path = input.getPath();
        String dtoPackageName = input.getDtoPkgName();
        String dtoName = input.getDtoName();
        List<String> beanFieldName = input.getBeanFieldName();
        List<String> beanFieldType = input.getBeanFieldType();
        List<String> beanComments = input.getBeanComment();

        String text = getTemplete("sysDTO.txt");
        text = text.replace("{dtoPackageName}", dtoPackageName);
        text = text.replace("{dtoName}", dtoName);
        text = text.replace("{filelds}", getSysFields(beanFieldName, beanFieldType, beanComments));

        FileUtil.saveTextFile(text, path + File.separator + getPackagePath(dtoPackageName) + dtoName + ".java");
        log.debug("生成java dto：{}模板", dtoName);


    }

    public static void saveSysXML(GenerateInput input) {

        String path = input.getPath();
        String tableName = input.getTableName();
        String daoPackageName = input.getDaoPackageName();
        String daoName = input.getDaoName();
        String dtoPackageName = input.getDtoPkgName();
        String dtoName = input.getDtoName();
        String beanName = input.getBeanName();


        String text = getTemplete("sysMapper.xml");
        text = text.replace("{daoPackageName}", daoPackageName);
        text = text.replace("{daoName}", daoName);
        text = text.replace("{dtoPackageName}", dtoPackageName);
        text = text.replace("{dtoName}", dtoName);
        text = text.replace("{table_name}", tableName);
        String resultMapper = getResultMapper(input.getColumnNames(), input.getBeanFieldName());
        text = text.replace("{resultMapper}", resultMapper);
        FileUtil.saveTextFile(text, path + File.separator + beanName + "Mapper.xml");
        log.debug("生成java mapper：{}模板", beanName + "Mapper");


        text = getTemplete("sysDao.txt");
        text = text.replace("{daoPackageName}", daoPackageName);
        text = text.replace("{daoName}", daoName);
        text = text.replace("{dtoPackageName}", dtoPackageName);
        text = text.replace("{dtoName}", dtoName);

        FileUtil.saveTextFile(text, path + File.separator + getPackagePath(daoPackageName) + daoName + ".java");
        log.debug("生成java dao：{}模板", daoName);

    }

    private static String getInsertValues(List<String> columnNames, List<String> beanFieldName) {
        StringBuilder buffer = new StringBuilder();
        int size = columnNames.size();
        for (int i = 0; i < size; i++) {
            String column = columnNames.get(i);
            if (!"id".equals(column)) {
                buffer.append("#{").append(beanFieldName.get(i)).append("}, ");
            }
        }

        return StringUtils.substringBeforeLast(buffer.toString(), ",");
    }

    private static String getInsertColumns(List<String> columnNames) {
        StringBuilder buffer = new StringBuilder();
        for (String column : columnNames) {
            if (!"id".equals(column)) {
                buffer.append(column).append(", ");
            }
        }
        return StringUtils.substringBeforeLast(buffer.toString(), ",");
    }

    private static String getUpdateSets(List<String> columnNames, List<String> beanFieldName) {
        StringBuilder buffer = new StringBuilder();
        int size = columnNames.size();
        for (int i = 0; i < size; i++) {
            String column = columnNames.get(i);
            if (!"id".equals(column)) {
                buffer.append("\t\t\t<if test=\"").append(beanFieldName.get(i)).append(" != null\">\n");
                buffer.append("\t\t\t\t").append(column).append(" = ").append("#{").append(beanFieldName.get(i))
                        .append("}, \n");
                buffer.append("\t\t\t</if>\n");
            }
        }

        return buffer.toString();
    }

    private static String getWhere(List<String> columnNames, List<String> beanFieldName) {
        StringBuilder buffer = new StringBuilder();
        int size = columnNames.size();
        for (int i = 0; i < size; i++) {
            String column = columnNames.get(i);
            buffer.append("\t\t\t<if test=\"params.").append(beanFieldName.get(i)).append(" != null and params.").append(beanFieldName.get(i)).append(" != ''\">\n");
            buffer.append("\t\t\t\tand ").append(column).append(" = ").append("#{params.").append(beanFieldName.get(i))
                    .append("} \n");
            buffer.append("\t\t\t</if>\n");
        }

        return buffer.toString();
    }

    private static String getResultMapper(List<String> columnNames, List<String> beanFieldName) {
        StringBuilder buffer = new StringBuilder();
        int size = columnNames.size();
        buffer.append("\t\t<id column=\"").append(columnNames.get(0)).append("\" property=\"").append(beanFieldName.get(0)).append("\"/>\n");
        for (int i = 1; i < size; i++) {
            String column = columnNames.get(i);
            buffer.append("\t\t<result column=\"").append(column).append("\" property=\"").append(beanFieldName.get(i)).append("\"/>\n");
        }
        return buffer.toString();
    }

    private static String lowerFirstChar(String beanName) {
        String name = StrUtil.str2hump(beanName);
        String firstChar = name.substring(0, 1);
        name = name.replaceFirst(firstChar, firstChar.toLowerCase());

        return name;
    }

    private static String getPackagePath(String packageName) {
        String packagePath = packageName.replace(".", "/");
        if (!packagePath.endsWith(File.separator)) {
            packagePath = packagePath + "/";
        }

        return packagePath;
    }

    public static void saveController(GenerateInput input) {
        String path = input.getPath();
        String beanPackageName = input.getBeanPackageName();
        String beanName = input.getBeanName();
        String servicePackageName = input.getServicePkgName();
        String serviceName = input.getServiceName();
        String daoName = input.getDaoName();
        String daoPackageName = input.getDaoPackageName();

        String text = getTemplete("controller.txt");
        text = text.replace("{beanPackageName}", beanPackageName);
        text = text.replace("{serviceName}", serviceName);
        text = text.replace("{serviceParamName}", lowerFirstChar(serviceName));
        text = text.replace("{servicePackageName}", servicePackageName);
        text = text.replace("{beanName}", beanName);
        text = text.replace("{daoName}", daoName);
        text = text.replace("{daoPackageName}", daoPackageName);
        text = text.replace("{beanParamName}", lowerFirstChar(beanName));
        text = text.replace("{controllerPkgName}", input.getControllerPkgName());
        text = text.replace("{controllerName}", input.getControllerName());

        FileUtil.saveTextFile(text, path + File.separator + getPackagePath(input.getControllerPkgName())
                + input.getControllerName() + ".java");
        log.debug("生成controller：{}模板", beanName);
    }

    public static void saveHtmlList(GenerateInput input) {
        String path = input.getPath();
        String beanName = input.getBeanName();
        String beanParamName = lowerFirstChar(beanName);

        String text = getTemplete("htmlList.txt");
        text = text.replace("{beanParamName}", beanParamName);
        text = text.replace("{beanName}", beanName);
        List<String> beanFieldNames = input.getBeanFieldName();
        text = text.replace("{columnsDatas}", getHtmlColumnsDatas(beanFieldNames));
        text = text.replace("{ths}", getHtmlThs(input.getBeanComment(), beanFieldNames));

        FileUtil.saveTextFile(text, path + File.separator + beanParamName + "List.html");
        log.debug("生成查询页面：{}模板", beanName);

        text = getTemplete("htmlAdd.txt");
        text = text.replace("{beanParamName}", beanParamName);
        text = text.replace("{addDivs}", getAddDivs(beanFieldNames));
        FileUtil.saveTextFile(text, path + File.separator + "add" + beanName + ".html");
        log.debug("生成添加页面：{}模板", beanName);

        text = getTemplete("htmlUpdate.txt");
        text = text.replace("{beanParamName}", beanParamName);
        text = text.replace("{addDivs}", getAddDivs(beanFieldNames));
        text = text.replace("{initData}", getInitData(beanFieldNames));
        FileUtil.saveTextFile(text, path + File.separator + "update" + beanName + ".html");
        log.debug("生成修改页面：{}模板", beanName);
    }

    private static CharSequence getInitData(List<String> beanFieldNames) {
        StringBuilder builder = new StringBuilder();
        beanFieldNames.forEach(b -> builder.append("\t\t\t\t\t\t$('#").append(b).append("').val(data.").append(b).append(");\n"));

        return builder.toString();
    }

    private static String getAddDivs(List<String> beanFieldNames) {
        StringBuilder builder = new StringBuilder();
        String id = "id";
        String createTime = "createTime";
        String updateTime = "updateTime";


        beanFieldNames.forEach(b -> {
            if (!id.equals(b) && !createTime.equals(b) && !updateTime.equals(b)) {
                builder.append("\t\t\t<div class='form-group'>\n");
                builder.append("\t\t\t\t<label class='col-md-2 control-label'>").append(b).append("</label>\n");
                builder.append("\t\t\t\t<div class='col-md-10'>\n");
                builder.append("\t\t\t\t\t<input class='form-control' placeholder='").append(b).append("' type='text' name='").append(b).append("' id='").append(b).append("' data-bv-notempty='true' data-bv-notempty-message='").append(b).append(" 不能为空'>\n");
                builder.append("\t\t\t\t</div>\n");
                builder.append("\t\t\t</div>\n");
            }
        });
        return builder.toString();
    }

    private static String getHtmlThs(List<String> beanComments, List<String> beanFieldNames) {
        StringBuilder builder = new StringBuilder();
        if (beanComments.stream().allMatch(StringUtils::isEmpty)) {
            beanFieldNames.forEach(b -> builder.append("\t\t\t\t\t\t\t\t\t<th>{beanFieldName}</th>\n".replace("{beanFieldName}", b)));
        } else {
            beanComments.forEach(b -> builder.append("\t\t\t\t\t\t\t\t\t<th>{beanFieldName}</th>\n".replace("{beanFieldName}", StringUtils.isEmpty(b) ? "TO RENAME" : b)));
        }

        return builder.toString();
    }

    private static String getHtmlColumnsDatas(List<String> beanFieldNames) {
        StringBuilder builder = new StringBuilder();
        beanFieldNames.forEach(b -> builder.append("\t\t\t\t{\"data\" : \"{beanFieldName}\", \"defaultContent\" : \"\"},\n"
                .replace("{beanFieldName}", b)));
        return builder.toString();
    }

}
