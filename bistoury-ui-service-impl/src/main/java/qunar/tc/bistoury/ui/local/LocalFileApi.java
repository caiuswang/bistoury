package qunar.tc.bistoury.ui.local;

import qunar.tc.bistoury.serverside.bean.ApiResult;

import java.io.IOException;

public interface LocalFileApi {

    ApiResult file(final String projectId, final String path, final String ref) throws IOException;

    ApiResult fileByClass(final String projectId, final String ref, final String module, final String className) throws IOException;

    void destroy();
}
