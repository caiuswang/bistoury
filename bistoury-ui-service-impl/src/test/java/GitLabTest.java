import com.google.common.base.Charsets;
import org.gitlab.api.GitlabAPI;
import org.gitlab.api.TokenType;
import org.gitlab.api.http.Query;
import org.gitlab.api.models.GitlabProject;
import qunar.tc.bistoury.common.AESCryptUtils;
import qunar.tc.bistoury.common.Base64;
import qunar.tc.bistoury.serverside.common.UUIDUtil;
import qunar.tc.bistoury.serverside.util.ResultHelper;
import qunar.tc.bistoury.ui.model.GitlabFile;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.List;
import java.util.UUID;

public class GitLabTest {
    public static void main(String[] args) throws Exception {
        GitlabAPI gitlab = GitlabAPI.connect("https://gitlab.corp.totok.co", "EHxkwy21mzxFf1VXiNcN", TokenType.ACCESS_TOKEN);
//        List<GitlabProject> projects = gitlab.getProjects();
//        GitlabProject project1 = gitlab.getProject(546);
//        System.out.println(project1.getName());
//        for (GitlabProject project : projects) {
//            System.out.println(project.getName());
//            System.out.println(project.getId());
//            if (project.getName().equals("tkl-h5-api")) {
//                System.out.println(project.getId());
//                break;
//            }
//        }
        String filePathFormat ="{0}src/main/java/{1}.java";
        String className = "com.lucky.lottery.h5.api.web.H5WebApplication";
        String ref = "master";
        String filepath = MessageFormat.format(filePathFormat, "", className.replace(".", "/"));
//        final Query query = new Query().append("file_path", filepath).append("ref", ref);
//        final String url = "/projects/" + 168 + "/repository/files" + query.toString();
        byte[] rawFileContent = gitlab.getRawFileContent(168, ref, filepath);
        System.out.println(new String(rawFileContent));
        String accessToken ="EHxkwy21mzxFf1VXiNcN";
        System.out.println(new String(Base64.getEncoder().encode(AESCryptUtils.encrypt(accessToken.getBytes(Charsets.UTF_8))), Charsets.UTF_8));
    }
}
