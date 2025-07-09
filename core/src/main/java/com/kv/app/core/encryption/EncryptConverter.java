package com.kv.app.core.encryption;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class EncryptConverter implements AttributeConverter<String,String> {
    @Override
    public String convertToDatabaseColumn(String data) {
        return EncryptUtil.encrypt(data);
    }

    @Override
    public String convertToEntityAttribute(String data) {
        return EncryptUtil.decrypt(data);
    }
}
