package com.anonymous.fastdfs;

import java.io.Serializable;

public interface FileManagerConfig extends Serializable {

	public static final String FILE_DEFAULT_AUTHOR = "lujiawei";

    public static final String PROTOCOL = "http://";

    public static final String SEPARATOR = "/";
    
    public static final String PROT = "80";

    public static final String TRACKER_NGNIX_ADDR = "0gmg8ue.hk1.mofasuidao.cn";
    
    public static final String TRACKER_NGNIX_PORT = "";

    public static final String CLIENT_CONFIG_FILE = "fdfs_client.conf";
}
