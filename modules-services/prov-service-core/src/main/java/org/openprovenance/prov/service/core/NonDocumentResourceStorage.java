package org.openprovenance.prov.service.core;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.openprovenance.prov.interop.Formats;
import org.openprovenance.prov.model.Document;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public interface NonDocumentResourceStorage {
    String newStore(String suggestedExtension, String mimeType) throws IOException;
    void copyInputStreamToStore(InputStream inputStream, String id) throws IOException;
    void copyStringToStore(CharSequence str, String id) throws IOException;

    void serializeObjectToStore(ObjectMapper om, Object o, String id) throws IOException;

    void copyStoreToOutputStream(String id, OutputStream outputStream) throws IOException;

    <T> T deserializeObjectFromStore(ObjectMapper om, String id, Class<T> clazz) throws IOException;

    boolean delete(String storageId);
}
