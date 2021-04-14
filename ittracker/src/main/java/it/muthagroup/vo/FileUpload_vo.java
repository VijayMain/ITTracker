package it.muthagroup.vo;

import java.io.InputStream;

public class FileUpload_vo {
	InputStream blob_file;
	String filename;

	public InputStream getBlob_file() {
		return blob_file;
	}

	public void setBlob_file(InputStream blob_file) {
		this.blob_file = blob_file;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}
}
