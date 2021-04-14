package it.muthagroup.vo;

import java.io.InputStream;

public class Photo_vo {
	int uid;
	InputStream blob_photo;
	String photofilename;

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public InputStream getBlob_photo() {
		return blob_photo;
	}

	public void setBlob_photo(InputStream blob_photo) {
		this.blob_photo = blob_photo;
	}

	public String getPhotofilename() {
		return photofilename;
	}

	public void setPhotofilename(String photofilename) {
		this.photofilename = photofilename;
	}

}
